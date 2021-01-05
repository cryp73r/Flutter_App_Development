import 'package:flutter/material.dart';
import 'package:login_app/ui/home.dart';

void main() => runApp(Login());

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Login App';
    return MaterialApp(
      title: appTitle,
      home: Home(),
    );
  }
}
