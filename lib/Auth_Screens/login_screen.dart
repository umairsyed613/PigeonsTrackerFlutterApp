import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _groupValue = -1;

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
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        icon: Icon(
                          Icons.logout,
                          color: Colors.white,
                        )),
                    IconButton(
                      onPressed: () =>
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                icon: IconButton(onPressed: (){},
                                    icon: Icon(Icons.cancel_outlined,
                                      color: Colors.black,)),
                                title: Text(
                                  "Language Change",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pinkAccent),
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
                                actionsPadding: EdgeInsets.symmetric(horizontal: 10.0),
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Expanded(
                                        child: RadioMenuButton(
                                          value: 0,
                                          groupValue: _groupValue,
                                          onChanged: (int? newValue) =>
                                              setState(() =>
                                              _groupValue = newValue!),
                                          child: Text('English'),
                                        ),
                                      ),
                                      Expanded(
                                        child: RadioMenuButton(
                                            value: 1,
                                            groupValue: _groupValue,
                                            onChanged: (int? newValue) =>
                                                setState(() =>
                                                _groupValue = newValue!),
                                            child: Text('Urdu')),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                      icon: Icon(
                        Icons.language,
                        color: Colors.white,
                      ),
                    ),
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
        ),
      ),
    );
  }
}
