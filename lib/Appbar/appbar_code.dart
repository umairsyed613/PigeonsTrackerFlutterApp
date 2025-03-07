import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Auth_Screens/contact_screen.dart';
import '../Auth_Screens/information_screen.dart';
import '../Auth_Screens/login_screen.dart';
import '../Auth_Screens/setting_screen.dart';
import '../DiseasesAndCure/diseases_cure.dart';
import '../Home_Screens/Home_screen.dart';
import '../MyTournaments/my_tournaments.dart';
import '../Practice/practice.dart';
import '../Tournaments/tournaments.dart';

class AppbarCode extends StatefulWidget {
  final String title;
  final Widget body;
  final Widget? floatingActionButton;
  final String currentScreen; // Add this parameter

  AppbarCode({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButton,
    required this.currentScreen, // Add this parameter
    required WillPopScope child,
  });

  @override
  State<AppbarCode> createState() => _AppbarCodeState();
}

class _AppbarCodeState extends State<AppbarCode> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isExpanded = false;

  void buildDialog(BuildContext context) {
    final List locale = [
      {'name': 'ENGLISH', 'locale': Locale('en', 'US')},
      {'name': 'URDU', 'locale': Locale('ur', 'PK')},
    ];

    showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: Text(
            'Choose a Language text'.tr,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Container(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        updateLanguage(locale[index]['locale']);
                      },
                      child: Text(locale[index]['name'])),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(color: Colors.black);
              },
              itemCount: locale.length,
            ),
          ),
        );
      },
    );
  }

  void updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
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
      child: Directionality(
        textDirection: Locale == 'en' ? TextDirection.rtl : TextDirection.ltr,
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
                      widget.title.tr,
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
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      icon: Icon(Icons.logout, color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {
                        buildDialog(context);
                      },
                      icon: Icon(Icons.language, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Color.fromRGBO(56, 0, 109, 1),
            elevation: 10.0,
            shadowColor: Colors.black,
          ),
          drawer: Drawer(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
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
                  tileColor: widget.currentScreen == 'HomeScreen'
                      ? Colors.grey[350]
                      : null,
                  title: Text(
                    'Home text'.tr,
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
                  tileColor: widget.currentScreen == 'Tournaments'
                      ? Colors.grey[350]
                      : null,
                  title: Text(
                    'Tournaments text'.tr,
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
                  title: Text('Private text'.tr),
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
                          title: Text('Practice text'.tr),
                          tileColor: widget.currentScreen == 'Practice'
                              ? Colors.grey[350]
                              : null,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Practice()));
                            setState(() {
                              isExpanded = true;
                            });
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.grid_view,
                            color: Colors.grey[600],
                          ),
                          title: Text('tour text'.tr),
                          tileColor: widget.currentScreen == 'MyTournaments'
                              ? Colors.grey[350]
                              : null,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyTournaments()));
                            setState(() {
                              isExpanded = true;
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
                  tileColor: widget.currentScreen == 'DiseasesCure'
                      ? Colors.grey[350]
                      : null,
                  title: Text(
                    'dise text'.tr,
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
                  tileColor: widget.currentScreen == 'InformationScreen'
                      ? Colors.grey[350]
                      : null,
                  title: Text(
                    'Information text'.tr,
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
                  tileColor: widget.currentScreen == 'ContactScreen'
                      ? Colors.grey[350]
                      : null,
                  title: Text(
                    'Contact text'.tr,
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
                  tileColor: widget.currentScreen == 'SettingScreen'
                      ? Colors.grey[350]
                      : null,
                  title: Text(
                    'Setting text'.tr,
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
          body: widget.body,
          floatingActionButton: widget.floatingActionButton,
        ),
      ),
    );
  }
}
