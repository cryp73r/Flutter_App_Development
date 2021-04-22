import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy_free_courses/ui/Account.dart';
import 'package:udemy_free_courses/ui/ctgry.dart';
import 'package:udemy_free_courses/ui/home.dart';

class Base extends StatefulWidget {
  @override
  _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Udemy Free Courses"),
        backgroundColor: Colors.redAccent,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueAccent,
        fixedColor: Colors.white,
        selectedIconTheme: IconThemeData(color: Colors.white, size: 26.0),
        unselectedIconTheme: IconThemeData(color: Colors.white70, size: 24.0),
        selectedLabelStyle: TextStyle(color: Colors.white),
        unselectedLabelStyle: TextStyle(color: Colors.white70),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "Category"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_rounded), label: "Account"),
        ],
        onTap: (int i) {
          switch(i) {
            case 0: Home();
                    break;
            case 1: Ctgry();
                    break;
            case 2: Account();
                    break;
          }
        },
      ),
      body: Home(),
    );
  }
}
