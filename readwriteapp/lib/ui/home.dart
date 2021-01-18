import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _enterDataField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ReadWrite'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        padding: const EdgeInsets.all(13.4),
        alignment: Alignment.topCenter,
        child: ListTile(
          title: TextField(
            controller: _enterDataField,
            decoration: InputDecoration(
              labelText: 'Write Something...'
            ),
          ),
          subtitle: FlatButton(
            onPressed: () {
            //  save data to file
              if (_enterDataField.text.isNotEmpty) {
                writeData(_enterDataField.text);
              }
              else {
                writeData('Hello World');
              }
            },
            child: Column(
              children: [
                Text('Save Data'),
                Padding(padding: EdgeInsets.all(14.5)),
                Text('Save data goes here')
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> get _localPath async {
    final directory =
        await getApplicationDocumentsDirectory(); //home/directory:text
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.txt');
  }

//  Write and Read from our file
  Future<File> writeData(String message) async {
    final file = await _localFile;
//    write to file
    return file.writeAsString('$message');
  }

  Future<String> readData() async {
    try {
      final file = await _localFile;
      //  Read
      String data = await file.readAsString();
      return data;
    } catch (e) {
      return 'Nothing Saved Yet';
    }
  }
}
