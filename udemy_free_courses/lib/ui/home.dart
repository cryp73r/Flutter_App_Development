import 'package:flutter/material.dart';
import 'package:udemy_free_courses/utils/rQuery.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return xyz();
  }
}

Widget xyz() {
  return FutureBuilder(
      future: getQuery(),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        // where we get all of the json data, we setup widgets etc
        if (snapshot.hasData) {
          Map content = snapshot.data;
          return Container(
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    '${content['count']}°C',
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
