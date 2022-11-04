// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          child: MyButton(),
        ),
      ),
    ),
  );
}

class SimpStuff extends StatefulWidget {
  const SimpStuff({super.key});

  @override
  State<SimpStuff> createState() => _SimpStuffState();
}

class _SimpStuffState extends State<SimpStuff> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.headphones, color: Colors.amber,),
        title: const Text('How are you'),
        actions: const [
          Icon(Icons.navigate_next),
        ],
      ),
      body: const Text('This is crazy man'),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        int a = 1;
      },
      child: Container(
        height: 50.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.lightGreen[500],
        ),
        child: const Center(
          child: Text('Engage', style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}