import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pigeon_tracker/Home_Screens/Practice/record_tracking.dart';
import 'package:pigeon_tracker/appbar_code.dart';
import 'package:pigeon_tracker/database_helper_new.dart';

class TrackingRecord extends StatefulWidget {
  const TrackingRecord({super.key});

  @override
  State<TrackingRecord> createState() => _TrackingRecordState();
}

class _TrackingRecordState extends State<TrackingRecord> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController totalBirdsController = TextEditingController();

  // TextEditingController _loftNameController = TextEditingController();
  final TextEditingController _loftNameController = TextEditingController();
  final TextEditingController _flyingDateController = TextEditingController();
  final TextEditingController _flyingTimeController = TextEditingController();

  Future<void> _saveRecord() async {
    if (_loftNameController.text.isNotEmpty &&
        _flyingDateController.text.isNotEmpty &&
        _flyingTimeController.text.isNotEmpty) {
      final record = {
        'loftName': _loftNameController.text,
        'flyingDate': _flyingDateController.text,
        'flyingTime': _flyingTimeController.text,
      };
      await DatabaseHelperNew.instance.insertRecord(record);

      // Show success message and clear fields
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Record saved successfully!')),
      );
      _loftNameController.clear();
      _flyingDateController.clear();
      _flyingTimeController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  DateTime? _flyingStartDay;
  TimeOfDay? _flyingStartTime;
  int _totalBirds = 1;
  bool _isBabyBird = false;

  bool showBirdFields = false;
  int totalBirds = 0;

  Future<void> _pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _flyingStartDay = picked;
      });
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _flyingStartTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppbarCode(
      title: 'Pg text'.tr,
      child: WillPopScope(
          onWillPop: () async {
            if (_scaffoldKey.currentState!.isDrawerOpen) {
              Navigator.pop(context); // Close the drawer
              return true; // Prevent navigation
            }
            return true; // Allow navigation
          },
          child: SafeArea(
            child: Directionality(
              textDirection:
                  Locale == 'en' ? TextDirection.rtl : TextDirection.ltr,
              child: Scaffold(
                key: _scaffoldKey,
                backgroundColor: Colors.white,
              ),
            ),
          )),
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
                // GestureDetector(
                //   onTap: () => _pickDate(context),
                //   child: AbsorbPointer(
                //     child:
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
                //   ),
                // ),
                SizedBox(height: 10),
                // GestureDetector(
                //   onTap: () => _pickTime(context),
                //   child:
                //   AbsorbPointer(
                //     child:
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
                //   ),
                // ),
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
                    });
                  },
                ),
                SizedBox(height: 20),
                Text('Baby Bird'),
                SizedBox(height: 10),
                FlutterSwitch(
                  width: 55.0,
                  height: 30.0,
                  toggleSize: 20.0,
                  value: _isBabyBird,
                  borderRadius: 30.0,
                  activeColor: Color.fromRGBO(56, 0, 109, 1),
                  inactiveColor: Colors.grey.shade300,
                  onToggle: (val) {
                    setState(() {
                      _isBabyBird = val;
                    });
                  },
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
                      _saveRecord();
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
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
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
                                decoration: InputDecoration(
                                  labelText: "Bird Name",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
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
                        _saveRecord;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecordTracking()),
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
      ),
    );
  }
}
