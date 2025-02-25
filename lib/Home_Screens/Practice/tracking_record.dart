import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pigeon_tracker/appbar_code.dart';
import '../../database_helper_new.dart';

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

  Future<void> _fetchRecords() async {
    try {
      final records = await DatabaseHelperNew.instance.fetchRecords();

      if (mounted) {
        setState(() {
          _records = records;
          _isLoading = false;
        });
      }
      print("Fetched Records: $_records");
    } catch (e) {
      print("Error fetching records: $e");
    }
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

    // Assuming only one record for simplicity
    final record = _records.first;
    print("Fetched record: $record");
    print("Birds Names: ${record['birdsNames']}");
    print("Baby Bird: ${record['babybirdname']}");

    int totalBirds = record['totalBirds'] ?? 0;
    // Use the correct column name for normal birds
    List<String> birdNames = [];
    if (record['birdsNames'] != null &&
        record['birdsNames'].toString().isNotEmpty) {
      birdNames = record['birdsNames'].toString().split(',');
    }
    record['babybirdname'] ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header and edit icon
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
                  ),
                ],
                color: Color.fromRGBO(56, 0, 109, 1),
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
        // Loft name & start details
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
        // Table Headers
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
        // Table Rows: Normal birds + baby bird row
        Expanded(
          child: ListView.builder(
            itemCount: totalBirds + 1, // extra row for baby bird
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
                // Baby Bird Row: use correct column for baby bird name
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
                            '1', // Number column for baby bird
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
        // Total Average row below the table
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
                  '00:00',
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
    // Implement edit mode functionality here if needed
    return Center(child: Text('Edit Mode'));
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
    );
  }
}