import 'dart:math' show cos, sqrt, asin;
import 'dart:async';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackatum_sixt_flutter_app/enum/ride_status.dart';
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
        roboTaxiTracker = Timer.periodic(Duration(seconds: 2), (_) => updateRoboTaxiPosition());
      }
    });
    rootBundle.loadString('assets/maps/style.json').then((string) async {
      (await _controller.future).setMapStyle(string);
    });
    super.initState();
  }

  void updateRoboTaxiPosition() async {
   try {
      if (GlobalState.currentBooking.value == null) {
        updateCarMarker();
        return;
      }
      final coords = await ApiService.getVehicleLocation(GlobalState.currentBooking.value!.suggestedVehicleID);
      (await _controller.future).moveCamera(
        CameraUpdate.newLatLngZoom(coords, 17)
      );
      GlobalState.lastBookedCarPosition(coords);
      GlobalState.lastBookedCarDistance(calculateDistance(
        coords.latitude,
        coords.longitude,
        GlobalState.currentPosition.value!.latitude,
        GlobalState.currentPosition.value!.longitude
      ));
      GlobalState.distanceToDestination(calculateDistance(
        coords.latitude,
        coords.longitude,
        GlobalState.currentBooking.value!.destinationLat,
        GlobalState.currentBooking.value!.destinationLng
      ));

      if (GlobalState.currentBooking.value!.status == RideStatus.confirmed && GlobalState.lastBookedCarDistance.value < 100) {
        GlobalState.currentBooking.value!.status = RideStatus.taxi_arrived_pickup;
      }

      if (GlobalState.currentBooking.value!.status == RideStatus.approaching_destination && GlobalState.distanceToDestination.value < 100) {
        GlobalState.currentBooking.value!.status = RideStatus.taxi_arrived_destination;
      }
    } catch (_) {}
  }

  double calculateDistance(lat1, lng1, lat2, lng2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 + 
          c(lat1 * p) * c(lat2 * p) * 
          (1 - c((lng2 - lng1) * p))/2;
    return 12742 * asin(sqrt(a)) * 1000;
  }

  void updateCarMarker() async {
    final pos = GlobalState.lastBookedCarPosition.value;
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
        markerId: MarkerId("taxi_marker"),
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
        markers: customMarkers.reversed.toSet(),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}