import 'dart:math';

import 'package:flutter/material.dart';

class DicePage extends StatefulWidget {
  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  int _firstDiceValue = 1;
  int _secondDiceValue = 1;
  int wallet = 0;
  final List<String> _diceFaces = [
    '⚀',
    '⚁',
    '⚂',
    '⚃',
    '⚄',
    '⚅',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: pi).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _firstDiceValue = Random().nextInt(6) + 1;
            _secondDiceValue = Random().nextInt(6) + 1;
          });
          _controller.reverse();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _rollDice() {
    if (_controller.isAnimating) return;
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    int total = _firstDiceValue + _secondDiceValue;
    wallet += total;
    return Scaffold(
        appBar: AppBar(
          title: Text('3D Dice'),
          backgroundColor: Colors.black,
        ),
        body: Center(
            child: GestureDetector(
                onTap: _rollDice,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Tap On Dice',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 30),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              return Transform(
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.001)
                                  ..rotateX(_animation.value),
                                alignment: FractionalOffset.center,
                                child: Transform(
                                  transform: Matrix4.identity()
                                    ..setEntry(3, 2, 0.001)
                                    ..rotateY(_animation.value),
                                  alignment: FractionalOffset.center,
                                  child: Text(
                                    _diceFaces[_firstDiceValue - 1],
                                    style: const TextStyle(
                                      fontSize: 150,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(width: 50),
                          AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              return Transform(
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.001)
                                  ..rotateX(_animation.value),
                                alignment: FractionalOffset.center,
                                child: Transform(
                                  transform: Matrix4.identity()
                                    ..setEntry(3, 2, 0.001)
                                    ..rotateY(_animation.value),
                                  alignment: FractionalOffset.center,
                                  child: Text(
                                    _diceFaces[_secondDiceValue - 1],
                                    style: const TextStyle(
                                      fontSize: 150,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      Text(
                        'Current Total: $total',
                        style: TextStyle(
                            color: Colors.deepPurple.shade900,
                            fontWeight: FontWeight.w200,
                            fontSize: 30),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Wallet Balance: $wallet',
                        style: TextStyle(
                            color: Colors.green.shade900,
                            fontWeight: FontWeight.w200,
                            fontSize: 30),
                      ),
                    ]))));
  }
}
