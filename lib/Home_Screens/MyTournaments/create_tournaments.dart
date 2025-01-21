import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pigeon_tracker/Home_Screens/MyTournaments/my_tournaments.dart';
import 'package:pigeon_tracker/appbar_code.dart';
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

  Future<void> _pickDate(BuildContext context, bool isStartDate) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
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
      String startDate =
          '${_startDate!.year}-${_startDate!.month.toString().padLeft(2, '0')}-${_startDate!.day.toString().padLeft(2, '0')}';
      String endDate =
          '${_endDate!.year}-${_endDate!.month.toString().padLeft(2, '0')}-${_endDate!.day.toString().padLeft(2, '0')}';

      // Save to SQLite database
      Database db = await dbHelper.database;
      await db.insert('tournaments', {
        'name': name,
        'start_date': startDate,
        'end_date': endDate,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tournament Created Successfully!')),
      );


      _tournamentsNameController.clear();
      setState(() {
        _startDate = null;
        _endDate = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppbarCode(
      title: 'Pg text'.tr,
      child: WillPopScope(
        onWillPop: () async {
          if (_scaffoldKey.currentState!.isDrawerOpen) {
            Navigator.pop(context); // Close the drawer
            return true;
          }
          return true;
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'create text'.tr,
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
                  labelText: 'tour name text'.tr,
                  border: UnderlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a tournament name text'.tr;
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => _pickDate(context, true),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'start text'.tr,
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
                onTap: () => _pickDate(context, false),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'end text'.tr,
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
                      if (_formKey.currentState!.validate()) {
                        await _saveTournament(); // Save the tournament
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyTournaments()),
                        ); // Navigate to MyTournaments page
                      }
                    },
                    child: Text(
                      'sub text'.tr,
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

  // Insert function to add tournament data
  Future<int> insertTournament(Map<String, dynamic> tournament) async {
    Database db = await database;
    return await db.insert('tournaments', tournament);
  }

  // Fetch all tournaments
  Future<List<Map<String, dynamic>>> getAllTournaments() async {
    Database db = await database;
    return await db.query('tournaments');
  }

  // Delete a tournament by ID
  Future<int> deleteTournament(int id) async {
    Database db = await database;
    return await db.delete(
      'tournaments',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Update a tournament by ID
  Future<int> updateTournament(int id, Map<String, dynamic> updatedData) async {
    Database db = await database;
    return await db.update(
      'tournaments',
      updatedData,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
