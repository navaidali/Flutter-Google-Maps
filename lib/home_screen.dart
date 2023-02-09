import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _KGooglePlex = CameraPosition(
      target: LatLng(33.783029199247075, 72.35289827351733), zoom: 14.4746);

  List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(33.783029199247075, 72.35289827351733),
      infoWindow: InfoWindow(title: 'COMSATS'),
    ),
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(35.920834, 74.308334),
      infoWindow: InfoWindow(title: 'Gilgit'),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
            const CameraPosition(
              target: LatLng(35.920834, 74.308334),
              zoom: 14,
            ),
          ));
          setState(() {

          });
        },
        child: Icon(Icons.location_city_outlined),
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _KGooglePlex,
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
