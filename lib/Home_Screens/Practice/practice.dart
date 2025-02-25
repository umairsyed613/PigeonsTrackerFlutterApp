import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pigeon_tracker/Home_Screens/Practice/create_tracking%20record.dart';
import 'package:pigeon_tracker/Home_Screens/Practice/tracking_record.dart';
import 'package:pigeon_tracker/appbar_code.dart';
import 'package:pigeon_tracker/database_helper_new.dart';
import 'package:sqflite/sqflite.dart';

class Practice extends StatefulWidget {
  const Practice({super.key});

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  bool _isLoading = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> _records = [];

  Future<void> _fetchRecords() async {
    try {
      final records = await DatabaseHelperNew.instance.fetchRecords();

      if (mounted) {
        setState(() {
          _records = records.map((record) {
            return {
              'id': record['id'], // Ensure ID is included
              'loftName': record['loftName'],
              'flyingDate': record['flyingDate'],
              'flyingTime': record['flyingTime'],
            };
          }).toList();
          _isLoading = false;
        });
      }
      print("Fetched Records: $_records");
    } catch (e) {
      print("Error fetching records: $e");
    }
  }

  Future<void> _showDeleteConfirmationDialog(int id) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Are you sure?"),
          content: const Text("Do you want to delete this record?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("No", style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _deleteRecords(id);
              },
              child: const Text("Yes", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteRecords(int id) async {
    Database db = await DatabaseHelperNew.instance.database;
    await db.delete('records', where: 'id = ?', whereArgs: [id]);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Record deleted successfully.')),
    );
    _fetchRecords();
  }

  @override
  void initState() {
    super.initState();
    _fetchRecords();
  }

  void navigateToAddPage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateTrackingRecord()),
    );
    _fetchRecords();
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
      body: RefreshIndicator(
        onRefresh: _fetchRecords,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 250),
              child: Text(
                'Practice text'.tr,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                ),
              ),
            ),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _records.isEmpty
                  ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'No Records found. Create new records using the + button below.',
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                itemCount: _records.length,
                itemBuilder: (context, index) {
                  final record = _records[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      tileColor:
                      const Color.fromARGB(100, 175, 113, 136),
                      leading: const Icon(
                        Icons.emoji_events_outlined,
                        size: 35,
                      ),
                      trailing: IconButton(
                        onPressed: () =>
                            _showDeleteConfirmationDialog(record['id']),
                        icon: const Icon(Icons.delete),
                      ),
                      title: Text(
                        'Loft Name: ${record['loftName']}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Flying Start Date: ${record['flyingDate']}'),
                          Text(
                              'Flying Start Time: ${record['flyingTime']}'),
                        ],
                      ),
                      onTap: () {
                        print("Selected Record: $record");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TrackingRecord(),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddPage,
        backgroundColor: Color.fromRGBO(56, 0, 109, 1),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
