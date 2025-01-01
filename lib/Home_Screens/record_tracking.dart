import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pigeon_tracker/Home_Screens/practice.dart';
import 'package:pigeon_tracker/Home_Screens/tournaments.dart';

import '../Auth_Screens/contact_screen.dart';
import '../Auth_Screens/information_screen.dart';
import '../Auth_Screens/login_screen.dart';
import '../Auth_Screens/setting_screen.dart';
import 'Home_screen.dart';
import 'diseases_cure.dart';
import 'my_tournaments.dart';

class RecordTracking extends StatefulWidget {
  const RecordTracking({super.key});

  @override
  State<RecordTracking> createState() => _RecordTrackingState();
}

class _RecordTrackingState extends State<RecordTracking> {
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
                    icon:
                        Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DiseasesCure()));
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ContactScreen()));
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SettingScreen()));
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Tracking Record',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 125,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.10),
                            ),
                          ],
                          color: Color.fromRGBO(56, 0, 109, 1),
                          borderRadius: BorderRadius.circular(50)),
                      height: 40,
                      width: 40,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.edit, color: Colors.white)),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Loft Name:',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Start:',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                      width: 95,
                    ),
                    Text(
                      '25 December 2024 12:00 AM',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Table Headers
                Table(
                  columnWidths: const {
                    0: FixedColumnWidth(50),
                    1: FlexColumnWidth(),
                    2: FixedColumnWidth(80),
                    3: FixedColumnWidth(80),
                  },
                  border: TableBorder.all(color: Colors.grey.shade300),
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: Colors.grey.shade200),
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Nr.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Bird Name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Landed',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Average',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 7, // Replace with dynamic count if needed
                    itemBuilder: (context, index) {
                      return Table(
                        columnWidths: const {
                          0: FixedColumnWidth(50),
                          1: FlexColumnWidth(),
                          2: FixedColumnWidth(80),
                          3: FixedColumnWidth(80),
                        },
                        border: TableBorder.all(color: Colors.grey.shade300),
                        children: [
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${index + 1}',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(''),
                              ),
                              const Padding(                              padding: EdgeInsets.all(8.0),
                                child: Text(
                                  '',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  '',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 250.0, left: 2, right: 2),
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 150,
                        ),
                        Text(
                          'Total Average',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Text(
                          '00:00',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                  ),
                )
              ],
            ),
                    ),
                  ),
          )),
    );
  }
}
