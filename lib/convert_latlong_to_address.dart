import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLatLongToAddress extends StatefulWidget {
  const ConvertLatLongToAddress({Key? key}) : super(key: key);

  @override
  State<ConvertLatLongToAddress> createState() => _ConvertLatLongToAddressState();
}

class _ConvertLatLongToAddressState extends State<ConvertLatLongToAddress> {

  String stAddress='', stLocation='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(stAddress),
          GestureDetector(
            onTap: () async{
              List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
              List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);

              setState(() {
                stAddress=locations[0].latitude.toString() +" "+ locations[0].longitude.toString();
                stLocation=placemarks[0].street.toString()+" "+ placemarks[0].locality.toString()+" "+placemarks[0].country.toString();
              });
            },
            child: Padding(padding: EdgeInsets.all(10),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: Text('Locate', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),)),
            ),),
          ),
          Text(stLocation),
        ],
      ),
    );
  }
}
