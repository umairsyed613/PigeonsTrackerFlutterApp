import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pigeon_tracker/Home_Screens/Practice/create_tracking%20record.dart';
import 'package:pigeon_tracker/appbar_code.dart';

class Practice extends StatefulWidget {
  const Practice({super.key});

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
        child: SafeArea(
            child: Directionality(
          textDirection: Locale == 'en' ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            backgroundColor: Colors.white,
            key: _scaffoldKey,
          ),
        )),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 270.0, top: 10),
            child: Text(
              'Practice',
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
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: navigateToAddPage,
        backgroundColor: Color.fromRGBO(56, 0, 109, 1),
      ),
    );
  }

  void navigateToAddPage() {
    final route = MaterialPageRoute(builder: (context) => TrackingRecord());
    Navigator.push(context, route);
  }
}
