import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double inches = 0.0;
  double result = 0.0;
  String _resultReading = '';
  String _finalResult = '';

  void _calculateBMI() {
    setState(() {
      int age = int.parse(_ageController.text);
      double height = double.parse(_heightController.text);
      inches = height * 12;
      double weight = double.parse(_weightController.text);

      if ((_ageController.text.isNotEmpty || age > 0)
      && (_heightController.text.isNotEmpty || inches > 0)
      && (_weightController.text.isNotEmpty || weight > 0)) {
        result = weight / (inches * inches) * 703;
        
        if (double.parse(result.toStringAsFixed(1)) < 18.5) {
          _resultReading = 'Underweight';
        }
        else if (double.parse(result.toStringAsFixed(1)) >= 18.5
        && result < 25) {
          _resultReading = 'Great Shape';
        }
        else if (double.parse(result.toStringAsFixed(1)) > 25.0
        && result < 30) {
          _resultReading = 'Overweight';
        }
        else if (double.parse(result.toStringAsFixed(1)) >= 30.0) {
          _resultReading = 'Obese';
        }
      }
      else {
        result = 0.0;
      }
    });
    _finalResult = 'Your BMI: ${result.toStringAsFixed(1)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        child: ListView(
          padding: const EdgeInsets.all(2.0),
          children: [
            Image.asset(
                'images/bmilogo.png',
              height: 85.0,
              width: 75.0,
            ),
            new Container(
              margin: const EdgeInsets.all(3.0),
              height: 250.0,
              width: 290.0,
              color: Colors.grey.shade300,
              child: Column(
                children: [
                  TextField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      hintText: 'e.g: 34',
                      icon: Icon(Icons.person_outline)
                    ),
                  ),
                  TextField(
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Height',
                        hintText: 'e.g: 6.5',
                        icon: Icon(Icons.insert_chart)
                    ),
                  ),
                  TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Weight in lbs',
                        hintText: 'e.g: 180',
                        icon: Icon(Icons.line_weight)
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10.6)),
                  // Calculate button
                  Container(
                    alignment: Alignment.center,
                    child: RaisedButton(
                      onPressed: _calculateBMI,
                      color: Colors.pinkAccent,
                      child: Text('Calculate'),
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    '$_finalResult',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    fontSize: 19.9
                  ),
                ),
                Padding(padding: const EdgeInsets.all(5.0),),
                Text(
                  '$_resultReading',
                  style: TextStyle(
                      color: Colors.pinkAccent,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      fontSize: 19.9
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
