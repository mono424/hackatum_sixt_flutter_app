import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

abstract class GlobalState {

  static final currentPosition = Rxn<Position>();
  static final currentPositionAddress = "Search Location".obs;
  static final currentPositionCountryName = "To find a RoboTaxi Ride".obs;

}