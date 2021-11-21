import 'package:dio/dio.dart';
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

  static Future<void> getVehicleLocation(String vehicleId) async {
    await dio.get(baseUrl + "/getVehicleLocation?vehicleId=" + vehicleId);
  }

}