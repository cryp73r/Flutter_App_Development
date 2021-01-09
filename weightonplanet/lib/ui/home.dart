import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int radioValue = 0;

  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;

      print(radioValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weight on Planet X'),
        centerTitle: true,
        backgroundColor: Colors.black38,
      ),
      backgroundColor: Colors.blueGrey,
      body: new Container(
        alignment: Alignment.topCenter,
        child: ListView(
          padding: const EdgeInsets.all(2.5),
          children: [
            Image.asset(
              'images/planet.png',
              height: 133.0,
              width: 200.0,),

            new Container(
              margin: EdgeInsets.all(3.0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  TextField(
                    controller: null,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Your Weight',
                        hintText: 'In Pounds',
                        icon: Icon(Icons.person_outline)
                    ),
                  ),
                  new Padding(padding: new EdgeInsets.all(5.0)),
                //  three new Radio Button
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Radio<int>(
                        activeColor: Colors.brown,
                          value: 0, groupValue: radioValue, onChanged: handleRadioValueChanged),

                      new Text(
                        'Pluto',
                        style: TextStyle(color: Colors.white30),
                      ),

                      new Radio<int>(
                        activeColor: Colors.redAccent,
                          value: 1, groupValue: radioValue, onChanged: handleRadioValueChanged),

                      new Text(
                        'Mars',
                        style: TextStyle(color: Colors.white30),
                      ),

                      new Radio<int>(
                        activeColor: Colors.orangeAccent,
                          value: 2, groupValue: radioValue, onChanged: handleRadioValueChanged),

                      new Text(
                        'Venus',
                        style: TextStyle(color: Colors.white30),
                      )
                    ],
                  ),
                //  Result text
                  Padding(
                    padding: const EdgeInsets.all(15.6),
                    child: new Text(
                      'Hello There',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19.4,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
