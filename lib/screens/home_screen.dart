import 'package:card_swiper/card_swiper.dart';
import 'package:hackatum_sixt_flutter_app/components/g_map.dart';
import 'package:hackatum_sixt_flutter_app/components/location_info.dart';
import 'package:flutter/material.dart';
import 'package:hackatum_sixt_flutter_app/components/start_travel_input.dart';
import 'package:hackatum_sixt_flutter_app/screens/start_pick_screen.dart';
import 'package:hackatum_sixt_flutter_app/screens/start_ride_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void showStartRideScreen(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StartRideScreen()),
    );
  }

  void showStartPickScreen(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StartPickScreen()),
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
            Positioned(
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
            ),
          ]),
        )),
      ]),
    );
  }
}
