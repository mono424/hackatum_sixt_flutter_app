import 'package:hackatum_sixt_flutter_app/enum/ride_status.dart';

class BookingModel {
  final String bookingID; 
  final double pickupLat;
  final double pickupLng;
  final double destinationLat;
  final double destinationLng;
  final String suggestedVehicleID;
  final double suggestedVehicleTimeToTravelToPickupLocation;
  RideStatus status = RideStatus.suggested;

  BookingModel(this.bookingID, this.pickupLat, this.pickupLng, this.destinationLat, this.destinationLng, this.suggestedVehicleID, this.suggestedVehicleTimeToTravelToPickupLocation);
}