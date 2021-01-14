import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:klimatic_weather/util/utils.dart' as utils;

class Klimatic extends StatefulWidget {
  @override
  _KlimaticState createState() => _KlimaticState();
}

class _KlimaticState extends State<Klimatic> {

  String _cityEntered;

  Future _goToNextScreen(BuildContext context) async {
    Map results = await Navigator.of(context)
        .push(MaterialPageRoute<Map>(builder: (BuildContext context) {
      return ChangeCity();
    }));
    if (results != null && results.containsKey('enter')) {
      _cityEntered = results['enter'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Klimatic'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                _goToNextScreen(context);
              })
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'images/umbrella.png',
              width: 490.0,
              height: 1200.0,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.fromLTRB(0.0, 10.9, 20.9, 0.0),
            child: Text('${_cityEntered == null ? utils.defaultCity : _cityEntered}', style: cityStyle()),
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset('images/light_rain.png'),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(30.0, 290.0, 0.0, 0.0),
            alignment: Alignment.center,
            child: updateTempWidget(_cityEntered),
          ),
        ],
      ),
    );
  }

  Future<Map> getWeather(String apiId, String city) async {
    String apiUrl =
        'http://api.openweathermap.org/data/2.5/weather?q=$city&APPID=${utils.apiId}&units=metric';
    http.Response response = await http.get(apiUrl);
    return json.decode(response.body);
  }

  Widget updateTempWidget(String city) {
    return FutureBuilder(
        future: getWeather(utils.apiId, city == null ? utils.defaultCity : city),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          // where we get all of the json data, we setup widgets etc
          if (snapshot.hasData) {
            Map content = snapshot.data;
            return Container(
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      '${content['main']['temp']}°C',
                      style: tempStyle(),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}

class ChangeCity extends StatelessWidget {
  var _cityFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Change City'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'images/white_snow.png',
              width: 490.0,
              height: 1200.0,
              fit: BoxFit.fill,
            ),
          ),
          ListView(
            children: [
              ListTile(
                title: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter City'
                  ),
                  controller: _cityFieldController,
                  keyboardType: TextInputType.text,
                ),
              ),
              ListTile(
                title: FlatButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      'enter': _cityFieldController.text
                    });
                  },
                  textColor: Colors.white70,
                  color: Colors.redAccent,
                  child: Text('Get Weather'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

TextStyle cityStyle() {
  return TextStyle(
      color: Colors.white, fontSize: 22.9, fontStyle: FontStyle.italic);
}

TextStyle tempStyle() {
  return TextStyle(
      color: Colors.white,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 49.9);
}
