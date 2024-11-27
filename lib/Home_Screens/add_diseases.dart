import 'package:flutter/material.dart';

class AddDiseases extends StatefulWidget {
  const AddDiseases({super.key});

  @override
  State<AddDiseases> createState() => _AddDiseasesState();
}

class _AddDiseasesState extends State<AddDiseases> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
      key: _scaffoldKey,
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
                      onPressed: () {},
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
        // Purple Background
        elevation: 10.0,
        shadowColor: Colors.black, // Shadow depth
      ),
      drawer: Drawer(
        width: 250,
      ),
      body: Column(
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
    ));
  }
}
