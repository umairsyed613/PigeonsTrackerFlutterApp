import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:pigeon_tracker/Appbar/appbar_code.dart';

import 'Diseases_Cure_Database/disease_model.dart';
import 'add_diseases.dart';

class CureShow extends StatefulWidget {
  final int diseaseId;
  final String diseaseName;
  final String cure;
  const CureShow({
    super.key,
    required this.diseaseName,
    required this.cure,
    required this.diseaseId,
  });

  @override
  State<CureShow> createState() => _CureShowState();
}

class _CureShowState extends State<CureShow> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String currentCure = "";

  @override
  void initState() {
    super.initState();
    currentCure = widget.cure; // initialize from constructor
  }

  // void _showEditDialog() {
  //   final HtmlEditorController _htmlController = HtmlEditorController();
  //   String updatedHtml = widget.cure;
  //
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         backgroundColor: Colors.white,
  //         contentPadding:
  //             EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
  //         content: SizedBox(
  //           height: 400,
  //           width: double.maxFinite,
  //           child: Column(
  //             children: [
  //               Expanded(
  //                 child: HtmlEditor(
  //                   otherOptions: OtherOptions(
  //                       decoration: BoxDecoration(
  //                           color: Colors.white,
  //                           border: Border.all(
  //                               color: Color.fromRGBO(56, 0, 109, 1)),
  //                           borderRadius: BorderRadius.circular(10))),
  //                   controller: _htmlController,
  //                   htmlEditorOptions: HtmlEditorOptions(
  //                     initialText: widget.cure,
  //                     hint: "Edit Cure...",
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 10,
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(left: 10, right: 10),
  //                 child: SizedBox(
  //                   width: double.infinity,
  //                   height: 40,
  //                   child: ElevatedButton(
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: Color.fromRGBO(56, 0, 109, 1),
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                       ),
  //                     ),
  //                     onPressed: () async {
  //                       String? result = await _htmlController.getText();
  //                       if (result != null && result.trim().isNotEmpty) {
  //                         await DBController()
  //                             .updateCure(widget.diseaseId, result);
  //
  //                         setState(() {
  //                           currentCure = result; // ✅ update local state
  //                         });
  //
  //                         Navigator.pop(context, 'updated');
  //                         Get.snackbar("Updated", "Cure has been updated.");
  //                       }
  //                     },
  //                     child: Text(
  //                       "SUBMIT",
  //                       style: TextStyle(
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.bold,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 10),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

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
      currentScreen: 'CureShow',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cure For Disease',
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent),
            ),
            SizedBox(height: 15),
            Stack(children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromRGBO(56, 0, 109, 1)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Html(data: currentCure),
              ),
              SizedBox(height: 20),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.edit, color: Color.fromRGBO(56, 0, 109, 1)),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddDiseases(
                          isEdit: true,
                          disease: DiseaseModel(
                            id: widget.diseaseId,
                            diseaseName: widget.diseaseName,
                            cure: widget.cure,
                          ),
                        ),
                      ),
                    );

                    if (result == 'updated') {
                      Navigator.pop(
                          context, 'updated'); // Back to DiseasesCure screen
                    }
                  },
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
