import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // future: getJsonData(apiUrl),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
      if (snapshot.hasData) {
        Map rawData = snapshot.data;
        return successResult(rawData);
      }
      return Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Container(
                margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              ),
              Text(
                "Hold Tight - Getting your Stuff Ready...",
                style: TextStyle(
                  letterSpacing: 2.0,
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget successResult(Map rawData) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Wrap(
        children: [],
      ),
    );
  }
}
