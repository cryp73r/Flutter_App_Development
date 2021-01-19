import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _enterDataField = TextEditingController();
  String data;
  String _savedData = '';

  void displayData() async {
    data = await readData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadSavedData();
  }

  _loadSavedData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      if (preferences.getString('data').isNotEmpty && preferences.getString('data')!= null) {
        _savedData = preferences.getString('data');
      }
      else {
        _savedData = 'Empty SP';
      }
    });
  }

  _saveMessage(String message) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('data', message);
  }

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
              _saveMessage(_enterDataField.text);
              displayData();
              print(data);
            },
            child: Column(
              children: [
                Text('Save Data'),
                Padding(padding: EdgeInsets.all(14.5)),
                FutureBuilder(
                  future: readData(),
                    builder: (BuildContext context, AsyncSnapshot<String> data) {
                    if (data.hasData != null) {
                      return Text(data.data.toString(),
                      style: TextStyle(
                        color: Colors.blueAccent
                      ),);
                    }
                    else {
                      return Text('No data saved');
                    }
                    },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
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
