import 'package:flutter/material.dart';
import 'package:yts_mx/screens/home.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: darkThemeData(context),
      themeMode: ThemeMode.dark,
      title: "YTS.MX",
      home: Home(),
    );
  }

  ThemeData darkThemeData(BuildContext context) {
    return ThemeData(
      //0xFF6AC045
      brightness: Brightness.dark,
      primarySwatch: Colors.green,
      primaryColor: Color(0xFF1D1D1D),
      backgroundColor: Color(0xFF171717),
      indicatorColor: Color(0xff0e1d36),
      buttonColor: Color(0xff3B3B3B),
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
