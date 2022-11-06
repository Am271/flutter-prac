// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
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
  List<LatLng> getPoints(int m2, double x1, double y1, double x2, double y2) {
    // ArrayList<double[]> a = new ArrayList<double[]>();
    List<LatLng> a = [];
    int no_of_points = m2;
    a.add(LatLng(x1, y1));
    int m1 = 1;
    final int ratio_sum = m2 + 1;
    for (int i = 0; i < no_of_points; i++) {
      double temp_x = ((m2 * x1) + (m1 * x2)) / (ratio_sum);
      double temp_y = ((m2 * y1) + (m1 * y2)) / (ratio_sum);
      a.add(LatLng(temp_x, temp_y));
      m1++;
      m2--;
    }

    a.add(LatLng(x2, y2));
    return a;
  }

  List<Marker> _getMarkers() {
    List<Marker> markers = [];

    if (ambulance_loc_index + 1 >= markers_list2.length) {
      return [];
    }

    List<LatLng> temp = getPoints(
        5,
        markers_list2[ambulance_loc_index].latitude,
        markers_list2[ambulance_loc_index].longitude,
        markers_list2[ambulance_loc_index + 1].latitude,
        markers_list2[ambulance_loc_index + 1].longitude);

    for (int i = 0; i < temp.length; i++) {
      markers.add(Marker(
        point: temp[i],
        builder: (context) => const Icon(
          Icons.train,
          size: 25,
          color: Colors.purple,
        ),
      ));
    }

    return markers;
  }

  void _getAmbPos() {
    List<Marker> x = _getMarkers();
    int i = 0;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        ambulance_marker = x[i];
      });
      i++;
      if (i == x.length) {
        timer.cancel();
      }
    });

    ambulance_loc_index++;
  }

  List<Polyline> _getPolylines(markers_tp, marker_color) {
    List<Polyline> pl = [];

    for (int i = 0; i + 1 < markers_tp.length; i += 2) {
      pl.add(Polyline(
          points: [markers_tp[i], markers_tp[i + 1]],
          strokeWidth: 3.0,
          color: marker_color));
    }

    return pl;
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

  LatLng plot_center = LatLng(12.912111, 77.646641);
  LatLng user_loc = LatLng(12.920758, 77.651571);
  int ambulance_loc_index = 0;
  Marker ambulance_marker = Marker(
      point: LatLng(0.0, 0.0),
      builder: ((context) => const Icon(
            Icons.train,
            size: 30,
            color: Colors.purple,
          )));
  double user_loc_size = 20;
  List<LatLng> markers_list = [];
  List<LatLng> markers_list2 = [
    LatLng(12.920629, 77.651579),
    LatLng(12.917349, 77.651688),
    LatLng(12.912008, 77.651805),
    LatLng(12.911945, 77.649056),
    LatLng(12.910818, 77.649128),
    LatLng(12.909575, 77.64927),
    LatLng(12.9087, 77.649278),
    LatLng(12.909111, 77.644619),
    LatLng(12.908638, 77.644535),
    LatLng(12.904794, 77.644329),
    LatLng(12.905141, 77.642651),
    LatLng(12.906205, 77.642638),
    LatLng(12.906163, 77.641246),
    LatLng(12.90883, 77.641371),
    LatLng(12.908832, 77.641755)
  ];
  List<LatLng> red_markers = [
    LatLng(12.920614, 77.651545),
    LatLng(12.920731, 77.649431),
    LatLng(12.920731, 77.649406),
    LatLng(12.920113, 77.649299),
    LatLng(12.918534, 77.651664),
    LatLng(12.91804, 77.651664),
    LatLng(12.913971, 77.651773),
    LatLng(12.913426, 77.65177),
    LatLng(12.911941, 77.649289),
    LatLng(12.91194, 77.649022),
    LatLng(12.911956, 77.649021),
    LatLng(12.911661, 77.649066),
    LatLng(12.908864, 77.647258),
    LatLng(12.908881, 77.646886),
    LatLng(12.906306, 77.644184),
    LatLng(12.906225, 77.642674),
    LatLng(12.909062, 77.644278),
    LatLng(12.907768, 77.644267),
    LatLng(12.911936, 77.646993),
    LatLng(12.912135, 77.644653),
    LatLng(12.912159, 77.644658),
    LatLng(12.910664, 77.644566),
    LatLng(12.912988, 77.651895),
    LatLng(12.913085, 77.653508)
  ];

  List<LatLng> blue_markers = [
    LatLng(12.920594, 77.651579),
    LatLng(12.919034, 77.651637),
    LatLng(12.917427, 77.651675),
    LatLng(12.914504, 77.65176),
    LatLng(12.912802, 77.651826),
    LatLng(12.91205, 77.65183),
    LatLng(12.912017, 77.651822),
    LatLng(12.911907, 77.649524),
    LatLng(12.911516, 77.649076),
    LatLng(12.909235, 77.649296),
    LatLng(12.908766, 77.64869),
    LatLng(12.908871, 77.647529),
    LatLng(12.908994, 77.645916),
    LatLng(12.909082, 77.644598),
    LatLng(12.9091, 77.644591),
    LatLng(12.904789, 77.644331),
    LatLng(12.90477, 77.644323),
    LatLng(12.90495, 77.643559),
    LatLng(12.905078, 77.643042),
    LatLng(12.905153, 77.642685),
    LatLng(12.905148, 77.642659),
    LatLng(12.905995, 77.642637),
    LatLng(12.906214, 77.642401),
    LatLng(12.906181, 77.641256),
    LatLng(12.906192, 77.64122),
    LatLng(12.908838, 77.641353),
    LatLng(12.908855, 77.641365),
    LatLng(12.908856, 77.641741)
  ];

  List<LatLng> orange_markers = [
    LatLng(12.91899, 77.651639),
    LatLng(12.918589, 77.651674),
    LatLng(12.918025, 77.65169),
    LatLng(12.917453, 77.651718),
    LatLng(12.914476, 77.651759),
    LatLng(12.913985, 77.651772),
    LatLng(12.913436, 77.651779),
    LatLng(12.912809, 77.651816),
    LatLng(12.911904, 77.649482),
    LatLng(12.911942, 77.649318),
    LatLng(12.911628, 77.64908),
    LatLng(12.911544, 77.649092),
    LatLng(12.90925, 77.649303),
    LatLng(12.908686, 77.649324),
    LatLng(12.908679, 77.649278),
    LatLng(12.908743, 77.64868),
    LatLng(12.908837, 77.647503),
    LatLng(12.908878, 77.647305),
    LatLng(12.908909, 77.646864),
    LatLng(12.90899, 77.645893),
    LatLng(12.904955, 77.643536),
    LatLng(12.905059, 77.643067),
    LatLng(12.906042, 77.642665),
    LatLng(12.906221, 77.642651),
    LatLng(12.90625, 77.642662),
    LatLng(12.906199, 77.642409),
    LatLng(12.907765, 77.644254),
    LatLng(12.906346, 77.644212),
    LatLng(12.911966, 77.646972),
    LatLng(12.91191, 77.648944),
    LatLng(12.91064, 77.64456),
    LatLng(12.90911, 77.644604),
    LatLng(12.909097, 77.644261),
    LatLng(12.909107, 77.644472),
    LatLng(12.908755, 77.644462),
    LatLng(12.909111, 77.644468)
  ];

  void pulse() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // pulse();

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
              )),
          IconButton(
            onPressed: (() {
              setState(() {
                // ambulance_loc_index++;
                _getAmbPos();
              });
            }),
            icon: const Icon(
              Icons.navigation,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: plot_center,
              zoom: 15.3,
              maxZoom: 18.0,
              // rotation: 180.0,
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
              PolylineLayer(
                polylines: [Polyline(points: markers_list2, strokeWidth: 6.0)],
              ),
              PolylineLayer(
                polylines: _getPolylines(red_markers, Colors.red),
              ),
              PolylineLayer(
                polylines: _getPolylines(blue_markers, Colors.blue),
              ),
              PolylineLayer(
                polylines: _getPolylines(orange_markers, Colors.orange),
              ),
              PolylineLayer(
                  polylines: _getPolylines(markers_list, Colors.orange)),
              MarkerLayer(
                markers: [
                  Marker(
                      point: user_loc,
                      builder: (context) => Icon(
                            Icons.circle,
                            color: Colors.blue,
                            size: user_loc_size,
                          )),
                ],
              ),
              MarkerLayer(markers: [ambulance_marker]),
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
