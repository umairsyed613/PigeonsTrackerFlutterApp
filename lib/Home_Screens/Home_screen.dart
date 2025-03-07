import 'package:flutter/material.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:get/get.dart';

import '../DiseasesAndCure/diseases_cure.dart';
import '../MyTournaments/my_tournaments.dart';
import '../Practice/practice.dart';
import '../Tournaments/tournaments.dart';
import '../Appbar/appbar_code.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'follow text'.tr,
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
                  'wlm text'.tr,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'wlm2 text'.tr,
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
                          padding:
                              const EdgeInsets.only(bottom: 90.0, left: 130),
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
                          'tour text'.tr,
                          style: TextStyle(fontSize: 20, color: Colors.white),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Tournaments()));
                  },
                  child: Container(
                    alignment: Alignment.topLeft,
                    height: 140,
                    width: 180,
                    child: Stack(alignment: Alignment.center, children: [
                      Center(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(bottom: 90.0, left: 130),
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
                          'toure text'.tr,
                          style: TextStyle(fontSize: 20, color: Colors.white),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Practice()));
                  },
                  child: Container(
                    alignment: Alignment.topLeft,
                    height: 140,
                    width: 180,
                    child: Stack(alignment: Alignment.center, children: [
                      Center(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(bottom: 90.0, left: 130),
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
                          'prc text'.tr,
                          style: TextStyle(fontSize: 20, color: Colors.white),
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
                          padding:
                              const EdgeInsets.only(bottom: 90.0, left: 130),
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
                          'dise text'.tr,
                          style: TextStyle(fontSize: 20, color: Colors.white),
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
                  "discover text".tr,
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
                  "use text".tr,
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
      ), currentScreen: 'HomeScreen',
    );
  }
}
