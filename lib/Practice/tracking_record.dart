import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pigeon_tracker/Appbar/appbar_code.dart';
import '../Database_Helper_New/database_helper_new.dart';

class TrackingRecord extends StatefulWidget {
  const TrackingRecord({super.key});

  @override
  State<TrackingRecord> createState() => _TrackingRecordState();
}

class _TrackingRecordState extends State<TrackingRecord> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _records = [];
  bool isEditMode = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<TimeOfDay?> landedTimes = [];
  List<String> averages = [];
  String totalAverage = '00:00';

  Future<void> _fetchRecords() async {
    try {
      final records = await DatabaseHelperNew.instance.fetchRecords();

      if (mounted) {
        setState(() {
          _records = records;
          _isLoading = false;
          landedTimes = List<TimeOfDay?>.filled(_records.length, null);
          averages = List<String>.filled(_records.length, '00:00');
        });
      }
      print("Fetched Records: $_records");
    } catch (e) {
      print("Error fetching records: $e");
    }
  }

  Future<void> _selectTime(BuildContext context, int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        landedTimes[index] = picked;
        _calculateAverage(index);
      });
    }
  }

  void _calculateAverage(int index) {
    if (landedTimes[index] != null) {
      final record = _records[index];
      final flyingTime =
          TimeOfDay.fromDateTime(DateTime.parse(record['flyingTime']));
      final landedTime = landedTimes[index]!;

      final flyingMinutes = flyingTime.hour * 60 + flyingTime.minute;
      final landedMinutes = landedTime.hour * 60 + landedTime.minute;
      final difference = landedMinutes - flyingMinutes;

      final hours = difference ~/ 60;
      final minutes = difference % 60;

      setState(() {
        averages[index] =
            '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
        _calculateTotalAverage();
      });
    }
  }

  void _calculateTotalAverage() {
    int totalMinutes = 0;
    int count = 0;

    for (int i = 0; i < averages.length; i++) {
      if (averages[i] != '00:00' && i != averages.length - 1) {
        // Exclude baby bird
        final parts = averages[i].split(':');
        totalMinutes += int.parse(parts[0]) * 60 + int.parse(parts[1]);
        count++;
      }
    }

    if (count > 0) {
      final averageMinutes = totalMinutes ~/ count;
      final hours = averageMinutes ~/ 60;
      final minutes = averageMinutes % 60;
      setState(() {
        totalAverage =
            '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
      });
    }
  }

  void _updateRecords() {
    // Update records in the database
    // You can implement this based on your database structure
    setState(() {
      isEditMode = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchRecords();
  }

  Widget buildViewMode() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_records.isEmpty) {
      return Center(child: Text('No records found'));
    }

    final record = _records.first;
    int totalBirds = record['totalBirds'] ?? 0;
    List<String> birdNames = [];
    if (record['birdsNames'] != null &&
        record['birdsNames'].toString().isNotEmpty) {
      birdNames = record['birdsNames'].toString().split(',');
    }
    record['babybirdname'] ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Tracking Record',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 125),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    offset: Offset(0, 2), // Shadow position
                    blurRadius: 4, // Shadow blur
                  ),
                ],
                color: Color.fromRGBO(56, 0, 109, 1), // Correct color syntax
                borderRadius: BorderRadius.circular(50),
              ),
              height: 40,
              width: 40,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    isEditMode = !isEditMode;
                  });
                },
                icon: Icon(Icons.edit, color: Colors.white),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Text(
              'Loft Name:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(width: 10),
            Text(
              record['loftName'],
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Text(
              'Start:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(width: 10),
            Text(
              '${record['flyingDate']} ${record['flyingTime']}',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
        SizedBox(height: 16),
        Table(
          columnWidths: const {
            0: FixedColumnWidth(50),
            1: FlexColumnWidth(),
            2: FixedColumnWidth(80),
            3: FixedColumnWidth(80),
          },
          border: TableBorder.all(color: Colors.grey.shade300),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey.shade200),
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Nr.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Bird Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Landed',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Average',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: totalBirds + 1,
            itemBuilder: (context, index) {
              if (index < totalBirds) {
                return Table(
                  columnWidths: const {
                    0: FixedColumnWidth(50),
                    1: FlexColumnWidth(),
                    2: FixedColumnWidth(80),
                    3: FixedColumnWidth(80),
                  },
                  border: TableBorder.all(color: Colors.grey.shade300),
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${index + 1}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            birdNames.length > index ? birdNames[index] : '',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return Table(
                  columnWidths: const {
                    0: FixedColumnWidth(50),
                    1: FlexColumnWidth(),
                    2: FixedColumnWidth(80),
                    3: FixedColumnWidth(80),
                  },
                  border: TableBorder.all(color: Colors.grey.shade300),
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '1',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            record['babybirdname'] ?? '',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 250.0, left: 2, right: 2),
          child: Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: Row(
              children: [
                SizedBox(width: 150),
                Text(
                  'Total Average',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 25),
                Text(
                  totalAverage,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildEditMode() {
    if (_records.isEmpty) {
      return Center(child: Text('No records found'));
    }

    final record = _records.first;
    int totalBirds = record['totalBirds'] ?? 0;
    List<String> birdNames = [];
    if (record['birdsNames'] != null &&
        record['birdsNames'].toString().isNotEmpty) {
      birdNames = record['birdsNames'].toString().split(',');
    }
    record['babybirdname'] ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Update Tracking Record',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 40),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    offset: Offset(0, 2), // Shadow position
                    blurRadius: 4, // Shadow blur
                  ),
                ],
                color: Color.fromRGBO(56, 0, 109, 1), // Correct color syntax
                borderRadius: BorderRadius.circular(50),
              ),
              height: 40,
              width: 40,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    isEditMode = !isEditMode;
                  });
                },
                icon: Icon(Icons.menu_open, color: Colors.white),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Text(
              'Loft Name:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(width: 10),
            Text(
              record['loftName'],
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Text(
              'Start:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(width: 10),
            Text(
              '${record['flyingDate']} ${record['flyingTime']}',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
        SizedBox(height: 16),
        Table(
          columnWidths: const {
            0: FixedColumnWidth(50),
            1: FlexColumnWidth(),
            2: FixedColumnWidth(80),
            3: FixedColumnWidth(80),
          },
          border: TableBorder.all(color: Colors.grey.shade300),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey.shade200),
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Nr.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Bird Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Landed',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Average',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: totalBirds + 1,
            itemBuilder: (context, index) {
              if (index < totalBirds) {
                return Table(
                  columnWidths: const {
                    0: FixedColumnWidth(50),
                    1: FlexColumnWidth(),
                    2: FixedColumnWidth(80),
                    3: FixedColumnWidth(80),
                  },
                  border: TableBorder.all(color: Colors.grey.shade300),
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${index + 1}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            birdNames.length > index ? birdNames[index] : '',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            onPressed: () => _selectTime(context, index),
                            child: Text(
                              landedTimes[index]?.format(context) ??
                                  'Select Time',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            averages[index],
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return Table(
                  columnWidths: const {
                    0: FixedColumnWidth(50),
                    1: FlexColumnWidth(),
                    2: FixedColumnWidth(80),
                    3: FixedColumnWidth(80),
                  },
                  border: TableBorder.all(color: Colors.grey.shade300),
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '1',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            record['babybirdname'] ?? '',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 250.0, left: 2, right: 2),
          child: Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: Row(
              children: [
                SizedBox(width: 150),
                Text(
                  'Total Average',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 25),
                Text(
                  totalAverage,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _updateRecords,
          child: Text('Update'),
        ),
      ],
    );
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
        child: isEditMode ? buildEditMode() : buildViewMode(),
      ),
      currentScreen: 'TrackingRecord',
    );
  }
}
