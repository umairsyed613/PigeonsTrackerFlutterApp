import 'dart:ffi';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter/material.dart';

class TrackingRecord extends StatefulWidget {
  const TrackingRecord({super.key});

  @override
  State<TrackingRecord> createState() => _TrackingRecordState();
}

class _TrackingRecordState extends State<TrackingRecord> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _loftNameController = TextEditingController();
  DateTime? _flyingStartDay;
  TimeOfDay? _flyingStartTime;
  int _totalBirds = 1;
  bool _isBabyBird = false;

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
    return WillPopScope(
      onWillPop: () async {
        if (_scaffoldKey.currentState!.isDrawerOpen) {
          Navigator.pop(context); // Close the drawer
          return true; // Prevent navigation
        }
        return true; // Allow navigation
      },
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Icon(Icons.menu, color: Colors.white),// Space between icon and title
                    Text(
                      'PigeonsTracker',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        ' (v3.25)',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.logout,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.language,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
              ],
            ),
            iconTheme: IconThemeData(
              color: Colors.white, // Drawer icon ka color
            ),
            backgroundColor: Color.fromRGBO(56, 0, 109, 1),
            // Purple Background
            elevation: 10.0,
            shadowColor: Colors.black, // Shadow depth
          ),
          drawer: Drawer(
            width: 250,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
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
                  GestureDetector(
                    onTap: () => _pickDate(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Flying Start Day*',
                          border: UnderlineInputBorder(),
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        controller: TextEditingController(
                          text: _flyingStartDay != null
                              ? '${_flyingStartDay!.day}.${_flyingStartDay!.month}.${_flyingStartDay!.year}'
                              : '',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => _pickTime(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Flying Start Time*',
                          border: UnderlineInputBorder(),
                          suffixIcon: Icon(Icons.access_time),
                        ),
                        controller: TextEditingController(
                          text: _flyingStartTime != null
                              ? _flyingStartTime!.format(context)
                              : '',
                        ),
                      ),
                    ),
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
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text('Baby Bird'),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(right: 300.0),
                    child: FlutterSwitch(
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
                  ),
                  // Switch(
                  //   value: _isBabyBird,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       _isBabyBird = value;
                  //     });
                  //   },
                  //   activeColor: Color.fromRGBO(56, 0, 109, 1),
                  // ),
                  SizedBox(height: 30),
                  Center(
                    child: SizedBox(
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
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Tracking Record Created!')),
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}