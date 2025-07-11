import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pigeon_tracker/Home_Screens/Home_screen.dart';
import 'package:pigeon_tracker/LocaleString.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        translations: LocaleString(),
        locale: Locale('en', 'US'),
        fallbackLocale: Locale('en', 'US'),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        localeResolutionCallback: (locale, supportedLocales) {
          return supportedLocales.firstWhere(
              (supportedLocale) =>
                  supportedLocale.languageCode == locale?.languageCode,
              orElse: () => Locale('en'));
        },
        home: AnimatedSplashScreen(
          splash: 'assets/images/1.gif',
          splashIconSize: 300.0,
          centered: true,
          backgroundColor: Colors.white,
          nextScreen: const HomeScreen(),
          duration: 3500,
        ));
  }
}
