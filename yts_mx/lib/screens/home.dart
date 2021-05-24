import 'package:flutter/material.dart';
import 'package:yts_mx/screens/homeScreen.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("images/logo-YTS.png",),
        actions: [
          searchButton(),
        ],
      ),
      body: HomeScreen(),
    );
  }

  IconButton searchButton() {
    return IconButton(
        icon: Icon(Icons.search),
        onPressed: () => debugPrint("Search"),
    );
  }
}
