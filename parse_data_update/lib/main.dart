import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// https://jsonplaceholder.typicode.com/posts

void main() async {
  List _data = await getJSON();
  print('Data: $_data');
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('JSON Parsing'),
          backgroundColor: Colors.orange,
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: _data.length,
          padding: const EdgeInsets.all(4.4),
          itemBuilder: (BuildContext context, int position) {
            return Column(
              children: [
                Divider(height: 13.4,),
                ListTile(
                  title: Text(_data[position]['title'],
                  style: TextStyle(
                    fontSize: 17.2,
                    fontWeight: FontWeight.bold,
                  ),),
                  subtitle: Text(_data[position]['body'],
                  style: TextStyle(
                    fontSize: 15.0,
                    fontStyle: FontStyle.italic,
                  )),
                  leading: CircleAvatar(
                    // radius: 35.6,
                    backgroundColor: Colors.orange,
                    child: Text(_data[position]['title'][0].toString().toUpperCase()),
                  ),
                  onTap: () => showTapMessage(context, _data[position]['title']),
                )
              ],
            );
          },
        ),
      ),
    )
  );
}

void showTapMessage(BuildContext context, String message) {
  var alertDialog = AlertDialog(
    title: Text(message),
    actions: [
      FlatButton(onPressed: () => Navigator.of(context).pop(),
      child: Text('OK'),)
    ],
  );
  showDialog(context: context, builder: (context) {
    return alertDialog;
  });
}

Future<List> getJSON() async {
  String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  http.Response response = await http.get(apiUrl);
  return json.decode(response.body);
}