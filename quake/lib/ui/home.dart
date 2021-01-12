import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatelessWidget {
  Map _data;

  Home(Map data) {
    this._data = data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quakes'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _data['features'].length,
          padding: const EdgeInsets.all(15.0),
          itemBuilder: (BuildContext context, int position) {
            //  creating the rows for our listview
            if (position.isOdd) return Divider();
            final index =
                position ~/ 2; // we will get result as int on division by 2
            var format = DateFormat.yMMMd('en_US').add_jm();

            var date = format.format(DateTime.fromMicrosecondsSinceEpoch(
                _data['features'][index]['properties']['time'] * 1000));

            return ListTile(
              title: Text(
                'At: $date',
                style: TextStyle(
                    fontSize: 15.5,
                    color: Colors.orange,
                    fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                '${_data['features'][index]['properties']['place']}',
                style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic),
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Text(
                  (_data['features'][index]['properties']['mag'])
                      .toStringAsFixed(2),
                  style: TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontStyle: FontStyle.normal),
                ),
              ),
              onTap: () {
                _showAlertMessage(context,
                    '${_data['features'][index]['properties']['title']}');
              },
            );
          },
        ),
      ),
    );
  }

  void _showAlertMessage(BuildContext context, String message) {
    var alert = AlertDialog(
      title: Text('Quakes'),
      content: Text(message),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'))
      ],
    );
    showDialog(context: context, child: alert);
  }
}
