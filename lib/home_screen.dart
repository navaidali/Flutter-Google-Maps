import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  final List<Marker> _list = [
    // Marker(
    //   markerId: MarkerId('1'),
    //   position: LatLng(33.783029199247075, 72.35289827351733),
    //   infoWindow: InfoWindow(title: 'COMSATS'),
    // ),
    Marker(
      markerId: MarkerId('2'),
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

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;


    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high, forceAndroidLocationManager: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _determinePosition().then((value) async {
            _marker.add(
              Marker(
                markerId: const MarkerId("1"),
                position: LatLng(value.latitude, value.longitude),
                  infoWindow: const InfoWindow(title: "My Location"),
              )
            );
            CameraPosition cameraPosition1= CameraPosition(target: LatLng(value.latitude, value.longitude),
            zoom: 14.0);

            final GoogleMapController controller= await _controller.future;


            setState(() {
              controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition1));
              print("hi");
            });
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
