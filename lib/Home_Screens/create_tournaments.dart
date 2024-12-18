// import 'package:flutter/material.dart';
// import 'package:pigeon_tracker/Auth_Screens/login_screen.dart';
// import '../Database/db_connection.dart';
// import '../Database/note.dart';
//
// class CreateTournaments extends StatefulWidget {
//   const CreateTournaments({super.key});
//
//   @override
//   State<CreateTournaments> createState() => _CreateTournamentsState();
// }
//
// class _CreateTournamentsState extends State<CreateTournaments> {
//   bool isExpanded = false;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final _formKey = GlobalKey<FormState>();
//   final DatabaseHelper dbHelper = DatabaseHelper();
//   List<Note> notes = [];
//   TextEditingController _tournamentsNameController = TextEditingController();
//
//   DateTime? _startDate;
//   DateTime? _endDate;
//
//   Future<void> _pickDate(BuildContext context, bool isStartDate) async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );
//     if (picked != null) {
//       setState(() {
//         if (isStartDate) {
//           _startDate = picked;
//         } else {
//           _endDate = picked;
//         }
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (_scaffoldKey.currentState!.isDrawerOpen) {
//           Navigator.pop(context); // Close the drawer
//           return true;
//         }
//         return true;
//       },
//       child: SafeArea(
//           child: Scaffold(
//         backgroundColor: Colors.white,
//         key: _scaffoldKey,
//         appBar: AppBar(
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   // Icon(Icons.menu, color: Colors.white),// Space between icon and title
//                   Text(
//                     'PigeonsTracker',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 20.0),
//                     child: Text(
//                       ' (v3.25)',
//                       style: TextStyle(
//                         color: Colors.white.withOpacity(0.7),
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 18.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     IconButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => LoginScreen()));
//                         },
//                         icon: Icon(
//                           Icons.logout,
//                           color: Colors.white,
//                         )),
//                     IconButton(
//                         onPressed: () {},
//                         icon: Icon(
//                           Icons.language,
//                           color: Colors.white,
//                         )),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           iconTheme: IconThemeData(
//             color: Colors.white, // Drawer icon ka color
//           ),
//           backgroundColor: Color.fromRGBO(56, 0, 109, 1),
//           // Purple Background
//           elevation: 10.0,
//           shadowColor: Colors.black, // Shadow depth
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Create Tournament',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.pink,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   controller: _tournamentsNameController,
//                   decoration: InputDecoration(
//                     labelText: 'Tournament Name*',
//                     border: UnderlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a tournament name';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 GestureDetector(
//                   onTap: () => _pickDate(context, true),
//                   child: AbsorbPointer(
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         labelText: 'Start',
//                         border: OutlineInputBorder(),
//                         suffixIcon: Icon(Icons.calendar_today),
//                       ),
//                       controller: TextEditingController(
//                           text: _startDate != null
//                               ? '${_startDate!.month}/${_startDate!.day}/${_startDate!.year}'
//                               : ''),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 GestureDetector(
//                   onTap: () => _pickDate(context, false),
//                   child: AbsorbPointer(
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         labelText: 'End',
//                         border: OutlineInputBorder(),
//                         suffixIcon: Icon(Icons.calendar_today),
//                       ),
//                       controller: TextEditingController(
//                           text: _endDate != null
//                               ? '${_endDate!.month}/${_endDate!.day}/${_endDate!.year}'
//                               : ''),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 40),
//                 Center(
//                   child: SizedBox(
//                     width: double.infinity,
//                     height: 40,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color.fromRGBO(56, 0, 109, 1),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text('Tournament Created!')),
//                           );
//                         }
//                       },
//                       child: Text(
//                         'SUBMIT',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   )
//                 ),
//               ],
//             ),
//           ),
//         ),
//       )),
//     );
//   }
// }
// /// Commented Code
// //     drawer: Drawer(
// //         //   child: Column(
// //         //     children: [
// //         //       SizedBox(
// //         //         height: 20,
// //         //       ),
// //         //       Image.asset(
// //         //         'assets/images/1.png',
// //         //         height: 100,
// //         //       ),
// //         //       SizedBox(
// //         //         height: 20,
// //         //       ),
// //         //       ListTile(
// //         //         onTap: () {
// //         //           Navigator.push(context,
// //         //               MaterialPageRoute(builder: (context) => HomeScreen()));
// //         //         },
// //         //         tileColor: Colors.grey[350],
// //         //         title: Text(
// //         //           'Home',
// //         //           style: TextStyle(
// //         //             color: Color.fromRGBO(56, 0, 109, 1),
// //         //           ),
// //         //         ),
// //         //         leading: Icon(
// //         //           Icons.home,
// //         //           color: Colors.grey[600],
// //         //         ),
// //         //       ),
// //         //       ListTile(
// //         //         onTap: () {
// //         //           Navigator.push(context,
// //         //               MaterialPageRoute(builder: (context) => Tournaments()));
// //         //         },
// //         //         title: Text(
// //         //           'Tournaments',
// //         //           style: TextStyle(color: Colors.black),
// //         //         ),
// //         //         leading: Icon(
// //         //           Icons.emoji_events,
// //         //           color: Colors.grey[600],
// //         //         ),
// //         //       ),
// //         //       ListTile(
// //         //         leading: Icon(
// //         //           Icons.directions_run,
// //         //           color: Colors.grey[600],
// //         //         ),
// //         //         title: Text('Private'),
// //         //         trailing: IconButton(
// //         //           icon:
// //         //               Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
// //         //           onPressed: () {
// //         //             setState(() {
// //         //               isExpanded = !isExpanded; // Toggle expansion
// //         //             });
// //         //           },
// //         //         ),
// //         //       ),
// //         //       if (isExpanded) // Show options only if expanded
// //         //         Padding(
// //         //           padding: const EdgeInsets.symmetric(horizontal: 20.0),
// //         //           child: Column(
// //         //             children: [
// //         //               ListTile(
// //         //                 leading: Icon(
// //         //                   Icons.monitor_heart,
// //         //                   color: Colors.grey[600],
// //         //                 ),
// //         //                 title: Text('Practice'),
// //         //                 onTap: () {
// //         //                   Navigator.push(
// //         //                       context,
// //         //                       MaterialPageRoute(
// //         //                           builder: (context) => Practice()));
// //         //                   setState(() {
// //         //                     isExpanded = false;
// //         //                   });
// //         //                 },
// //         //               ),
// //         //               ListTile(
// //         //                 leading: Icon(
// //         //                   Icons.grid_view,
// //         //                   color: Colors.grey[600],
// //         //                 ),
// //         //                 title: Text('My Tournaments'),
// //         //                 onTap: () {
// //         //                   Navigator.push(
// //         //                       context,
// //         //                       MaterialPageRoute(
// //         //                           builder: (context) => MyTournaments()));
// //         //                   setState(() {
// //         //                     isExpanded = false;
// //         //                   });
// //         //                 },
// //         //               ),
// //         //             ],
// //         //           ),
// //         //         ),
// //         //       ListTile(
// //         //         onTap: () {
// //         //           Navigator.push(context,
// //         //               MaterialPageRoute(builder: (context) => DiseasesCure()));
// //         //         },
// //         //         title: Text(
// //         //           'Diseases And Cure',
// //         //           style: TextStyle(color: Colors.black),
// //         //         ),
// //         //         leading: Icon(
// //         //           Icons.ac_unit,
// //         //           color: Colors.grey[600],
// //         //         ),
// //         //       ),
// //         //       ListTile(
// //         //         onTap: () {
// //         //           Navigator.push(
// //         //               context,
// //         //               MaterialPageRoute(
// //         //                   builder: (context) => InformationScreen()));
// //         //         },
// //         //         title: Text(
// //         //           'Information',
// //         //           style: TextStyle(color: Colors.black),
// //         //         ),
// //         //         leading: Icon(
// //         //           Icons.info,
// //         //           color: Colors.grey[700],
// //         //         ),
// //         //       ),
// //         //       ListTile(
// //         //         onTap: () {
// //         //           Navigator.push(context,
// //         //               MaterialPageRoute(builder: (context) => ContactScreen()));
// //         //         },
// //         //         title: Text(
// //         //           'Contact',
// //         //           style: TextStyle(color: Colors.black),
// //         //         ),
// //         //         leading: Icon(
// //         //           Icons.phone,
// //         //           color: Colors.grey[700],
// //         //         ),
// //         //       ),
// //         //       ListTile(
// //         //         onTap: () {
// //         //           Navigator.push(context,
// //         //               MaterialPageRoute(builder: (context) => SettingScreen()));
// //         //         },
// //         //         title: Text(
// //         //           'Setting',
// //         //           style: TextStyle(color: Colors.black),
// //         //         ),
// //         //         leading: Icon(
// //         //           Icons.settings,
// //         //           color: Colors.grey[700],
// //         //         ),
// //         //       )
// //         //     ],
// //         //   ),
// //         //   width: 250,
// //         //   backgroundColor: Colors.white,
// //         // ),
//
//
// // ........................
//
// // @override
// // void initState() {
// //   super.initState();
// //   _refreshNotes();
// // }
// //
// // void _refreshNotes() async {
// //   final data = await dbHelper.getNotes();
// //   setState(() {
// //     notes = data;
// //   });
// // }
// //
// // void _addNote() async {
// //   await dbHelper.insert(Note(
// //     title: _tournamentsNameController.text,
// //     description: _start.text,
// //   ));
// //   _tournamentsNameController.clear();
// //   _start.clear();
// //   _refreshNotes();
// // }
// //
// // void _deleteNote(int id) async {
// //   await dbHelper.delete(id);
// //   _refreshNotes();
// // }
import 'package:flutter/material.dart';
import 'package:pigeon_tracker/Auth_Screens/login_screen.dart';
import 'package:pigeon_tracker/Home_Screens/my_tournaments.dart';
import 'package:sqflite/sqflite.dart';

