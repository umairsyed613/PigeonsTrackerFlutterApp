import 'package:flutter/material.dart';
import 'package:pigeon_tracker/Home_Screens/create_tournaments.dart';

class MyTournaments extends StatefulWidget {
  const MyTournaments({super.key});

  @override
  State<MyTournaments> createState() => _MyTournamentsState();
}

class _MyTournamentsState extends State<MyTournaments> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 170.0, top: 10),
                child: Text(
                  'My Tournaments',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.pinkAccent),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 10),
                child: Text(
                  'No Records found, please create new records by pressing the + button bellow',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add,color: Colors.white,),
              onPressed: navigateToAddPage,backgroundColor:Color.fromRGBO(56, 0, 109, 1),),
        ),
      ),
    );
  }
  void navigateToAddPage() {
    final route = MaterialPageRoute(builder: (context) => CreateTournaments());
    Navigator.push(context, route);
  }
}
