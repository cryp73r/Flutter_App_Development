import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MakeItRainState();
    throw UnimplementedError();
  }

}

class MakeItRainState extends State<Home> {
  int _moneyCounter=0;

  void _rainMoney() {
    // Important - setState is called each time we need to update the UI
    setState(() {
      _moneyCounter += 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Make it Rain'),
        backgroundColor: Colors.lightGreen,
      ),
      body: new Container(
        child: new Column(
          children: [
            new Center(
                child: new Text('Get Rich!',
                  style: new TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 29.9
                  ),
                )
            ),
            new Expanded(
                child: new Center(
                  child: new Text('\$$_moneyCounter',
                  style: new TextStyle(
                    color: _moneyCounter > 2000 ? Colors.red : _moneyCounter > 1500 ? Colors.blueAccent : _moneyCounter > 1000 ? Colors.green : _moneyCounter > 500 ? Colors.lightGreen : Colors.black54,
                    fontSize: 46.9,
                    fontWeight: FontWeight.w800
                  ),
                  ),
                )
            ),
            new Expanded(
                child: new Center(
                  child: _moneyCounter > 5000 ? new Text('F*CK! You are Rich now...',
                  style: new TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w900
                  ),
                  ) : new Text('Hit More...',
                    style: new TextStyle(
                      color: Colors.deepOrangeAccent,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w800
                    ),
                  ),
                )
            ),
            new Expanded(
                child: new Center(
                  child: new FlatButton(
                    color: Colors.lightGreen,
                      textColor: Colors.white70,
                      onPressed: () => _rainMoney(),
                      child: new Text('Let It Rain!',
                  style: new TextStyle(
                    fontSize: 19.9,
                  ),)
                  ),
                )
            )
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }

}
