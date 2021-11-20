class BookingModel {
  final String id; 
  final double pickupLat;
  final double pickupLng;
  final double destinationLat;
  final double destinationLng;
  final String suggestedVehicleID;
  final String suggestedVehicleTimeToTravelToPickupLocation;

  BookingModel(this.id, this.pickupLat, this.pickupLng, this.destinationLat, this.destinationLng, this.suggestedVehicleID, this.suggestedVehicleTimeToTravelToPickupLocation);
}