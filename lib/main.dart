import 'package:flutter/material.dart';

class CounterDisplay extends StatelessWidget {
  const CounterDisplay({required this.count, super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Text('Count: $count');
  }
}

class CounterIncrementor extends StatelessWidget {
  const CounterIncrementor({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Increment'),
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;
  double velocity = 0.0;

  void _increment() {
    setState(() {
      ++_counter;
    });
  }

  void _updateVel(velocity_) {
    setState(() {
      velocity = velocity_;
      if(velocity < 0) { // Swipe left
        --_counter;
      } else { // Swipe right
        ++_counter;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CounterIncrementor(onPressed: _increment),
          const SizedBox(width: 16),
          CounterDisplay(count: _counter),
        ],
      ),
      GestureDetector(
          onHorizontalDragEnd: ((details) {
            _updateVel(details.primaryVelocity);
          }),
          child: Container(
            decoration: const BoxDecoration(color: Colors.blue),
            height: 60,
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const Center(
                child: Text('Swipe to Increment / Decrement',
                    style: TextStyle(color: Colors.white))),
          )),
      Container(
        height: 30.0,
      ),
      Center(
          child: Text(
        'Speed: $velocity',
      ))
    ]);
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Counter(),
        ),
      ),
    ),
  );
}
