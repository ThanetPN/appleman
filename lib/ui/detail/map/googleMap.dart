import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterappleman/constants/Mystyle.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapsGoogle extends StatefulWidget {
  MapsGoogle({Key? key}) : super(key: key);

  @override
  _MapsGoogleState createState() => _MapsGoogleState();
}

class _MapsGoogleState extends State<MapsGoogle> {
  Completer<GoogleMapController> _controller = Completer();
  late BitmapDescriptor _markerIcon;

  _openOnGoogleMapApp(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      print('Could not open the map.');
    }
  }

  Future _createMarkerImageFromAsset(BuildContext context) async {
    ImageConfiguration configuration = ImageConfiguration();
    BitmapDescriptor bmpd = await BitmapDescriptor.fromAssetImage(
        configuration, 'assets/icons/location.png');
    setState(() {
      _markerIcon = bmpd;
    });
  }

  @override
  Widget build(BuildContext context) {
    _createMarkerImageFromAsset(context);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('Google Map',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white))),
      backgroundColor: MyStyle().garyAllColor,
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(13.6900043, 100.7479237),
          zoom: 12,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          Marker(
              icon: _markerIcon,
              markerId: MarkerId("1"),
              position: LatLng(13.6900043, 100.7479237),
              infoWindow: InfoWindow(
                  title: "สนามบินสุวรรณภูมิ",
                  snippet: "สนามบินนานาชาติของประเทศไทย"),
              onTap: () => _openOnGoogleMapApp(13.6900043, 100.7479237)),
        },
      ),
    );
  }
}
