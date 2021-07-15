import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yts_mx/screens/appDrawer.dart';
import 'package:yts_mx/screens/homeScreen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool showHome = true;

  _getConnection() async {
    try {
      final checkConnectivity = await InternetAddress.lookup("google.com");
      if (checkConnectivity.isNotEmpty && checkConnectivity[0].rawAddress.isNotEmpty) {
        showHome = true;
      }
    }
    on SocketException catch (_) {
      showHome = false;
    }

  }

  @override
  void initState() {
    _getConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "images/logo-YTS.png",
        ),
        actions: [
          searchButton(context),
        ],
      ),
      body: showHome?HomeScreen():Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text("No Internet Connection. Please Check Connection & Try Again!"),
        TextButton(onPressed: () => Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false),
          child: Text("Retry"),
          style: TextButton.styleFrom(side: BorderSide(color: Colors.green, width: 1.5),
          ),
        ),
      ],),),
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
}