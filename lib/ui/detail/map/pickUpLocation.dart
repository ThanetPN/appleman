import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutterappleman/constants/Mystyle.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class PickUpLocation extends StatefulWidget {
  PickUpLocation({Key? key}) : super(key: key);

  @override
  _PickUpLocationState createState() => _PickUpLocationState();
}

class _PickUpLocationState extends State<PickUpLocation> {
  Completer<GoogleMapController> _controller = Completer();
  //late BitmapDescriptor _markerIcon;

  _openOnGoogleMapApp(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      Flushbar(
        title: 'Error Google Map',
        message: 'Could not open the map.',
        backgroundColor: MyStyle().redyColor,
        icon: Icon(
          Icons.error,
          size: 28.0,
          color: Colors.white,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.redAccent,
      )..show(context);
    }
  }

  // Future _createMarkerImageFromAsset(BuildContext context) async {
  //   ImageConfiguration configuration = ImageConfiguration();
  //   BitmapDescriptor bmpd = await BitmapDescriptor.fromAssetImage(
  //       configuration, 'assets/icons/location.png');
  //   setState(() {
  //     _markerIcon = bmpd;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    //_createMarkerImageFromAsset(context);

    Map google = ModalRoute.of(context)!.settings.arguments as Map;
    late double _fromLatitude = double.parse("${google['fromLatitude']}");
    late double _fromLongitude = double.parse("${google['fromLongitude']}");

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('สถานที่รับรถ',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white))),
      backgroundColor: MyStyle().garyAllColor,
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(_fromLatitude, _fromLongitude),
          zoom: 12,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          Marker(
              //icon: _markerIcon,
              markerId: MarkerId("${google['requestId']}"),
              position: LatLng(_fromLatitude, _fromLongitude),
              infoWindow: InfoWindow(
                  title: '${google['locationNameTha']}',
                  snippet: "${google['locationNameEng']}"),
              onTap: () => _openOnGoogleMapApp(_fromLatitude, _fromLongitude)),
        },
      ),
    );
  }
}