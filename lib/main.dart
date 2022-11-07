// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:math';
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
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

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

  double _getRotAng() {
    double m = (markers_list2[ambulance_loc_index + 1].longitude -
            markers_list2[ambulance_loc_index].longitude) /
        (markers_list2[ambulance_loc_index + 1].latitude -
            markers_list2[ambulance_loc_index].latitude);
    return (atan(m) * 180 / pi) + 180.0;
  }

  double _getKms(double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  double _getDistance(LatLng pt1) {
    double lat1 = pt1.latitude;
    double lon1 = pt1.longitude;

    double kms = 0;
    for (int i = ambulance_loc_index; i < markers_list2.length; i++) {
      double lat2 = markers_list2[i].latitude;
      double lon2 = markers_list2[i].longitude;
      kms += _getKms(lat1, lon1, lat2, lon2);
    }
    return kms;
  }

  void _getAmbPos() {
    ambulance_loc_index = 0;
    List<Marker> x = _getMarkers();
    int i = 0;

    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        // double angle = _getRotAng();
        // ang = angle;
        ambulance_marker = x[i];
        // LatLng temp = LatLng(
        //     ambulance_marker.point.latitude, ambulance_marker.point.longitude);
        // if (angle >= 0 && angle < 90) {
        //   temp.latitude += 0.001247;
        // } else if (angle >= 90 && angle < 180) {
        //   temp.longitude += 0.001247;
        // } else if (angle >= 180 && angle < 270) {
        //   temp.latitude -= 0.001247;
        // } else if (angle >= 270 && angle < 360) {
        //   temp.longitude -= 0.001247;
        // }

        // // temp.longitude -= 0.001247;
        // // temp.latitude -= 0.001247;
        _mapController.moveAndRotate(ambulance_marker.point, 18.0, _getRotAng());
        kms_left = _getDistance(ambulance_marker.point);
        kms_left_str = kms_left.toStringAsFixed(2);
      });
      i++;
      if (i == x.length) {
        i = 0;
        ambulance_loc_index++;
        x.clear();
        x = _getMarkers();
      }
      if (ambulance_loc_index == markers_list2.length) {
        timer.cancel();
      }
    });
  }

  List<Marker> _getPotholes() {
    List<Marker> ph = [];
    for (int i = 0; i < potholes.length; i++) {
      ph.add(Marker(
          point: potholes[i],
          builder: ((context) => const Icon(
                Icons.circle,
                color: Colors.brown,
                size: 10,
              ))));
    }
    return ph;
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
  double ang = 0.0;
  double kms_left = 0;
  String kms_left_str ='';
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

  List<LatLng> potholes = [];

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
          // IconButton(
          //     onPressed: () {
          //       markers_list.add(_mapController.center);
          //     },
          //     icon: const Icon(
          //       Icons.pin,
          //       color: Colors.white,
          //     )),
          // IconButton(
          //     onPressed: _cleaRMarkers,
          //     icon: const Icon(
          //       Icons.delete,
          //       color: Colors.white,
          //     )),
          // IconButton(
          //     onPressed: _clearLastMarker,
          //     icon: const Icon(
          //       Icons.undo,
          //       color: Colors.white,
          //     )),
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
            mapController: _mapController,
            options: MapOptions(
              center: plot_center,
              zoom: 15.3,
              maxZoom: 18.0,
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
              MarkerLayer(markers: _getPotholes()),
              MarkerLayer(markers: [ambulance_marker]),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 100,
                decoration: const BoxDecoration(color: Colors.white),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Center(
                child: Icon(
                  Icons.navigation,
                  size: 65,
                  color: Colors.blue,
                ),
              ),
              Container(
                height: 80,
                decoration: const BoxDecoration(color: Colors.white),
                child: Text('Distance: $kms_left_str Kms', style: TextStyle(fontSize: 20), ),
              )
            ],
          )
          // Container(child: Center(child: Text('Current tap $tap_pos_x, $tap_pos_y')),)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // await Clipboard.setData(ClipboardData(text: markers_list.toString()));
          setState(() {
            if (potholes.length == 0) {
              potholes = [
                LatLng(12.919675, 77.651339),
                LatLng(12.919742, 77.650599),
                LatLng(12.919699, 77.652136),
                LatLng(12.919014, 77.651588),
                LatLng(12.91797, 77.65167),
                LatLng(12.918991, 77.650647),
                LatLng(12.919008, 77.650678),
                LatLng(12.917322, 77.651161),
                LatLng(12.917334, 77.651341),
                LatLng(12.916351, 77.651955),
                LatLng(12.916341, 77.652188),
                LatLng(12.915857, 77.651745),
                LatLng(12.91582, 77.651245),
                LatLng(12.915421, 77.651163),
                LatLng(12.915776, 77.648965),
                LatLng(12.915762, 77.649049),
                LatLng(12.912523, 77.651335),
                LatLng(12.913278, 77.651294),
                LatLng(12.911947, 77.649648),
                LatLng(12.912444, 77.648903),
                LatLng(12.912549, 77.649017),
                LatLng(12.911904, 77.648235),
                LatLng(12.91082, 77.649077),
                LatLng(12.910885, 77.647908),
                LatLng(12.91091, 77.647722),
                LatLng(12.908724, 77.648747),
                LatLng(12.909335, 77.647244),
                LatLng(12.909318, 77.647286),
                LatLng(12.909534, 77.645079),
                LatLng(12.908443, 77.646741),
                LatLng(12.908554, 77.645557),
                LatLng(12.908294, 77.644943),
                LatLng(12.905859, 77.644845),
                LatLng(12.906225, 77.643131),
                LatLng(12.906907, 77.64172),
                LatLng(12.908805, 77.640902),
                LatLng(12.907816, 77.640867),
                LatLng(12.907813, 77.640902),
                LatLng(12.905179, 77.642418),
                LatLng(12.905226, 77.64233),
                LatLng(12.905259, 77.642321),
                LatLng(12.905459, 77.641417)
              ];
            } else {
              potholes = [];
            }
          });
        },
        child: const Icon(
          Icons.copy,
          color: Colors.white,
        ),
      ),
    );
  }
}
