import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Appbar/appbar_code.dart';
import 'add_diseases.dart';

class DiseasesCure extends StatefulWidget {
  const DiseasesCure({super.key});

  @override
  State<DiseasesCure> createState() => _DiseasesCureState();
}

class _DiseasesCureState extends State<DiseasesCure> {
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
            padding: const EdgeInsets.only(top: 8.0, right: 150),
            child: Text(
              'Diseases And Cure text'.tr,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18.0, left: 10),
            child: Text(
              'No Records found, please create new records by pressing the + button bellow text'.tr,
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
      ), currentScreen: 'DiseasesCure',
    );
  }

  void navigateToAddPage() {
    final route = MaterialPageRoute(builder: (context) => AddDiseases());
    Navigator.push(context, route);
  }
}
