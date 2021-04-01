import 'package:flutter/material.dart';
import 'package:todo/utils/todo_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo List"),
        backgroundColor: Colors.black54,
      ),
      body: ToDoScreen(),
    );
  }
}
