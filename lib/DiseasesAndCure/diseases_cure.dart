import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:pigeon_tracker/Appbar/appbar_code.dart';

import 'Diseases_Cure_Database/db_controler.dart';
import 'Diseases_Cure_Database/disease_model.dart';
import 'add_diseases.dart';

class DiseasesCure extends StatefulWidget {
  const DiseasesCure({super.key});

  @override
  State<DiseasesCure> createState() => _DiseasesCureState();
}

class _DiseasesCureState extends State<DiseasesCure> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<DiseaseModel> _diseases = [];

  @override
  void initState() {
    super.initState();
    fetchDiseases();
  }

  Future<void> fetchDiseases() async {
    final data = await DBController().getAllDiseases();
    setState(() {
      _diseases = data;
    });
  }

  void deleteDisease(int id) async {
    await DBController().deleteDisease(id);
    fetchDiseases();
  }

  void showDeleteDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Delete"),
        content: Text("Do you really want to delete this?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("No")),
          TextButton(
            onPressed: () {
              deleteDisease(id);
              Navigator.pop(context);
            },
            child: Text("Yes"),
          ),
        ],
      ),
    );
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
      body: RefreshIndicator(
        onRefresh: () => fetchDiseases(),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0, right: 150),
            child: Text(
              'Diseases and Cure',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: _diseases.isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 58.0),
                    child: Center(
                      child: Text(
                        'record text'.tr,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: _diseases.length,
                    itemBuilder: (_, index) {
                      final disease = _diseases[index];
                      return Card(
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          tileColor: Color.fromARGB(100, 175, 113, 136),
                          title: Text(disease.diseaseName),
                          subtitle: Html(data: disease.cure),
                          leading: Icon(
                            Icons.emoji_events_outlined,
                            size: 35,
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                            ),
                            onPressed: () =>
                                showDeleteDialog(context, disease.id!),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AddDiseases()),
        ),
        backgroundColor: Color.fromRGBO(56, 0, 109, 1),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      currentScreen: 'DiseaseCure',
    );
  }
}
