// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pigeon_tracker/Appbar/appbar_code.dart';
// import 'package:pigeon_tracker/DiseasesAndCure/diseases_cure.dart';
//
// import 'Diseases_Cure_Database/db_controler.dart';
// import 'Diseases_Cure_Database/disease_model.dart';
//
// class AddDiseases extends StatefulWidget {
//   const AddDiseases({super.key});
//
//   @override
//   State<AddDiseases> createState() => _AddDiseasesState();
// }
//
// class _AddDiseasesState extends State<AddDiseases> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final _formkey = GlobalKey<FormState>();
//   final TextEditingController diseaseNameController = TextEditingController();
//   final TextEditingController cureController = TextEditingController();
//
//   void _saveDisease() async {
//     if (_formkey.currentState!.validate()) {
//       DiseaseModel model = DiseaseModel(
//         diseaseName: diseaseNameController.text.trim(),
//         cure: cureController.text.trim(),
//       );
//       await DBControler().insertDisease(model);
//       Navigator.pop(context); // Go back
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AppbarCode(
//       title: 'Pg text'.tr,
//       body: Form(
//         key: _formkey,
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
//               child: Text(
//                 'Add Diseases and Cure text'.tr,
//                 style: const TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.pinkAccent),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 20, right: 20, top: 35),
//               child: TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Disease Name',
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the Disease name';
//                   }
//                   return null;
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
//               child: TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Cure For Disease',
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'please enter the Cure';
//                   }
//                 },
//               ),
//             ),
//             const SizedBox(height: 40),
//             Center(
//               child: Padding(
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
//                       if (_formkey.currentState!.validate()) {
//                         await _saveDisease;
//                         Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => DiseasesCure()));
//                         ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                                 backgroundColor: Color.fromRGBO(56, 0, 109, 1),
//                                 content: Text(
//                                     'Add Diseases and Cure Successfully')));
//                       }
//                     },
//                     child: const Text(
//                       'SUBMIT',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//       currentScreen: 'AddDiseases',
//       child: WillPopScope(
//         onWillPop: () async {
//           if (_scaffoldKey.currentState!.isDrawerOpen) {
//             Navigator.pop(context); // Close the drawer
//             return true; // Prevent navigation
//           }
//           return true; // Allow navigation
//         },
//         child: SafeArea(
//             child: Directionality(
//           textDirection: Locale == 'en' ? TextDirection.rtl : TextDirection.ltr,
//           child: Scaffold(
//             backgroundColor: Colors.white,
//             key: _scaffoldKey,
//           ),
//         )),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pigeon_tracker/Appbar/appbar_code.dart';

import 'Diseases_Cure_Database/db_controler.dart';
import 'Diseases_Cure_Database/disease_model.dart';
import 'diseases_cure.dart';

class AddDiseases extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController diseaseController = TextEditingController();
  final TextEditingController cureController = TextEditingController();

  AddDiseases({super.key});

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
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
              child: Text(
                'Add Diseases and Cure text'.tr,
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 35),
              child: TextFormField(
                controller: diseaseController,
                decoration: const InputDecoration(
                  labelText: 'Disease Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Disease name';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: TextFormField(
                controller: cureController,
                decoration: const InputDecoration(
                  labelText: 'Cure For Disease',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter the Cure';
                  }
                },
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(56, 0, 109, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    if (diseaseController.text.isNotEmpty &&
                        cureController.text.isNotEmpty) {
                      final newDisease = DiseaseModel(
                        diseaseName: diseaseController.text,
                        cure: cureController.text,
                      );
                      await DBController().insertDisease(newDisease);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const DiseasesCure()),
                      );
                    }
                  },
                  child: Text(
                    "SUBMIT",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      currentScreen: 'AddDiseases',
    );
  }
}
