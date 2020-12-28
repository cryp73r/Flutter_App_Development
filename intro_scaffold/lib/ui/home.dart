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
      floatingActionButton: new FloatingActionButton(onPressed: () => debugPrint('Pressed'),
        backgroundColor: Colors.lightGreen,
        tooltip: 'Going Up!',
        child: new Icon(Icons.call_missed),
      ),
      // `title` has been deprecated now, instead use `label`
      bottomNavigationBar: new BottomNavigationBar(items: [
        new BottomNavigationBarItem(icon: new Icon(Icons.add), label: 'Hey'),
        new BottomNavigationBarItem(icon: new Icon(Icons.print), label: 'Nope'),
        new BottomNavigationBarItem(icon: new Icon(Icons.call_missed), label: 'Hello')
      ], onTap: (int i) => debugPrint('Hey Touched $i'),),
    );
    throw UnimplementedError();
  }
  
}