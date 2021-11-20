import 'dart:async';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackatum_sixt_flutter_app/global_state.dart';

class GMap extends StatefulWidget {
  @override
  State<GMap> createState() => GMapState();
}

class GMapState extends State<GMap> {
  static final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Completer<GoogleMapController> _controller = Completer();
  List<Marker> customMarkers = [];

  @override
  void initState() {
    GlobalState.currentPosition.listen((p) async {
      if (p != null) {
        (await _controller.future).moveCamera(
          CameraUpdate.newLatLngZoom(LatLng(p.latitude, p.longitude), 17)
        );
        updatePickUpMarker();
      }
    });
    rootBundle.loadString('assets/maps/style.json').then((string) async {
      (await _controller.future).setMapStyle(string);
    });
    super.initState();
  }

  void updatePickUpMarker() async {
    final p = GlobalState.currentPosition.value;
    if (p != null) {
      final icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(100, 100)),
        'assets/images/marker.png'
      );
      setState(() {
        customMarkers = [
          Marker( 
            markerId: MarkerId("pickup_marker"),
            position: LatLng(p.latitude, p.longitude),
            icon: icon,
          )
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        zoomControlsEnabled: false,
        initialCameraPosition: _kGooglePlex,
        markers: customMarkers.toSet(),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}