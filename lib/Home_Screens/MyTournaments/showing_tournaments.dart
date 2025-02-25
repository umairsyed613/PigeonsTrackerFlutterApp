import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pigeon_tracker/Home_Screens/Practice/create_tracking%20record.dart';
import 'package:pigeon_tracker/appbar_code.dart';
import 'package:sqflite/sqflite.dart';

import 'create_tournaments.dart';

class TournamentDetailsPage extends StatefulWidget {
  const TournamentDetailsPage({super.key});

  @override
  _TournamentDetailsPageState createState() => _TournamentDetailsPageState();
}

class _TournamentDetailsPageState extends State<TournamentDetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = true;
  bool isExpanded = false;
  List<Map<String, dynamic>> _tournaments = [];
  final DatabaseHelper dbHelper = DatabaseHelper();

  Future<void> _fetchTournaments() async {
    Database db = await dbHelper.database;
    List<Map<String, dynamic>> tournaments = await db.query('tournaments');
    setState(() {
      _tournaments = tournaments;
      _isLoading = false;
    });
  }

  void initState() {
    super.initState();
    _fetchTournaments();
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _tournaments.length,
              itemBuilder: (context, index) {
                final tournament = _tournaments[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          tournament['name'],
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.pinkAccent,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text('Start: '),
                                const SizedBox(width: 10),
                                Text(tournament['start_date']),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text('End: '),
                                const SizedBox(width: 10),
                                Text(tournament['end_date']),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: Colors.grey), // Light horizontal line
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          'No Records found, please create new records by pressing the + button below',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: const Color.fromRGBO(56, 0, 109, 1),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTrackingRecord()));
        },
      ),
    );
  }
}
