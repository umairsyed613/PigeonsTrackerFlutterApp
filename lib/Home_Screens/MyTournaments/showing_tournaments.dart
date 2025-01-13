import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pigeon_tracker/appbar_code.dart';
class TournamentDetailsPage extends StatefulWidget {
  const TournamentDetailsPage({super.key});

  @override
  _TournamentDetailsPageState createState() => _TournamentDetailsPageState();
}

class _TournamentDetailsPageState extends State<TournamentDetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = true;
  bool isExpanded = false;
  final Map<String, dynamic> tournament = {
    "name": "Abc",
    "totalAverage": "00:00:00",
    "start": "07 January 2025",
    "end": "14 January 2025",
    "flyingRecords": [
      {
        "totalBirds": 7,
        "start": "07 January 2025 12:00 AM",
      },
    ],
  };

  void _deleteRecord(int index) {
    setState(() {
      tournament['flyingRecords'].removeAt(index);
    });
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
        child: Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tournament Name
            Text(
              tournament['name'],
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
            SizedBox(height: 8),
            // Tournament Details
            Text(
              "Total Average: ${tournament['totalAverage']}",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "Start: ${tournament['start']}",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "End: ${tournament['end']}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // Flying Day Record Title
            Text(
              "Flying Day Record",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            // Flying Day Records List
            Expanded(
              child: ListView.builder(
                itemCount: tournament['flyingRecords'].length,
                itemBuilder: (context, index) {
                  final record = tournament['flyingRecords'][index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Icon(Icons.access_time, color: Colors.black),
                      title: Text("Total Birds: ${record['totalBirds']}"),
                      subtitle: Text("Start: ${record['start']}"),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _deleteRecord(index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
