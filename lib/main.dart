// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';

void main() {
  runApp(const MaterialApp(
    home: ExMap(),
  ));
}

class ExMap extends StatefulWidget {
  const ExMap({super.key});

  @override
  State<ExMap> createState() => _ExMapState();
}

class _ExMapState extends State<ExMap> {
  List<Marker> _getMarkers() {
    List<Marker> markers = [];

    for (int i = 0; i < markers_list.length; i++) {
      markers.add(Marker(
        point: LatLng(markers_list[i].latitude, markers_list[i].longitude),
        width: 80,
        height: 80,
        builder: (context) => const Icon(
          Icons.location_pin,
          size: 40,
          color: Colors.red,
        ),
      ));
    }

    return markers;
  }

  void _cleaRMarkers() {
    setState(() {
      markers_list.clear();
    });
  }

  void _clearLastMarker() {
    setState(() {
      markers_list.removeLast();
    });
  }

  List markers_list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map view'),
        actions: [
          IconButton(onPressed: _cleaRMarkers, icon: const Icon(Icons.delete, color: Colors.white,)),
          IconButton(onPressed: _clearLastMarker, icon: const Icon(Icons.undo, color: Colors.white,))
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: LatLng(12.924, 77.558),
              zoom: 18.0,
              onTap: (tapPosition, point) {
                setState(() {
                  markers_list.add(point);
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'http://mt1.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(markers: _getMarkers()),
            ],
          ),
          // Container(child: Center(child: Text('Current tap $tap_pos_x, $tap_pos_y')),)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Clipboard.setData(ClipboardData(text: markers_list.toString()));
        },
        child: const Icon(Icons.copy, color: Colors.white,),
      ),
    );
  }
}
