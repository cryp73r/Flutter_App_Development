import 'package:flutter/material.dart';
import 'package:login_app/ui/CustomLoginForm.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Login';
    return new Scaffold(
      appBar: new AppBar(
        title: Text(appTitle),
        centerTitle: true,
      ),
      backgroundColor: Colors.blueGrey,
      body: CustomLoginForm(),
    );
    throw UnimplementedError();
  }
}

