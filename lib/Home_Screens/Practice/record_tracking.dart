import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pigeon_tracker/appbar_code.dart';

class RecordTracking extends StatefulWidget {
  const RecordTracking({super.key});

  @override
  State<RecordTracking> createState() => _RecordTrackingState();
}

class _RecordTrackingState extends State<RecordTracking> {
  Widget buildViewMode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              isEditMode ? 'Update Tracking Record' : 'Tracking Record',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 125,
            ),
            Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                    ),
                  ],
                  color: Color.fromRGBO(56, 0, 109, 1),
                  borderRadius: BorderRadius.circular(50)),
              height: 40,
              width: 40,
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      isEditMode = !isEditMode; // Toggle the mode
                    });
                  },
                  icon: Icon(Icons.edit, color: Colors.white)),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              'Loft Name:',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Start:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 10,
              width: 95,
            ),
            Text(
              '25 December 2024 12:00 AM',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 16),

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
        Expanded(
          child: ListView.builder(
            itemCount: 7, // Replace with dynamic count if needed
            itemBuilder: (context, index) {
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
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(''),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 250.0, left: 2, right: 2),
          child: Container(
            child: Row(
              children: [
                SizedBox(
                  width: 150,
                ),
                Text(
                  'Total Average',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 25,
                ),
                Text(
                  '00:00',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.grey[200]),
          ),
        )
      ],
    );
  }

  Widget buildEditMode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Update Tracking Record',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 40,
            ),
            Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                    ),
                  ],
                  color: Color.fromRGBO(56, 0, 109, 1),
                  borderRadius: BorderRadius.circular(50)),
              height: 40,
              width: 40,
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      isEditMode = !isEditMode; // Toggle the mode
                    });
                  },
                  icon: Icon(Icons.menu_open, color: Colors.white)),
            )
          ],
        ),
        TextField(
          decoration: const InputDecoration(
            labelText: 'Loft Name',
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Text(
              'Start:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: '12:00 AM',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: 7,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                // Adds space between rows
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        initialValue: '${index + 1}',
                        enabled: false,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade700),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      flex: 4,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: '',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: '--:-- --',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    IconButton(
                      icon: Icon(Icons.access_time),
                      onPressed: () {
                        // Handle time picker logic
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 40,
          child: ElevatedButton(
            onPressed: () {},
            child: Text(
              "Update",
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
    );
  }

  bool isEditMode = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
          textDirection: Locale == 'en' ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white,
          ),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isEditMode ? buildEditMode() : buildViewMode(),
      ),
    );
  }
}
