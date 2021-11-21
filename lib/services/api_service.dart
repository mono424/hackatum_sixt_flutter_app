import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackatum_sixt_flutter_app/models/booking_model.dart';

abstract class ApiService {
  static Dio dio = Dio();
  static String baseUrl = "https://sixtchallengebackend.herokuapp.com";

  static Future<BookingModel> createBooking(double pickupLat, double pickupLng, double destinationLat, double destinationLng) async {
    final response = await dio.post(baseUrl + "/createBooking",
      data: {
        'pickupLat': pickupLat,
        'pickupLng': pickupLng,
        'destinationLat': destinationLat,
        'destinationLng': destinationLng,
      },
    );

    Map<String, dynamic> result = response.data;
    
    return BookingModel(
      result['bookingID'],
      result['pickupLat'],
      result['pickupLng'],
      result['destinationLat'],
      result['destinationLng'],
      result['suggestedVehicleID'],
      result['suggestedVehicleTimeToTravelToPickupLocation'],
    );
  }

  static Future<void> confirmBooking(String bookingID) async {
    await dio.post(baseUrl + "/confirmBooking?bookingID=" + bookingID);
  }

  static Future<void> passengerGotOn(String bookingID) async {
    await dio.post(baseUrl + "/passengerGotOn?bookingID=" + bookingID);
  }

  static Future<void> passengerGotOff(String bookingID, double lat, double lng) async {
    await dio.post(baseUrl + "/passengerGotOff?bookingID=" + bookingID + "&latitude=" + lat.toString() + "&longitude=" + lng.toString());
  }

  static Future<LatLng> getVehicleLocation(String vehicleId) async {
    final res = await dio.get(baseUrl + "/getVehiclePosition?vehicleID=" + vehicleId);
    return LatLng(res.data['lat'], res.data['lng']);
  }

}