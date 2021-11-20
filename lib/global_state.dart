import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hackatum_sixt_flutter_app/models/booking_model.dart';

abstract class GlobalState {

  static final currentPosition = Rxn<Position>();
  static final currentPositionAddress = "Search Location".obs;
  static final currentPositionCountryName = "to find a RoboTaxi Ride".obs;

  static final currentBooking = Rxn<BookingModel>();

}