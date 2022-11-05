// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Map(),
  ));
}

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('MapView')),
        body: Column(
          children: [
            Image.asset('./assets/bird.jpg'),
            Container(
              height: 30,
            ),
            const Center(child: Text('This is an image of a bird'))
          ],
        ));
  }
}
