import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:klimatic_weather/util/utils.dart' as utils;

class Klimatic extends StatefulWidget {
  @override
  _KlimaticState createState() => _KlimaticState();
}

class _KlimaticState extends State<Klimatic> {
  Map data;
  
  void showStuff() async {
    data = await getWeather(utils.apiId, utils.defaultCity);
    print(data.toString());
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
              onPressed: () => showStuff()
          )
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Image.asset('images/umbrella.png',
            width: 490.0,
              height: 1200.0,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.fromLTRB(0.0, 10.9, 20.9, 0.0),
            child: Text(
              'Lucknow',
              style: cityStyle()
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset('images/light_rain.png'),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(30.0, 290.0, 0.0, 0.0),
            alignment: Alignment.center,
            child: Text('67.8',
              style: tempStyle(),
            ),
          ),
        ],
      ),
    );
  }
  Future<Map> getWeather(String apiId, String city) async {
    String apiUrl = 'http://api.openweathermap.org/data/2.5/weather?q=$city&APPID=${utils.apiId}&units=metric';
    http.Response response = await http.get(apiUrl);
    return json.decode(response.body);
  }
}

TextStyle cityStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 22.9,
    fontStyle: FontStyle.italic
  );
}

TextStyle tempStyle() {
  return TextStyle(
    color: Colors.white,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontSize: 49.9
  );
}