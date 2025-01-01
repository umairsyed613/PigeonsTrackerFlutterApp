import 'dart:ffi';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pigeon_tracker/Auth_Screens/contact_screen.dart';
import 'package:pigeon_tracker/Auth_Screens/information_screen.dart';
import 'package:pigeon_tracker/Auth_Screens/login_screen.dart';
import 'package:pigeon_tracker/Auth_Screens/setting_screen.dart';
import 'package:pigeon_tracker/Home_Screens/Home_screen.dart';
import 'package:pigeon_tracker/Home_Screens/diseases_cure.dart';
import 'package:pigeon_tracker/Home_Screens/my_tournaments.dart';
import 'package:pigeon_tracker/Home_Screens/practice.dart';
import 'package:pigeon_tracker/Home_Screens/record_tracking.dart';
import 'package:pigeon_tracker/Home_Screens/tournaments.dart';

class TrackingRecord extends StatefulWidget {
  const TrackingRecord({super.key});

  @override
  State<TrackingRecord> createState() => _TrackingRecordState();
}

class _TrackingRecordState extends State<TrackingRecord> {
  builddialog(BuildContext context){
    showDialog(
        context: context,
        builder: (builder){
          return AlertDialog(
            title: Text('Choose a Language',style: TextStyle(fontWeight: FontWeight.bold),),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onTap: (){
                          updatelanguage(locale[index]['locale']);
                        },
                        child: Text(locale[index]['name'])),
                  );
                },
                separatorBuilder: (context,index){
                  return Divider(
                    color: Colors.black,
                  );
                },
                itemCount: locale.length,
              ),
            ),
          );
        }
    );
  }
  final List locale = [
    {'name':'ENGLISH','locale':Locale('en','US')},
    {'name':'اردو','locale':Locale('ur','PK')},
  ];
  updatelanguage(Locale locale){
    Get.back();
    Get.updateLocale(locale);
  }
  bool isExpanded = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController totalBirdsController = TextEditingController();
  TextEditingController _loftNameController = TextEditingController();
  DateTime? _flyingStartDay;
  TimeOfDay? _flyingStartTime;
  int _totalBirds = 1;
  bool _isBabyBird = false;

  bool showBirdFields = false;
  int totalBirds = 0;

  Future<void> _pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _flyingStartDay = picked;
      });
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _flyingStartTime = picked;
      });
    }
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
          child: Directionality(
            textDirection: Locale == 'en'
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.white,
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
                              onPressed: () {
                                builddialog(context);
                              },
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
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      'assets/images/1.png',
                      height: 100,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => HomeScreen()));
                      },
                      tileColor: Colors.grey[350],
                      title: Text(
                        'Home',
                        style: TextStyle(
                          color: Color.fromRGBO(56, 0, 109, 1),
                        ),
                      ),
                      leading: Icon(
                        Icons.home,
                        color: Colors.grey[600],
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Tournaments()));
                      },
                      title: Text(
                        'Tournaments',
                        style: TextStyle(color: Colors.black),
                      ),
                      leading: Icon(
                        Icons.emoji_events,
                        color: Colors.grey[600],
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.directions_run,
                        color: Colors.grey[600],
                      ),
                      title: Text('Private'),
                      trailing: IconButton(
                        icon: Icon(
                            isExpanded ? Icons.expand_less : Icons.expand_more),
                        onPressed: () {
                          setState(() {
                            isExpanded = !isExpanded; // Toggle expansion
                          });
                        },
                      ),
                    ),
                    if (isExpanded) // Show options only if expanded
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.monitor_heart,
                                color: Colors.grey[600],
                              ),
                              title: Text('Practice'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Practice()));
                                setState(() {
                                  isExpanded = false;
                                });
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.grid_view,
                                color: Colors.grey[600],
                              ),
                              title: Text('My Tournaments'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyTournaments()));
                                setState(() {
                                  isExpanded = false;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DiseasesCure()));
                      },
                      title: Text(
                        'Diseases And Cure',
                        style: TextStyle(color: Colors.black),
                      ),
                      leading: Icon(
                        Icons.ac_unit,
                        color: Colors.grey[600],
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InformationScreen()));
                      },
                      title: Text(
                        'Information',
                        style: TextStyle(color: Colors.black),
                      ),
                      leading: Icon(
                        Icons.info,
                        color: Colors.grey[700],
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContactScreen()));
                      },
                      title: Text(
                        'Contact',
                        style: TextStyle(color: Colors.black),
                      ),
                      leading: Icon(
                        Icons.phone,
                        color: Colors.grey[700],
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingScreen()));
                      },
                      title: Text(
                        'Setting',
                        style: TextStyle(color: Colors.black),
                      ),
                      leading: Icon(
                        Icons.settings,
                        color: Colors.grey[700],
                      ),
                    )
                  ],
                ),
                width: 250,
                backgroundColor: Colors.white,
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create Tracking Record',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _loftNameController,
                          decoration: InputDecoration(
                            labelText: 'Loft Name*',
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the loft name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () => _pickDate(context),
                          child: AbsorbPointer(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Flying Start Day*',
                                border: UnderlineInputBorder(),
                                suffixIcon: Icon(Icons.calendar_today),
                              ),
                              controller: TextEditingController(
                                text: _flyingStartDay != null
                                    ? '${_flyingStartDay!.day}.${_flyingStartDay!.month}.${_flyingStartDay!.year}'
                                    : '',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => _pickTime(context),
                          child: AbsorbPointer(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Flying Start Time*',
                                border: UnderlineInputBorder(),
                                suffixIcon: Icon(Icons.access_time),
                              ),
                              controller: TextEditingController(
                                text: _flyingStartTime != null
                                    ? _flyingStartTime!.format(context)
                                    : '',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        DropdownButtonFormField<int>(
                          value: _totalBirds,
                          decoration: InputDecoration(
                            labelText: 'Total Birds',
                            border: UnderlineInputBorder(),
                          ),
                          items: List.generate(
                            50,
                            (index) => DropdownMenuItem(
                              value: index + 1,
                              child: Text('${index + 1}'),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _totalBirds = value!;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        Text('Baby Bird'),
                        SizedBox(height: 10),
                        FlutterSwitch(
                          width: 55.0,
                          height: 30.0,
                          toggleSize: 20.0,
                          value: _isBabyBird,
                          borderRadius: 30.0,
                          activeColor: Color.fromRGBO(56, 0, 109, 1),
                          inactiveColor: Colors.grey.shade300,
                          onToggle: (val) {
                            setState(() {
                              _isBabyBird = val;
                            });
                          },
                        ),
                        SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(56, 0, 109, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  showBirdFields = true;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Tracking Record Created!')),
                                );
                              }
                            },
                            child: Text(
                              'SUBMIT',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        if (showBirdFields) ...[
                          SizedBox(height: 20),
                          Text(
                            "Birds Information",
                            style: TextStyle(
                                color: Color.fromRGBO(56, 0, 109, 1),
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _totalBirds,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(56, 0, 109, 1),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            "${index + 1}",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 16),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              labelText: "Bird Name",
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(56, 0, 109, 1),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            "${index + 2}",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 16),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              labelText: "Bird Name",
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(56, 0, 109, 1),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            "${index + 3}",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 16),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              labelText: "Bird Name",
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(56, 0, 109, 1),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            "${index + 4}",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 16),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              labelText: "Bird Name",
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(56, 0, 109, 1),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            "${index + 5}",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 16),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              labelText: "Bird Name",
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(56, 0, 109, 1),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            "${index + 6}",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 16),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              labelText: "Bird Name",
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(56, 0, 109, 1),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            "${index + 7}",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 16),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              labelText: "Bird Name",
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RecordTracking()));
                              },
                              child: Text(
                                "SUBMIT",
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
