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

  List<LatLng> markers_list = [];
  List<LatLng> markers_list2 = [LatLng(12.920629, 77.651579), LatLng(12.917349, 77.651688), LatLng(12.912008, 77.651805), LatLng(12.911945, 77.649056), LatLng(12.910818, 77.649128), LatLng(12.909575, 77.64927), LatLng(12.9087, 77.649278), LatLng(12.909111, 77.644619), LatLng(12.908638, 77.644535), LatLng(12.904794, 77.644329), LatLng(12.905141, 77.642651), LatLng(12.906205, 77.642638), LatLng(12.906163, 77.641246), LatLng(12.90883, 77.641371), LatLng(12.908832, 77.641755)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map view'),
        actions: [
          IconButton(
              onPressed: _cleaRMarkers,
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              )),
          IconButton(
              onPressed: _clearLastMarker,
              icon: const Icon(
                Icons.undo,
                color: Colors.white,
              ))
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: LatLng(12.924, 77.558),
              zoom: 18.0,
              maxZoom: 18.0,
              rotation: 180.0,
              keepAlive: true,
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
              PolylineLayer(
                polylines: [
                  Polyline(points: markers_list2, strokeWidth: 6.0)
                ],
              )
            ],
          ),
          // Container(child: Center(child: Text('Current tap $tap_pos_x, $tap_pos_y')),)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Clipboard.setData(ClipboardData(text: markers_list.toString()));
        },
        child: const Icon(
          Icons.copy,
          color: Colors.white,
        ),
      ),
    );
  }
}
