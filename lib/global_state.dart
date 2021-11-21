import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackatum_sixt_flutter_app/models/booking_model.dart';

abstract class GlobalState {

  static final currentPosition = Rxn<Position>();
  static final currentPositionAddress = "Search Location".obs;
  static final currentPositionCountryName = "to find a RoboTaxi Ride".obs;

  static final currentBooking = Rxn<BookingModel>();
  static final lastBookedCarPosition = Rxn<LatLng>();
  static final lastBookedCarDistance = 0.0.obs;
  static final distanceToDestination = 0.0.obs;

}