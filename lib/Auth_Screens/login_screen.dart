import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pigeon_tracker/Auth_Screens/contact_screen.dart';
import 'package:pigeon_tracker/Auth_Screens/information_screen.dart';
import 'package:pigeon_tracker/Auth_Screens/setting_screen.dart';
import 'package:pigeon_tracker/Home_Screens/Home_screen.dart';
import 'package:pigeon_tracker/Home_Screens/diseases_cure.dart';
import 'package:pigeon_tracker/Home_Screens/my_tournaments.dart';
import 'package:pigeon_tracker/Home_Screens/practice.dart';
import 'package:pigeon_tracker/Home_Screens/tournaments.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                          onPressed:() {
                            builddialog(context);
                          },
                          icon: Icon(
                            Icons.language,
                            color: Colors.white,
                          ),
                        ),
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
                      icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
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
              backgroundColor: Colors.white,
              width: 250,
            ),
            body: Column(
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.pinkAccent),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13.0, top: 20),
                  child: Stack(
                    children: [
                      Container(
                        height: 40,
                        width: 360,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.30),
                                  blurRadius: 5)
                            ],
                            color: Color.fromRGBO(56, 0, 109, 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'LOGIN WITH GOOGLE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Container(
                          height: 40,
                          width: 360,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.30),
                                    blurRadius: 5)
                              ],
                              color: Color.fromRGBO(56, 0, 109, 1),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'LOGIN WITH FACEBOOK',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
