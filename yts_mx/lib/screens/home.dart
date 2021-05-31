import 'package:flutter/material.dart';
import 'package:yts_mx/screens/appDrawer.dart';
import 'package:yts_mx/screens/homeScreen.dart';


class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _activated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "images/logo-YTS.png",
        ),
        actions: [
          searchButton(context),
          filterButton(context),
        ],
      ),
      body: HomeScreen(),
      drawer: appDrawer(context),
    );
  }

  IconButton searchButton(BuildContext context) {
    return IconButton(
      tooltip: "Search",
      icon: Icon(
        Icons.search,
        size: 30.0,
      ),
      onPressed: () {
        Navigator.pushNamed(context, "/searchScreen");
      },
    );
  }

  IconButton filterButton(BuildContext context) {
    return IconButton(
      tooltip: "Filter",
      icon: Icon(
        _activated?Icons.clear:Icons.filter_alt,
        size: 30.0,
      ),
      onPressed: () {
        if (_activated) {
          _activated = false;
        } else {
          _activated = true;
        }
        setState(() {});
      },
    );
  }
}
