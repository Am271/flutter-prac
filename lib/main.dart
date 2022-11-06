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
  List<Marker> _getMarkers() {
    List<Marker> markers = [];

    for (int i = 0; i < plots_pts.length; i++) {
      markers.add(Marker(
        point: plots_pts[i],
        builder: (context) => const Icon(
          Icons.train,
          size: 20,
          color: Colors.purple,
        ),
      ));
    }

    return markers;
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
  double user_loc_size = 20;
  List<LatLng> markers_list = [];
  List<LatLng> plots_pts = [
    LatLng(12.91968109090909, 77.65127172727271),
    LatLng(12.919687181818182, 77.65120445454545),
    LatLng(12.919693272727272, 77.65113718181819),
    LatLng(12.919699363636363, 77.65106990909091),
    LatLng(12.919705454545454, 77.65100263636363),
    LatLng(12.919711545454545, 77.65093536363635),
    LatLng(12.919717636363636, 77.65086809090909),
    LatLng(12.919723727272727, 77.65080081818182),
    LatLng(12.91972981818182, 77.65073354545456),
    LatLng(12.91973590909091, 77.65066627272728),
    LatLng(12.91973809090909, 77.65073872727272),
    LatLng(12.919734181818182, 77.65087845454546),
    LatLng(12.919730272727271, 77.65101818181819),
    LatLng(12.919726363636363, 77.6511579090909),
    LatLng(12.919722454545452, 77.65129763636364),
    LatLng(12.919718545454543, 77.65143736363638),
    LatLng(12.919714636363636, 77.65157709090909),
    LatLng(12.919710727272728, 77.65171681818182),
    LatLng(12.919706818181817, 77.65185654545455),
    LatLng(12.91970290909091, 77.65199627272727),
    LatLng(12.919636727272728, 77.65208618181818),
    LatLng(12.919574454545455, 77.65203636363637),
    LatLng(12.919512181818181, 77.65198654545453),
    LatLng(12.919449909090908, 77.65193672727273),
    LatLng(12.919387636363638, 77.6518869090909),
    LatLng(12.919325363636363, 77.6518370909091),
    LatLng(12.91926309090909, 77.65178727272728),
    LatLng(12.91920081818182, 77.65173745454545),
    LatLng(12.919138545454546, 77.65168763636363),
    LatLng(12.919076272727274, 77.65163781818183),
    LatLng(12.918919090909093, 77.65159545454546),
    LatLng(12.918824181818183, 77.6516029090909),
    LatLng(12.918729272727273, 77.65161036363637),
    LatLng(12.918634363636365, 77.65161781818182),
    LatLng(12.918539454545453, 77.65162527272727),
    LatLng(12.918444545454546, 77.65163272727273),
    LatLng(12.918349636363638, 77.65164018181818),
    LatLng(12.918254727272727, 77.65164763636363),
    LatLng(12.918159818181818, 77.65165509090909),
    LatLng(12.918064909090909, 77.65166254545453),
    LatLng(12.918062818181818, 77.65157699999999),
    LatLng(12.918155636363638, 77.651484),
    LatLng(12.918248454545454, 77.651391),
    LatLng(12.918341272727274, 77.651298),
    LatLng(12.918434090909091, 77.65120499999999),
    LatLng(12.918526909090907, 77.651112),
    LatLng(12.918619727272727, 77.651019),
    LatLng(12.918712545454547, 77.65092600000001),
    LatLng(12.918805363636364, 77.650833),
    LatLng(12.91889818181818, 77.65074),
    LatLng(12.918992545454545, 77.65064981818182),
    LatLng(12.918994090909091, 77.65065263636365),
    LatLng(12.918995636363634, 77.65065545454546),
    LatLng(12.918997181818183, 77.65065827272727),
    LatLng(12.91899872727273, 77.6506610909091),
    LatLng(12.919000272727272, 77.65066390909091),
    LatLng(12.919001818181817, 77.65066672727272),
    LatLng(12.919003363636364, 77.65066954545455),
    LatLng(12.91900490909091, 77.65067236363636),
    LatLng(12.919006454545455, 77.65067518181819),
    LatLng(12.918854727272729, 77.6507219090909),
    LatLng(12.918701454545454, 77.65076581818181),
    LatLng(12.918548181818181, 77.65080972727273),
    LatLng(12.918394909090908, 77.65085363636364),
    LatLng(12.918241636363637, 77.65089754545455),
    LatLng(12.918088363636365, 77.65094145454545),
    LatLng(12.91793509090909, 77.65098536363637),
    LatLng(12.917781818181817, 77.65102927272727),
    LatLng(12.917628545454546, 77.65107318181818),
    LatLng(12.917475272727273, 77.6511170909091),
    LatLng(12.917323090909093, 77.65117736363636),
    LatLng(12.91732418181818, 77.65119372727273),
    LatLng(12.917325272727272, 77.65121009090909),
    LatLng(12.917326363636365, 77.65122645454545),
    LatLng(12.917327454545454, 77.65124281818181),
    LatLng(12.917328545454547, 77.65125918181819),
    LatLng(12.917329636363638, 77.65127554545455),
    LatLng(12.917330727272729, 77.65129190909092),
    LatLng(12.91733181818182, 77.65130827272728),
    LatLng(12.91733290909091, 77.65132463636364),
    LatLng(12.917244636363636, 77.65139681818182),
    LatLng(12.917155272727273, 77.65145263636363),
    LatLng(12.91706590909091, 77.65150845454546),
    LatLng(12.916976545454547, 77.65156427272727),
    LatLng(12.916887181818181, 77.65162009090909),
    LatLng(12.916797818181818, 77.65167590909091),
    LatLng(12.916708454545455, 77.65173172727272),
    LatLng(12.91661909090909, 77.65178754545455),
    LatLng(12.916529727272728, 77.65184336363637),
    LatLng(12.916440363636365, 77.65189918181818),
    LatLng(12.91635009090909, 77.65197618181818),
    LatLng(12.916349181818184, 77.65199736363637),
    LatLng(12.916348272727275, 77.65201854545454),
    LatLng(12.916347363636362, 77.65203972727272),
    LatLng(12.916346454545454, 77.6520609090909),
    LatLng(12.916345545454543, 77.65208209090908),
    LatLng(12.916344636363636, 77.65210327272726),
    LatLng(12.916343727272727, 77.65212445454546),
    LatLng(12.916342818181818, 77.65214563636363),
    LatLng(12.916341909090908, 77.65216681818183),
    LatLng(12.916296999999998, 77.65214772727273),
    LatLng(12.916253, 77.65210745454546),
    LatLng(12.916208999999998, 77.65206718181818),
    LatLng(12.916165, 77.6520269090909),
    LatLng(12.916120999999999, 77.65198663636365),
    LatLng(12.916077, 77.65194636363637),
    LatLng(12.916033, 77.6519060909091),
    LatLng(12.915988999999998, 77.65186581818182),
    LatLng(12.915945, 77.65182554545454),
    LatLng(12.915900999999998, 77.65178527272728),
    LatLng(12.915853636363636, 77.65169954545455),
    LatLng(12.915850272727273, 77.6516540909091),
    LatLng(12.91584690909091, 77.65160863636365),
    LatLng(12.915843545454544, 77.65156318181818),
    LatLng(12.915840181818181, 77.65151772727273),
    LatLng(12.915836818181818, 77.65147227272728),
    LatLng(12.915833454545457, 77.65142681818182),
    LatLng(12.91583009090909, 77.65138136363636),
    LatLng(12.915826727272728, 77.65133590909092),
    LatLng(12.915823363636362, 77.65129045454546),
    LatLng(12.915783727272727, 77.65123754545455),
    LatLng(12.915747454545453, 77.6512300909091),
    LatLng(12.915711181818182, 77.65122263636364),
    LatLng(12.91567490909091, 77.65121518181819),
    LatLng(12.915638636363637, 77.65120772727272),
    LatLng(12.915602363636362, 77.65120027272728),
    LatLng(12.915566090909094, 77.65119281818183),
    LatLng(12.915529818181819, 77.65118536363637),
    LatLng(12.915493545454545, 77.6511779090909),
    LatLng(12.915457272727274, 77.65117045454545),
    LatLng(12.915453272727273, 77.65096318181817),
    LatLng(12.915485545454544, 77.65076336363636),
    LatLng(12.915517818181819, 77.65056354545455),
    LatLng(12.915550090909091, 77.65036372727273),
    LatLng(12.915582363636362, 77.6501639090909),
    LatLng(12.915614636363635, 77.6499640909091),
    LatLng(12.915646909090908, 77.64976427272728),
    LatLng(12.915679181818183, 77.64956445454546),
    LatLng(12.915711454545454, 77.64936463636364),
    LatLng(12.915743727272728, 77.64916481818182),
    LatLng(12.915774727272726, 77.64897263636364),
    LatLng(12.915773454545455, 77.64898027272727),
    LatLng(12.91577218181818, 77.64898790909092),
    LatLng(12.915770909090911, 77.64899554545455),
    LatLng(12.915769636363637, 77.64900318181819),
    LatLng(12.915768363636364, 77.64901081818182),
    LatLng(12.915767090909092, 77.64901845454546),
    LatLng(12.915765818181818, 77.6490260909091),
    LatLng(12.915764545454545, 77.64903372727272),
    LatLng(12.915763272727274, 77.64904136363636),
    LatLng(12.915467545454545, 77.64925681818183),
    LatLng(12.915173090909093, 77.64946463636365),
    LatLng(12.914878636363637, 77.64967245454545),
    LatLng(12.914584181818183, 77.64988027272729),
    LatLng(12.914289727272728, 77.6500880909091),
    LatLng(12.913995272727272, 77.6502959090909),
    LatLng(12.91370081818182, 77.65050372727273),
    LatLng(12.913406363636364, 77.65071154545454),
    LatLng(12.913111909090908, 77.65091936363636),
    LatLng(12.912817454545454, 77.65112718181818),
    LatLng(12.912591636363635, 77.65133127272728),
    LatLng(12.912660272727273, 77.65132754545455),
    LatLng(12.912728909090909, 77.65132381818181),
    LatLng(12.912797545454545, 77.65132009090908),
    LatLng(12.912866181818181, 77.65131636363635),
    LatLng(12.912934818181817, 77.65131263636363),
    LatLng(12.913003454545454, 77.6513089090909),
    LatLng(12.91307209090909, 77.65130518181817),
    LatLng(12.91314072727273, 77.65130145454545),
    LatLng(12.913209363636362, 77.65129772727272),
    LatLng(12.913157, 77.65114436363636),
    LatLng(12.913036, 77.65099472727273),
    LatLng(12.912915, 77.65084509090909),
    LatLng(12.912793999999998, 77.65069545454544),
    LatLng(12.912673, 77.65054581818181),
    LatLng(12.912552, 77.65039618181818),
    LatLng(12.912431, 77.65024654545455),
    LatLng(12.912310000000002, 77.6500969090909),
    LatLng(12.912189, 77.64994727272727),
    LatLng(12.912068, 77.64979763636364),
    LatLng(12.911992181818182, 77.64958027272728),
    LatLng(12.912037363636363, 77.64951254545454),
    LatLng(12.912082545454545, 77.6494448181818),
    LatLng(12.912127727272729, 77.6493770909091),
    LatLng(12.912172909090911, 77.64930936363636),
    LatLng(12.912218090909091, 77.64924163636364),
    LatLng(12.912263272727273, 77.6491739090909),
    LatLng(12.912308454545455, 77.64910618181818),
    LatLng(12.912353636363635, 77.64903845454546),
    LatLng(12.912398818181817, 77.64897072727273),
    LatLng(12.912453545454547, 77.64891336363637),
    LatLng(12.91246309090909, 77.64892372727273),
    LatLng(12.912472636363638, 77.6489340909091),
    LatLng(12.912482181818183, 77.64894445454546),
    LatLng(12.91249172727273, 77.64895481818182),
    LatLng(12.91250127272727, 77.64896518181818),
    LatLng(12.912510818181818, 77.64897554545455),
    LatLng(12.912520363636363, 77.64898590909091),
    LatLng(12.912529909090908, 77.64899627272727),
    LatLng(12.912539454545454, 77.64900663636364),
    LatLng(12.912490363636364, 77.64894590909091),
    LatLng(12.912431727272725, 77.64887481818181),
    LatLng(12.91237309090909, 77.64880372727272),
    LatLng(12.912314454545454, 77.64873263636365),
    LatLng(12.912255818181817, 77.64866154545454),
    LatLng(12.912197181818184, 77.64859045454546),
    LatLng(12.912138545454546, 77.64851936363635),
    LatLng(12.91207990909091, 77.64844827272726),
    LatLng(12.912021272727271, 77.64837718181819),
    LatLng(12.911962636363636, 77.64830609090909),
    LatLng(12.911805454545453, 77.64831154545455),
    LatLng(12.911706909090908, 77.64838809090908),
    LatLng(12.911608363636363, 77.64846463636364),
    LatLng(12.91150981818182, 77.64854118181819),
    LatLng(12.911411272727271, 77.64861772727274),
    LatLng(12.911312727272724, 77.64869427272728),
    LatLng(12.91121418181818, 77.64877081818182),
    LatLng(12.911115636363634, 77.64884736363636),
    LatLng(12.911017090909091, 77.64892390909091),
    LatLng(12.910918545454543, 77.64900045454546),
    LatLng(12.910825909090908, 77.64897072727274),
    LatLng(12.910831818181817, 77.64886445454546),
    LatLng(12.910837727272728, 77.64875818181818),
    LatLng(12.910843636363635, 77.64865190909092),
    LatLng(12.910849545454544, 77.64854563636364),
    LatLng(12.910855454545453, 77.64843936363637),
    LatLng(12.910861363636364, 77.64833309090909),
    LatLng(12.910867272727273, 77.64822681818181),
    LatLng(12.910873181818182, 77.64812054545455),
    LatLng(12.910879090909093, 77.64801427272728),
    LatLng(12.910887272727274, 77.6478910909091),
    LatLng(12.910889545454546, 77.64787418181818),
    LatLng(12.910891818181819, 77.64785727272728),
    LatLng(12.91089409090909, 77.64784036363636),
    LatLng(12.910896363636363, 77.64782345454546),
    LatLng(12.910898636363635, 77.64780654545456),
    LatLng(12.910900909090907, 77.64778963636364),
    LatLng(12.910903181818183, 77.64777272727272),
    LatLng(12.910905454545455, 77.64775581818184),
    LatLng(12.910907727272727, 77.6477389090909),
    LatLng(12.910711272727271, 77.64781518181817),
    LatLng(12.910512545454544, 77.64790836363638),
    LatLng(12.910313818181818, 77.64800154545455),
    LatLng(12.91011509090909, 77.64809472727273),
    LatLng(12.909916363636363, 77.64818790909091),
    LatLng(12.909717636363636, 77.6482810909091),
    LatLng(12.909518909090908, 77.64837427272728),
    LatLng(12.909320181818181, 77.64846745454545),
    LatLng(12.909121454545454, 77.64856063636363),
    LatLng(12.908922727272728, 77.64865381818183),
    LatLng(12.908779545454546, 77.64861036363637),
    LatLng(12.908835090909092, 77.64847372727273),
    LatLng(12.908890636363635, 77.6483370909091),
    LatLng(12.90894618181818, 77.64820045454546),
    LatLng(12.909001727272727, 77.64806381818181),
    LatLng(12.909057272727274, 77.64792718181819),
    LatLng(12.90911281818182, 77.64779054545455),
    LatLng(12.909168363636365, 77.6476539090909),
    LatLng(12.90922390909091, 77.64751727272727),
    LatLng(12.909279454545457, 77.64738063636364),
    LatLng(12.909333454545457, 77.64724781818182),
    LatLng(12.90933190909091, 77.64725163636363),
    LatLng(12.909330363636364, 77.64725545454544),
    LatLng(12.90932881818182, 77.64725927272728),
    LatLng(12.909327272727275, 77.64726309090908),
    LatLng(12.909325727272728, 77.6472669090909),
    LatLng(12.909324181818182, 77.64727072727273),
    LatLng(12.909322636363639, 77.64727454545454),
    LatLng(12.90932109090909, 77.64727836363636),
    LatLng(12.909319545454547, 77.64728218181818),
    LatLng(12.909337636363638, 77.64708536363636),
    LatLng(12.909357272727272, 77.64688472727272),
    LatLng(12.909376909090911, 77.64668409090909),
    LatLng(12.909396545454547, 77.64648345454545),
    LatLng(12.909416181818182, 77.64628281818182),
    LatLng(12.909435818181821, 77.64608218181819),
    LatLng(12.909455454545453, 77.64588154545454),
    LatLng(12.909475090909092, 77.64568090909091),
    LatLng(12.909494727272728, 77.64548027272727),
    LatLng(12.909514363636367, 77.64527963636364),
    LatLng(12.90943481818182, 77.6452300909091),
    LatLng(12.909335636363638, 77.64538118181818),
    LatLng(12.909236454545454, 77.64553227272727),
    LatLng(12.909137272727271, 77.64568336363637),
    LatLng(12.90903809090909, 77.64583445454545),
    LatLng(12.90893890909091, 77.64598554545455),
    LatLng(12.908839727272726, 77.64613663636364),
    LatLng(12.908740545454547, 77.64628772727274),
    LatLng(12.908641363636365, 77.64643881818182),
    LatLng(12.908542181818182, 77.64658990909092),
    LatLng(12.908453090909092, 77.64663336363637),
    LatLng(12.908463181818183, 77.64652572727273),
    LatLng(12.90847327272727, 77.6464180909091),
    LatLng(12.908483363636362, 77.64631045454546),
    LatLng(12.908493454545454, 77.6462028181818),
    LatLng(12.908503545454545, 77.64609518181818),
    LatLng(12.908513636363637, 77.64598754545455),
    LatLng(12.908523727272728, 77.64587990909091),
    LatLng(12.90853381818182, 77.64577227272729),
    LatLng(12.90854390909091, 77.64566463636363),
    LatLng(12.908530363636366, 77.64550118181818),
    LatLng(12.908506727272727, 77.64544536363637),
    LatLng(12.90848309090909, 77.64538954545455),
    LatLng(12.908459454545454, 77.64533372727273),
    LatLng(12.908435818181818, 77.64527790909091),
    LatLng(12.908412181818182, 77.64522209090909),
    LatLng(12.908388545454546, 77.64516627272727),
    LatLng(12.908364909090908, 77.64511045454546),
    LatLng(12.908341272727272, 77.64505463636364),
    LatLng(12.908317636363638, 77.64499881818182),
    LatLng(12.908072636363636, 77.64493409090909),
    LatLng(12.907851272727271, 77.64492518181818),
    LatLng(12.907629909090907, 77.64491627272727),
    LatLng(12.907408545454546, 77.64490736363636),
    LatLng(12.907187181818182, 77.64489845454546),
    LatLng(12.906965818181819, 77.64488954545455),
    LatLng(12.906744454545453, 77.64488063636364),
    LatLng(12.906523090909092, 77.64487172727273),
    LatLng(12.906301727272727, 77.64486281818182),
    LatLng(12.906080363636363, 77.64485390909091),
    LatLng(12.905892272727272, 77.6446891818182),
    LatLng(12.905925545454544, 77.64453336363637),
    LatLng(12.905958818181817, 77.64437754545455),
    LatLng(12.905992090909091, 77.64422172727272),
    LatLng(12.906025363636362, 77.6440659090909),
    LatLng(12.906058636363634, 77.6439100909091),
    LatLng(12.906091909090907, 77.64375427272726),
    LatLng(12.906125181818181, 77.64359845454545),
    LatLng(12.906158454545453, 77.64344263636363),
    LatLng(12.906191727272727, 77.64328681818182),
    LatLng(12.906286999999999, 77.64300272727272),
    LatLng(12.906349, 77.64287445454546),
    LatLng(12.906410999999999, 77.64274618181818),
    LatLng(12.906473, 77.6426179090909),
    LatLng(12.906534999999998, 77.64248963636363),
    LatLng(12.906597, 77.64236136363637),
    LatLng(12.906659000000001, 77.64223309090909),
    LatLng(12.906721, 77.64210481818182),
    LatLng(12.906783, 77.64197654545454),
    LatLng(12.906845000000002, 77.64184827272729),
    LatLng(12.907079545454547, 77.64164563636365),
    LatLng(12.90725209090909, 77.64157127272728),
    LatLng(12.907424636363636, 77.6414969090909),
    LatLng(12.907597181818181, 77.64142254545455),
    LatLng(12.907769727272724, 77.64134818181819),
    LatLng(12.907942272727274, 77.64127381818183),
    LatLng(12.908114818181817, 77.64119945454546),
    LatLng(12.908287363636362, 77.64112509090909),
    LatLng(12.908459909090908, 77.64105072727273),
    LatLng(12.908632454545453, 77.64097636363636),
    LatLng(12.908715090909089, 77.64089881818181),
    LatLng(12.908625181818183, 77.64089563636364),
    LatLng(12.908535272727272, 77.64089245454545),
    LatLng(12.908445363636362, 77.64088927272728),
    LatLng(12.908355454545454, 77.64088609090909),
    LatLng(12.908265545454547, 77.6408829090909),
    LatLng(12.908175636363637, 77.64087972727272),
    LatLng(12.908085727272727, 77.64087654545455),
    LatLng(12.907995818181819, 77.64087336363636),
    LatLng(12.907905909090909, 77.64087018181819),
    LatLng(12.907815727272727, 77.64087018181819),
    LatLng(12.907815454545455, 77.64087336363636),
    LatLng(12.907815181818183, 77.64087654545455),
    LatLng(12.907814909090911, 77.64087972727272),
    LatLng(12.90781463636364, 77.6408829090909),
    LatLng(12.907814363636362, 77.64088609090909),
    LatLng(12.90781409090909, 77.64088927272728),
    LatLng(12.907813818181818, 77.64089245454545),
    LatLng(12.907813545454546, 77.64089563636364),
    LatLng(12.907813272727275, 77.64089881818181),
    LatLng(12.907573545454547, 77.64103981818181),
    LatLng(12.907334090909092, 77.64117763636364),
    LatLng(12.907094636363638, 77.64131545454546),
    LatLng(12.906855181818184, 77.64145327272728),
    LatLng(12.90661572727273, 77.6415910909091),
    LatLng(12.906376272727274, 77.6417289090909),
    LatLng(12.90613681818182, 77.64186672727273),
    LatLng(12.905897363636365, 77.64200454545454),
    LatLng(12.90565790909091, 77.64214236363637),
    LatLng(12.905418454545456, 77.6422801818182),
    LatLng(12.905183272727273, 77.64241000000001),
    LatLng(12.905187545454545, 77.642402),
    LatLng(12.905191818181818, 77.64239400000001),
    LatLng(12.90519609090909, 77.642386),
    LatLng(12.905200363636363, 77.64237800000001),
    LatLng(12.905204636363637, 77.64237000000001),
    LatLng(12.90520890909091, 77.642362),
    LatLng(12.905213181818182, 77.64235400000001),
    LatLng(12.905217454545454, 77.642346),
    LatLng(12.90522172727273, 77.64233800000001),
    LatLng(12.905229000000002, 77.64232918181818),
    LatLng(12.905232, 77.64232836363637),
    LatLng(12.905235, 77.64232754545455),
    LatLng(12.905237999999999, 77.64232672727272),
    LatLng(12.905241, 77.6423259090909),
    LatLng(12.905244, 77.64232509090908),
    LatLng(12.905247000000001, 77.64232427272727),
    LatLng(12.90525, 77.64232345454546),
    LatLng(12.905253, 77.64232263636364),
    LatLng(12.905255999999998, 77.64232181818181),
    LatLng(12.90527718181818, 77.64223881818181),
    LatLng(12.905295363636363, 77.64215663636364),
    LatLng(12.905313545454545, 77.64207445454545),
    LatLng(12.905331727272726, 77.64199227272728),
    LatLng(12.905349909090909, 77.6419100909091),
    LatLng(12.905368090909091, 77.6418279090909),
    LatLng(12.905386272727272, 77.64174572727273),
    LatLng(12.905404454545454, 77.64166354545455),
    LatLng(12.905422636363637, 77.64158136363636),
    LatLng(12.90544081818182, 77.64149918181819)
  ];
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
      setState(() {
        if (user_loc_size == 20.0) {
          user_loc_size = 15.0;
        } else {
          user_loc_size = 20.0;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    pulse();

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
              // PolylineLayer(
              //   polylines: [Polyline(points: markers_list2, strokeWidth: 6.0)],
              // ),
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
        child: const Icon(
          Icons.copy,
          color: Colors.white,
        ),
      ),
    );
  }
}