class CreateTournaments extends StatefulWidget {
  const CreateTournaments({super.key});

  @override
  State<CreateTournaments> createState() => _CreateTournamentsState();
}

class _CreateTournamentsState extends State<CreateTournaments> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final DatabaseHelper dbHelper = DatabaseHelper();
  TextEditingController _tournamentsNameController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _pickDateTime(BuildContext context, bool isStartDate) async {
    // Pick a date
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // Pick a time
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        // Combine date and time
        final DateTime combined = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          if (isStartDate) {
            _startDate = combined;
          } else {
            _endDate = combined;
          }
        });
      }
    }
  }


  Future<void> _saveTournament() async {
    if (_formKey.currentState!.validate()) {
      if (_startDate == null || _endDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select both start and end dates.')),
        );
        return;
      }

      String name = _tournamentsNameController.text;
      String startDate = _startDate!.toIso8601String();
      String endDate = _endDate!.toIso8601String();

      // Save to SQLite database
      Database db = await dbHelper.database;
      await db.insert('tournaments', {
        'name': name,
        'start_date': startDate,
        'end_date': endDate,
      });

      // Log to console
      print('Tournament saved:');
      print('Name: $name');
      print('Start Date: $startDate');
      print('End Date: $endDate');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tournament Created Successfully!')),
      );

      // Clear the form
      _tournamentsNameController.clear();
      setState(() {
        _startDate = null;
        _endDate = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_scaffoldKey.currentState!.isDrawerOpen) {
          Navigator.pop(context); // Close the drawer
          return true;
        }
        return true;
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
                color: Colors.white, // Drawer icon color
              ),
              backgroundColor: Color.fromRGBO(56, 0, 109, 1),
              elevation: 10.0,
              shadowColor: Colors.black,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create Tournament',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _tournamentsNameController,
                      decoration: InputDecoration(
                        labelText: 'Tournament Name*',
                        border: UnderlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a tournament name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => _pickDateTime(context, true),
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Start',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          controller: TextEditingController(
                              text: _startDate != null
                                  ? '${_startDate!.month}/${_startDate!.day}/${_startDate!.year}'
                                  : ''),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => _pickDateTime(context, false),
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'End',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          controller: TextEditingController(
                              text: _endDate != null
                                  ? '${_endDate!.month}/${_endDate!.day}/${_endDate!.year}'
                                  : ''),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(56, 0, 109, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () async {
                            await _saveTournament(); // Save the tournament
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => MyTournaments()),
                            ); // Navigate to MyTournaments page
                          },
                          child: Text(
                            'SUBMIT',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper.internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    String path = await getDatabasesPath() + 'tournaments.db';
    return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
          CREATE TABLE tournaments (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            start_date TEXT NOT NULL,
            end_date TEXT NOT NULL
          )
        ''');
          print('Database and tournaments table created!');
        },
    );
  }

  // Insert function for reuse
  Future<int> insertTournament(Map<String, dynamic> tournament) async {
    Database db = await database;
    return await db.insert('tournaments', tournament);
  }

  // Fetch all tournaments for validation/testing
  Future<List<Map<String, dynamic>>> getAllTournaments() async {
    Database db = await database;
    return await db.query('tournaments');
  }
}

