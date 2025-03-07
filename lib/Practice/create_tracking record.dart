import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pigeon_tracker/Practice/tracking_record.dart';
import 'package:pigeon_tracker/Appbar/appbar_code.dart';
import '../Database_Helper_New/database_helper_new.dart';

class CreateTrackingRecord extends StatefulWidget {
  const CreateTrackingRecord({super.key});

  @override
  State<CreateTrackingRecord> createState() => _CreateTrackingRecordState();
}

class _CreateTrackingRecordState extends State<CreateTrackingRecord> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _loftNameController = TextEditingController();
  final TextEditingController _flyingDateController = TextEditingController();
  final TextEditingController _flyingTimeController = TextEditingController();
  final TextEditingController _babyBirdController = TextEditingController();
  final List<TextEditingController> _birdNameControllers = [];

  int _totalBirds = 1;
  bool _isBabyBird = false;
  bool showBirdFields = false;

  Future<void> _saveRecord() async {
    print("🟢 _saveRecord() called!"); // Debugging print
    if (_formKey.currentState!.validate()) {
      List<String> birdNames = _birdNameControllers
          .map((controller) => controller.text.trim())
          .toList();
      String babyBirdName =
          _isBabyBird ? _babyBirdController.text.trim() : "No baby bird";

      final record = {
        'loftName': _loftNameController.text.trim(),
        'flyingDate': _flyingDateController.text.trim(),
        'flyingTime': _flyingTimeController.text.trim(),
        'totalBirds': _totalBirds,
        'birdsNames': birdNames.isNotEmpty ? birdNames.join(',') : 'No birds',
        'babybirdname': babyBirdName,
      };

      print("🟢 Saving record: $record"); // Debugging print

      int id = await DatabaseHelperNew.instance.insertRecord(record);
      if (id > 0) {
        print("✅ Record saved successfully! ID: $id"); // Debugging print
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Record saved successfully!')),
        );
      } else {
        print("❌ Error saving record!"); // Debugging print
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error saving record!')),
        );
      }
    } else {
      print("❌ Form validation failed!"); // Debugging print
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  void _onSubmit() {
    List<String> birdNames =
        _birdNameControllers.map((controller) => controller.text).toList();
    String babyBirdName =
        _isBabyBird ? _babyBirdController.text : "No baby bird";

    print("Bird Names: $birdNames");
    print("Baby Bird: $babyBirdName");
  }

  @override
  Widget build(BuildContext context) {
    return AppbarCode(
      title: 'Pg text'.tr,
      child: WillPopScope(
        onWillPop: () async {
          if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
            Navigator.pop(context);
            return false;
          }
          return true;
        },
        child: SafeArea(
          child: Directionality(
            textDirection: Get.locale?.languageCode == 'en'
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Tracking Record',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _loftNameController,
                  decoration: InputDecoration(
                    labelText: 'Loft Name*',
                    border: UnderlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the loft name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _flyingDateController,
                  decoration:
                      const InputDecoration(labelText: 'Flying Start Date'),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      _flyingDateController.text =
                          '${date.year}-${date.month}-${date.day}';
                    }
                  },
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _flyingTimeController,
                  decoration:
                      const InputDecoration(labelText: 'Flying Start Time'),
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      _flyingTimeController.text = time.format(context);
                    }
                  },
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<int>(
                  value: _totalBirds,
                  decoration: InputDecoration(
                    labelText: 'Total Birds',
                    border: UnderlineInputBorder(),
                  ),
                  items: List.generate(
                    50,
                    (index) => DropdownMenuItem(
                      value: index + 1,
                      child: Text('${index + 1}'),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _totalBirds = value!;
                      // Clear and rebuild bird controllers when totalBirds changes
                      _birdNameControllers.clear();
                    });
                  },
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Baby Bird"),
                    Switch(
                      value: _isBabyBird,
                      onChanged: (value) {
                        setState(() {
                          _isBabyBird = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(56, 0, 109, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      _onSubmit();
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          showBirdFields = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Tracking Record Created!')),
                        );
                      }
                    },
                    child: Text(
                      'SUBMIT',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                if (showBirdFields && _totalBirds != null) ...[
                  SizedBox(height: 20),
                  Text(
                    "Birds Information",
                    style: TextStyle(
                      color: Color.fromRGBO(56, 0, 109, 1),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _totalBirds,
                    itemBuilder: (context, index) {
                      if (_birdNameControllers.length <= index) {
                        _birdNameControllers.add(TextEditingController());
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(56, 0, 109, 1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                    controller: _birdNameControllers[index],
                                    decoration: InputDecoration(
                                      labelText: "Bird Name",
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter bird name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            // Show baby bird field only for the last row if _isBabyBird is true
                            if (_isBabyBird && index == _totalBirds - 1) ...[
                              SizedBox(height: 20),
                              Text(
                                "Baby Bird",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(56, 0, 109, 1),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: _babyBirdController,
                                decoration: InputDecoration(
                                  labelText: "Baby Bird Name",
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (_isBabyBird &&
                                      (value == null || value.isEmpty)) {
                                    return 'Enter baby bird name';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        print("Submit button pressed!");
                        _saveRecord();
                        print("Data saving process initiated!");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TrackingRecord(),
                          ),
                        );
                      },
                      child: Text(
                        "SUBMIT",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(56, 0, 109, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ), currentScreen: 'CreateTrackingRecord',
    );
  }
}
