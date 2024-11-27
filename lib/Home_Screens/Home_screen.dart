import 'package:flutter/material.dart';
import 'package:pigeon_tracker/Auth_Screens/contact_screen.dart';
import 'package:pigeon_tracker/Auth_Screens/information_screen.dart';
import 'package:pigeon_tracker/Auth_Screens/login_screen.dart';
import 'package:pigeon_tracker/Auth_Screens/setting_screen.dart';
import 'package:pigeon_tracker/Home_Screens/diseases_cure.dart';
import 'package:pigeon_tracker/Home_Screens/my_tournaments.dart';
import 'package:pigeon_tracker/Home_Screens/practice.dart';
import 'package:pigeon_tracker/Home_Screens/tournaments.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isExpanded = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final videoUrl = "https://www.youtube.com/watch?v=vMUXNhz7TYg";
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(videoUrl);
    _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(
          showLiveFullscreenButton: true,
          autoPlay: false,
          mute: false,
        ));
    super.initState();
  }

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
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
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
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'assets/images/1.png',
                  height: 100,
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  tileColor: Colors.grey[350],
                  title: Text(
                    'Home',
                    style: TextStyle(
                      color: Color.fromRGBO(56, 0, 109, 1),
                    ),
                  ),
                  leading: Icon(
                    Icons.home,
                    color: Colors.grey[600],
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Tournaments()));
                  },
                  title: Text(
                    'Tournaments',
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: Icon(
                    Icons.emoji_events,
                    color: Colors.grey[600],
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.directions_run,
                    color: Colors.grey[600],
                  ),
                  title: Text('Private'),
                  trailing: IconButton(
                    icon: Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more),
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded; // Toggle expansion
                      });
                    },
                  ),
                ),
                if (isExpanded) // Show options only if expanded
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.monitor_heart,
                            color: Colors.grey[600],
                          ),
                          title: Text('Practice'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Practice()));
                            setState(() {
                              isExpanded = false;
                            });
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.grid_view,
                            color: Colors.grey[600],
                          ),
                          title: Text('My Tournaments'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyTournaments()));
                            setState(() {
                              isExpanded = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DiseasesCure()));
                  },
                  title: Text(
                    'Diseases And Cure',
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: Icon(
                    Icons.ac_unit,
                    color: Colors.grey[600],
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InformationScreen()));
                  },
                  title: Text(
                    'Information',
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: Icon(
                    Icons.info,
                    color: Colors.grey[700],
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContactScreen()));
                  },
                  title: Text(
                    'Contact',
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: Icon(
                    Icons.phone,
                    color: Colors.grey[700],
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingScreen()));
                  },
                  title: Text(
                    'Setting',
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: Icon(
                    Icons.settings,
                    color: Colors.grey[700],
                  ),
                )
              ],
            ),
            width: 250,
            backgroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Follow Your Pigeons!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome to our new app. For Changing Language",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "use top right button",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ],
                ),
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0, left: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyTournaments()));
                      },
                      child: Container(
                        alignment: Alignment.topLeft,
                        height: 140,
                        width: 180,
                        child: Stack(alignment: Alignment.center, children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 90.0, left: 130),
                              child: Icon(
                                Icons.view_list_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20.0,
                            ),
                            child: Text(
                              'My Tournaments',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          )
                        ]),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(56, 0, 109, 1),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0, left: 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Tournaments()));
                      },
                      child: Container(
                        alignment: Alignment.topLeft,
                        height: 140,
                        width: 180,
                        child: Stack(alignment: Alignment.center, children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 90.0, left: 130),
                              child: Icon(
                                Icons.emoji_events,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20.0,
                            ),
                            child: Text(
                              'Tournaments',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          )
                        ]),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(56, 0, 109, 1),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                ]),
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Practice()));
                      },
                      child: Container(
                        alignment: Alignment.topLeft,
                        height: 140,
                        width: 180,
                        child: Stack(alignment: Alignment.center, children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 90.0, left: 130),
                              child: Icon(
                                Icons.monitor_heart_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20.0,
                            ),
                            child: Text(
                              'Practice',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          )
                        ]),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(56, 0, 109, 1),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DiseasesCure()));
                      },
                      child: Container(
                        alignment: Alignment.topLeft,
                        height: 140,
                        width: 180,
                        child: Stack(alignment: Alignment.center, children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 90.0, left: 130),
                              child: Icon(
                                Icons.ac_unit,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20.0,
                            ),
                            child: Text(
                              'Diseases and',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 60.0, right: 77),
                            child: Text(
                              'Cure',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ]),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(56, 0, 109, 1),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                ]),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.search_outlined,
                        size: 25,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      "Discover",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "How to use",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: YoutubePlayer(
                    progressIndicatorColor: Color.fromRGBO(56, 0, 109, 1),
                    progressColors: ProgressBarColors(
                      playedColor: Color.fromRGBO(56, 0, 109, 1),
                      handleColor: Color.fromRGBO(56, 0, 109, 1),
                    ),
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    onReady: () => debugPrint('Ready'),
                    bottomActions: [
                      CurrentPosition(),
                      ProgressBar(
                        isExpanded: true,
                      ),
                      const PlaybackSpeedButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
