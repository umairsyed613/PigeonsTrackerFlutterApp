import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pigeon_tracker/appbar_code.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
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
          textDirection: Locale == 'en' ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white,
          ),
        )),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 255),
            child: Text(
              'Contact',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 260.0),
            child: Text(
              'How to use',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          YoutubePlayer(
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
        ],
      ),
    );
  }
}
