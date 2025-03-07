import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pigeon_tracker/Appbar/appbar_code.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            textDirection:
                Locale == 'en' ? TextDirection.rtl : TextDirection.ltr,
            child: Scaffold(
              backgroundColor: Colors.white,
              key: _scaffoldKey,
            ),
          ),
        ),
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
      ), currentScreen: 'LoginScreen',
    );
  }
}
