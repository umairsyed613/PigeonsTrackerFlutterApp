// import 'package:flutter/material.dart';
// import 'package:pigeon_tracker/Auth_Screens/login_screen.dart';
// import 'package:pigeon_tracker/Home_Screens/create_tournaments.dart';
//
// class MyTournaments extends StatefulWidget {
//   const MyTournaments({super.key});
//
//   @override
//   State<MyTournaments> createState() => _MyTournamentsState();
// }
//
// class _MyTournamentsState extends State<MyTournaments> {
//   int count = 0;
//   bool isExpanded = false;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (_scaffoldKey.currentState!.isDrawerOpen) {
//           Navigator.pop(context); // Close the drawer
//           return true; // Prevent navigation
//         }
//         return true; // Allow navigation
//       },
//       child: SafeArea(
//         child: Scaffold(
//           backgroundColor: Colors.white,
//           key: _scaffoldKey,
//           appBar: AppBar(
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     // Icon(Icons.menu, color: Colors.white),// Space between icon and title
//                     Text(
//                       'PigeonsTracker',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 20.0),
//                       child: Text(
//                         ' (v3.25)',
//                         style: TextStyle(
//                           color: Colors.white.withOpacity(0.7),
//                           fontSize: 12,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 18.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       IconButton(
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => LoginScreen()));
//                           },
//                           icon: Icon(
//                             Icons.logout,
//                             color: Colors.white,
//                           )),
//                       IconButton(
//                           onPressed: () {},
//                           icon: Icon(
//                             Icons.language,
//                             color: Colors.white,
//                           )),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             iconTheme: IconThemeData(
//               color: Colors.white, // Drawer icon ka color
//             ),
//             backgroundColor: Color.fromRGBO(56, 0, 109, 1),
//             // Purple Background
//             elevation: 10.0,
//             shadowColor: Colors.black, // Shadow depth
//           ),
//           body: Column(
//             children: [
//               Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 170.0, top: 10),
//                     child: Text(
//                       'My Tournaments',
//                       style: TextStyle(
//                           fontSize: 25,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.pinkAccent),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 18.0, left: 10),
//                     child: Text(
//                       'No Records found, please create new records by pressing the + button bellow',
//                       style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black54),
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Card(
//                   elevation: 2,
//                   child: ListTile(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5)),
//                     tileColor: Color.fromARGB(100, 175, 113, 136),
//                     leading: Icon(Icons.emoji_events_outlined),
//                     trailing:
//                         IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
//                     title: Text('title'),
//                     subtitle: Column(
//                       children: [
//                         Row(
//                           children: [
//                             Text('Start'),
//                             Text('14 december 2024'),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Text('End'),
//                             Text('21 december 2024'),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//           floatingActionButton: FloatingActionButton(
//             child: Icon(
//               Icons.add,
//               color: Colors.white,
//             ),
//             onPressed: navigateToAddPage,
//             backgroundColor: Color.fromRGBO(56, 0, 109, 1),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void navigateToAddPage() {
//     Navigator.push(context, MaterialPageRoute(builder: (context) {
//       return CreateTournaments();
//     }));
//   }
// }
// // ListView.builder(
// //    itemCount: count,
// //   itemBuilder: (BuildContext context, int position){
// //     final note = notes[position];
// //     return Card(
// //       color: Colors.grey[600],
// //       elevation: 2.0,
// //       child: ListTile(
// //         leading: Icon(Icons.emoji_events_outlined),
// //         title: Text(note.title),
// //         subtitle: Text(note.description),
// //           trailing: IconButton(
// //             icon: Icon(Icons.delete),
// //             onPressed: () {
// //
// //             }
// //           )
// //       ),
// //     );
// //   },
// // ),
// // drawer: Drawer(
// // child: Column(
// // children: [
// // SizedBox(
// // height: 20,
// // ),
// // Image.asset(
// // 'assets/images/1.png',
// // height: 100,
// // ),
// // SizedBox(
// // height: 20,
// // ),
// // ListTile(
// // onTap: () {
// // Navigator.push(context,
// // MaterialPageRoute(builder: (context) => HomeScreen()));
// // },
// // tileColor: Colors.grey[350],
// // title: Text(
// // 'Home',
// // style: TextStyle(
// // color: Color.fromRGBO(56, 0, 109, 1),
// // ),
// // ),
// // leading: Icon(
// // Icons.home,
// // color: Colors.grey[600],
// // ),
// // ),
// // ListTile(
// // onTap: () {
// // Navigator.push(context,
// // MaterialPageRoute(builder: (context) => Tournaments()));
// // },
// // title: Text(
// // 'Tournaments',
// // style: TextStyle(color: Colors.black),
// // ),
// // leading: Icon(
// // Icons.emoji_events,
// // color: Colors.grey[600],
// // ),
// // ),
// // ListTile(
// // leading: Icon(
// // Icons.directions_run,
// // color: Colors.grey[600],
// // ),
// // title: Text('Private'),
// // trailing: IconButton(
// // icon: Icon(
// // isExpanded ? Icons.expand_less : Icons.expand_more),
// // onPressed: () {
// // setState(() {
// // isExpanded = !isExpanded; // Toggle expansion
// // });
// // },
// // ),
// // ),
// // if (isExpanded) // Show options only if expanded
// // Padding(
// // padding: const EdgeInsets.symmetric(horizontal: 20.0),
// // child: Column(
// // children: [
// // ListTile(
// // leading: Icon(
// // Icons.monitor_heart,
// // color: Colors.grey[600],
// // ),
// // title: Text('Practice'),
// // onTap: () {
// // Navigator.push(
// // context,
// // MaterialPageRoute(
// // builder: (context) => Practice()));
// // setState(() {
// // isExpanded = false;
// // });
// // },
// // ),
// // ListTile(
// // leading: Icon(
// // Icons.grid_view,
// // color: Colors.grey[600],
// // ),
// // title: Text('My Tournaments'),
// // onTap: () {
// // Navigator.push(
// // context,
// // MaterialPageRoute(
// // builder: (context) => MyTournaments()));
// // setState(() {
// // isExpanded = false;
// // });
// // },
// // ),
// // ],
// // ),
// // ),
// // ListTile(
// // onTap: () {
// // Navigator.push(
// // context,
// // MaterialPageRoute(
// // builder: (context) => DiseasesCure()));
// // },
// // title: Text(
// // 'Diseases And Cure',
// // style: TextStyle(color: Colors.black),
// // ),
// // leading: Icon(
// // Icons.ac_unit,
// // color: Colors.grey[600],
// // ),
// // ),
// // ListTile(
// // onTap: () {
// // Navigator.push(
// // context,
// // MaterialPageRoute(
// // builder: (context) => InformationScreen()));
// // },
// // title: Text(
// // 'Information',
// // style: TextStyle(color: Colors.black),
// // ),
// // leading: Icon(
// // Icons.info,
// // color: Colors.grey[700],
// // ),
// // ),
// // ListTile(
// // onTap: () {
// // Navigator.push(
// // context,
// // MaterialPageRoute(
// // builder: (context) => ContactScreen()));
// // },
// // title: Text(
// // 'Contact',
// // style: TextStyle(color: Colors.black),
// // ),
// // leading: Icon(
// // Icons.phone,
// // color: Colors.grey[700],
// // ),
// // ),
// // ListTile(
// // onTap: () {
// // Navigator.push(
// // context,
// // MaterialPageRoute(
// // builder: (context) => SettingScreen()));
// // },
// // title: Text(
// // 'Setting',
// // style: TextStyle(color: Colors.black),
// // ),
// // leading: Icon(
// // Icons.settings,
// // color: Colors.grey[700],
// // ),
// // )
// // ],
// // ),
// // width: 250,
// // backgroundColor: Colors.white,
// // ),
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
          body: Column(
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
                                    leading: Icon(Icons.emoji_events_outlined),
                                    trailing: IconButton(
                                      onPressed: () =>
                                          _deleteTournament(tournament['id']),
                                      icon: Icon(Icons.delete),
                                    ),
                                    title: Text(tournament['name']),
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
