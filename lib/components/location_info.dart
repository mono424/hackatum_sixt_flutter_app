import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:hackatum_sixt_flutter_app/global_state.dart';
import 'package:hackatum_sixt_flutter_app/screens/settings_screen.dart';

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

class LocationInfo extends StatefulWidget {
  const LocationInfo({Key? key}) : super(key: key);

  @override
  State<LocationInfo> createState() => _LocationInfoState();
}

class _LocationInfoState extends State<LocationInfo> {
  bool isLoading = false;
  
  void getPos() async {
    setState(() {
      isLoading = true;
    });

    try {
      Position newPos = await _determinePosition();
      final coordinates = Coordinates(newPos.latitude, newPos.longitude);
      final addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      final newAddress = addresses.first.addressLine!.split(",")[0];
      final newCountryName = addresses.first.adminArea! + ", " + addresses.first.countryName!;

      GlobalState.currentPosition(newPos);
      GlobalState.currentPositionAddress(newAddress);
      GlobalState.currentPositionCountryName(newCountryName);

    } catch (_) {}

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.white70,
      ),
      child: Row(
        children: [
          SizedBox(width: 4),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
            child: Container(
              width: 60,
              decoration: BoxDecoration(
                color: Color.fromRGBO(35, 31, 32, 1),
                borderRadius: BorderRadius.circular(24),
              ),
              padding: EdgeInsets.all(4),
              clipBehavior: Clip.antiAlias,
              child: Image.asset("assets/images/sixt_logo.png")),
          ),
          Expanded(child: SizedBox()),
          Obx(() => Column(
            children: [
              Text(GlobalState.currentPositionAddress.value, style: TextStyle(fontSize: 18)),
              SizedBox(height: 4),
              Text(GlobalState.currentPositionCountryName.value, style: TextStyle(fontSize: 12)),
            ],
          )),
          Expanded(child: SizedBox()),
          SizedBox(width: 14),
          TextButton(
            onPressed: isLoading ? null : getPos,
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
            ),
            child: isLoading 
              ? SizedBox(width: 14, height: 14, child: CircularProgressIndicator(color: Colors.black26)) 
              : Icon(Icons.my_location_rounded, size: 24, color: Colors.black)
          ),
          SizedBox(width: 2),
        ],
      ),
    );
  }
}


