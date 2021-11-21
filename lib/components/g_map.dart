import 'dart:async';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackatum_sixt_flutter_app/global_state.dart';
import 'package:hackatum_sixt_flutter_app/services/api_service.dart';

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
  Timer? roboTaxiTracker;
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
    GlobalState.currentBooking.listen((p) async {
      if(roboTaxiTracker != null) roboTaxiTracker!.cancel();
      if (p != null) {
        updateRoboTaxiPosition();
        roboTaxiTracker = Timer(Duration(seconds: 2), updateRoboTaxiPosition);
      }
    });
    rootBundle.loadString('assets/maps/style.json').then((string) async {
      (await _controller.future).setMapStyle(string);
    });
    super.initState();
  }

  void updateRoboTaxiPosition() async {
    if (GlobalState.currentBooking.value == null) {
      updateCarMarker();
      return;
    }
    // ApiService.getVehicleLocation(GlobalState.currentBooking.value!.suggestedVehicleID);
    (await _controller.future).moveCamera(
      CameraUpdate.newLatLngZoom(LatLng(48.173452, 11.585667), 17)
    );
    updateCarMarker(LatLng(48.173452, 11.585667));
  }

  void updateCarMarker([LatLng? pos]) async {
    setState(() {
      customMarkers = customMarkers.where((m) => m.markerId.value != "taxi_marker").toList();
    });
    if (pos == null) return;


    final icon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(100, 100)),
      'assets/images/marker_car.png'
    );
    setState(() {
      customMarkers.add(Marker( 
        markerId: MarkerId("pickup_marker"),
        position: LatLng(pos.latitude, pos.longitude),
        icon: icon,
      ));
    });
  }

  void updatePickUpMarker() async {
    final p = GlobalState.currentPosition.value;
    if (p != null) {
      final icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(100, 100)),
        'assets/images/marker.png'
      );
      setState(() {
        customMarkers = customMarkers.where((m) => m.markerId.value != "pickup_marker").toList();
        customMarkers.add(Marker( 
          markerId: MarkerId("pickup_marker"),
          position: LatLng(p.latitude, p.longitude),
          icon: icon,
        ));
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