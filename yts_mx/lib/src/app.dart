import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yts_mx/screens/aboutUsScreen.dart';
import 'package:yts_mx/screens/announcementScreen.dart';
import 'package:yts_mx/screens/home.dart';
import 'package:yts_mx/screens/homeScreen.dart';
import 'package:yts_mx/screens/howToDownloadScreen.dart';
import 'package:yts_mx/screens/searchScreen.dart';
import 'package:yts_mx/screens/trackerListScreen.dart';
import 'package:yts_mx/screens/updateAppScreen.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: darkThemeData(context),
      themeMode: ThemeMode.dark,
      title: "YTS.MX",
      home: Home(),
      routes: {
        "/home": (_) => Home(),
        "/homeScreen": (_) => HomeScreen(),
        "/announcementScreen": (_) => AnnouncementScreen(),
        "/howToDownloadScreen": (_) => HowToDownloadScreen(),
        "/trackerListScreen": (_) => TrackerListScreen(),
        "/updateAppScreen": (_) => UpdateAppScreen(),
        "/aboutUsScreen": (_) => AboutUsScreen(),
        "/searchScreen": (_) => SearchScreen(),
      },
    );
  }

  ThemeData darkThemeData(BuildContext context) {
    return ThemeData(
      //0xFF6AC045
      brightness: Brightness.dark,
      primarySwatch: Colors.green,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.green,
        accentColor: Color(0xFF1D1D1D),
        brightness: Brightness.dark
      ),
      backgroundColor: Color(0xFF171717),
      indicatorColor: Color(0xff0e1d36),
      hintColor: Color(0xff280C0B),
      highlightColor: Color(0xff372901),
      hoverColor: Color(0xff3a3a3b),
      focusColor: Color(0xff0b2512),
      disabledColor: Colors.grey,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: Colors.white,
      ),
      cardColor: Color(0xFF151515),
      canvasColor: Colors.black,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme: ColorScheme.dark(),
          ),
    );
  }
}
