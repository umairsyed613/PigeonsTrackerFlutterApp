import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pigeon_tracker/appbar_code.dart';
import 'package:pigeon_tracker/database_helper_new.dart';
import 'package:sqflite/sqflite.dart';

import 'create_tracking record.dart';

class Practice extends StatefulWidget {
  const Practice({super.key});

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> _records = [];

  Future<void> _fetchRecords() async {
    final records = await DatabaseHelperNew.instance.fetchRecords();
    setState(() {
      _records = records;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchRecords();
  }

  Future<void> _showDeleteConfirmationDialog(int id) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Are you sure?"),
          content: Text("Do you want to delete this tournament?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                "No",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                await _deleteTournament(id); // Perform delete
              },
              child: Text(
                "Yes",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
  Future<void> _deleteTournament(int id) async {
    Database db = (await DatabaseHelperNew) as Database;
    await db.delete('tournaments', where: 'id = ?', whereArgs: [id]);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Tournament deleted successfully.')),
    );
    _fetchRecords();
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
              backgroundColor: Colors.white,
              key: _scaffoldKey,
            ),
          ),
        ),
      ),
        body: _records.isEmpty
            ? const Center(
                child: Text(
                  'No Records found. Create new records using the + button below.',
                  textAlign: TextAlign.center,
                ),
              )
            : ListView.builder(
                itemCount: _records.length,
                itemBuilder: (context, index) {
                  final record = _records[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Loft Name: ${record['loftName']}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('Flying Start Date: ${record['flyinDgate']}'),
                          Text('Flying Start Time: ${record['flyingTime']}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TrackingRecord()),
            ).then((_) => _fetchRecords());
          },
          child: const Icon(Icons.add),
        ),

    );
  }
}
