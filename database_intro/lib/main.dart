import 'package:database_intro/models/user.dart';
import 'package:database_intro/utils/database_helper.dart';
import 'package:flutter/material.dart';

List _users;

void main() async {

  runApp(
    MaterialApp(
      title: "Database",
      home: Home(),
    )
  );

  var db = new DatabaseHelper();

  //Add User
  await db.saveUser(User("Bot", "Baba"));
  int count = await db.getCount();
  print("User saved $count");

  //Get all users
  _users = await db.getAllUsers();
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Database"),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: ListView.builder(
        itemCount: _users.length,
          itemBuilder: (_, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              title: Text("User: ${User.fromMap(_users[position]).username}"),
              subtitle: Text("ID: ${User.fromMap(_users[position]).id}"),
            ),
          );
          }),
    );
  }
}
