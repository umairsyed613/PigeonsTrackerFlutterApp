import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pigeon_tracker/appbar_code.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _loftNameController = TextEditingController();
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
            key: _scaffoldKey,
            backgroundColor: Colors.white,
          ),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 250.0),
                child: Text(
                  'Setting',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.pinkAccent),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 55.0, left: 20, right: 20),
                child: TextFormField(
                  controller: _loftNameController,
                  maxLength: 8, // Limiting input to 8 characters
                  decoration: InputDecoration(
                    hintText: "Loft Name",
                    counterText: "Max: 8 characters",
                    // Character limit hint
                    border: UnderlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required.';
                    }
                    if (value.length > 8) {
                      return 'Maximum 8 characters allowed.';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 250.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Save action here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Saved successfully!")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    backgroundColor: Color.fromRGBO(56, 0, 109, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "SAVE",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
