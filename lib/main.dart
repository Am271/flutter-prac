// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MapView(),
  ));
}

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  List data_points = [];
  double offsetX = 0.0;
  double offsetY = 0.0;

  void _updateOffsetX(velocity) {
    setState(() {
      if (velocity > 0) {
        offsetX += 20;
      } else {
        offsetX -= 20;
      }
    });
  }

  void _updateOffsetY(velocity) {
    setState(() {
      if (velocity > 0) {
        offsetY += 20;
      } else {
        offsetY -= 20;
      }
    });
  }

  void _start() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (offsetX > 300) {
          timer.cancel();
        }
        offsetX += 50;
        offsetY += 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Map View')),
        body: Stack(children: [
          Transform.translate(
              offset: Offset(offsetX, offsetY),
              child: Transform.scale(
                  scale: 4.5,
                  child: ClipRect(
                    child: Image.asset(
                      'assets/map_.png',
                    ),
                  ))),
          GestureDetector(
              // onTap: () {
              //   _start();
              // },
              onHorizontalDragEnd: ((details) {
                _updateOffsetX(details.primaryVelocity);
              }),
              onVerticalDragEnd: (details) {
                _updateOffsetY(details.primaryVelocity);
              },
              child: Container(
                decoration: const BoxDecoration(color: Colors.white),
                height: 120,
                child: Column(
                  children: [
                    Container(
                      height: 10,
                    ),
                    Text(
                      'offset X = $offsetX',
                    ),
                    Container(
                      height: 30,
                    ),
                    Text(
                      'offset Y = $offsetY',
                    ),
                    ElevatedButton(onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: data_points.toString()));
                    }, child: const Text('copy to clipboard!'))
                  ],
                ),
              ))
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            data_points.add([offsetX, offsetY]);
            
          },
          child: const Icon(Icons.navigation),
        ));
  }
}
