import 'package:flutter/material.dart';

class CounterAnimator extends StatefulWidget {
  @override
  _CounterAnimatorState createState() => _CounterAnimatorState();
}

class _CounterAnimatorState extends State<CounterAnimator> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
        vsync: this);
    animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.addListener(() {
      this.setState(() {
        _counter++;
        debugPrint("Print $_counter");
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(
        _controller.isAnimating
            ? (_counter).toStringAsFixed(2)
            : "Let's Begin",
        style: TextStyle(
          fontSize: 24.0 * _controller.value + 16.0
        ),
      ),
      onTap: () {
        _controller.forward(from: 0.0);
      },
    );
  }
}
