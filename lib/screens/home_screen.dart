import 'package:card_swiper/card_swiper.dart';
import 'package:hackatum_sixt_flutter_app/components/g_map.dart';
import 'package:hackatum_sixt_flutter_app/components/location_info.dart';
import 'package:flutter/material.dart';
import 'package:hackatum_sixt_flutter_app/components/ride_summary.dart';
import 'package:hackatum_sixt_flutter_app/components/start_travel_input.dart';
import 'package:hackatum_sixt_flutter_app/models/ride_destination_model.dart';
import 'package:hackatum_sixt_flutter_app/screens/start_pick_screen.dart';
import 'package:hackatum_sixt_flutter_app/screens/start_ride_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RideDestinationModel? rideDestination;

  void showStartRideScreen(context) async {
    RideDestinationModel res = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StartRideScreen()),
    );
    setState(() {
      rideDestination = res;
    });
  }

  void showStartPickScreen(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StartPickScreen()),
    );
  }

  Widget bottomContent() {
    if (rideDestination != null) {
      return Positioned(
        bottom: 54,
        right: 14,
        left: 14,
        child: RideSummary(
          destination: rideDestination!,
          onSubmit: () {
            // Todo: get that ride whoop!
          },
          onCancel: () {
            setState(() {
              rideDestination = null;
            });
          },
        ),
      );
    }



    return Positioned(
      bottom: 54,
      right: 0,
      left: 0,
      height: 120,
      child: Swiper(
          itemCount: 2,
          viewportFraction: 0.90,
          scale: 0.9,
          loop: false,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) return Hero(tag: "destinput-ride", child: StartTravelInput(onPressed: () => showStartRideScreen(context)));
            if (index == 1) return Hero(tag: "destinput-pick", child: StartTravelInput(hint: "Where to pick up?", onPressed: () => showStartPickScreen(context)));
            return SizedBox();
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Stack(children: [
        Positioned.fill(child: GMap()),
        Positioned.fill(
            child: SafeArea(
          child: Stack(children: [
            Positioned(
              top: 16,
              right: 12,
              left: 12,
              child: LocationInfo(),
            ),
            bottomContent()
          ]),
        )),
      ]),
    );
  }
}
