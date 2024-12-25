
import 'package:flutter/material.dart';
import 'package:pigeon_tracker/Auth_Screens/login_screen.dart';
import 'package:pigeon_tracker/Home_Screens/create_tournaments.dart';
import 'package:sqflite/sqflite.dart';

class MyTournaments extends StatefulWidget {
  const MyTournaments({super.key});

  @override
  State<MyTournaments> createState() => _MyTournamentsState();
}

class _MyTournamentsState extends State<MyTournaments> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final DatabaseHelper dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> _tournaments = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTournaments();
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



  Future<void> _fetchTournaments() async {
    Database db = await dbHelper.database;
    List<Map<String, dynamic>> tournaments = await db.query('tournaments');
    setState(() {
      _tournaments = tournaments;
      _isLoading = false;
    });
  }

  Future<void> _deleteTournament(int id) async {
    Database db = await dbHelper.database;
    await db.delete('tournaments', where: 'id = ?', whereArgs: [id]);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Tournament deleted successfully.')),
    );
    _fetchTournaments();
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
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
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
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
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
            elevation: 10.0,
            shadowColor: Colors.black,
          ),
          body: RefreshIndicator(
            onRefresh: () => _fetchTournaments(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,right: 150),
                  child: Text(
                    'My Tournaments',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.pinkAccent),
                  ),
                ),
                Expanded(
                  child: _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : _tournaments.isEmpty
                          ? Padding(
                            padding: const EdgeInsets.only(bottom: 58.0),
                            child: Center(
                                child: Text(
                                  'No Records found, please create new records by pressing the + button below.',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                          )
                          : ListView.builder(
                              itemCount: _tournaments.length,
                              itemBuilder: (context, index) {
                                final tournament = _tournaments[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 2,
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5)),
                                      tileColor:
                                          Color.fromARGB(100, 175, 113, 136),
                                      leading: Icon(Icons.emoji_events_outlined,size: 35,),
                                      trailing: IconButton(
                                        onPressed: () => _showDeleteConfirmationDialog(tournament['id']),
                                        icon: Icon(Icons.delete),
                                      ),
            
                                      title: Text(tournament['name'],style: TextStyle(
                                        fontSize: 20,
                                      ),),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text('Start: '),
                                              Text(tournament['start_date']),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text('End: '),
                                              Text(tournament['end_date']),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: navigateToAddPage,
            backgroundColor: Color.fromRGBO(56, 0, 109, 1),
          ),
        ),
      ),
    );
  }

  void navigateToAddPage() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CreateTournaments();
    }));
    _fetchTournaments(); // Refresh list after returning from CreateTournaments page
  }
}
