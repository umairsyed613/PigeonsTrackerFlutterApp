import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pigeon_tracker/appbar_code.dart';

class AddDiseases extends StatefulWidget {
  const AddDiseases({super.key});

  @override
  State<AddDiseases> createState() => _AddDiseasesState();
}

class _AddDiseasesState extends State<AddDiseases> {
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
      body:  Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Add Diseases and Cure',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent),
            ),
          )
        ],
      ),
    );
  }
}
