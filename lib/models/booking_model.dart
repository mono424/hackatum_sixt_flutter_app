class BookingModel {
  final String bookingID; 
  final double pickupLat;
  final double pickupLng;
  final double destinationLat;
  final double destinationLng;
  final String suggestedVehicleID;
  final double suggestedVehicleTimeToTravelToPickupLocation;
  bool isConfirmed = false;

  BookingModel(this.bookingID, this.pickupLat, this.pickupLng, this.destinationLat, this.destinationLng, this.suggestedVehicleID, this.suggestedVehicleTimeToTravelToPickupLocation);
}