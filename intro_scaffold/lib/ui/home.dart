import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  void _onPress() {
      print('Search Tapped');
      }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.amberAccent,
        title: new Text('Fancy Day'),
        actions: [
          new IconButton(icon: new Icon(Icons.send), onPressed: () => debugPrint('Icon Tapped!')),
          new IconButton(icon: new Icon(Icons.search), onPressed: _onPress)
        ],
      ),
      backgroundColor: Colors.grey.shade100,
      body: new Container(
        alignment: Alignment.center,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Text(
              'Bonni',
              style: new TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w400,
                color: Colors.deepOrange
              ),),
            new InkWell(
              child: new Text('Button'),

              onTap: () => debugPrint('Button Tapped!'),
            )
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
  
}