import 'package:card_swiper/card_swiper.dart';
import 'package:hackatum_sixt_flutter_app/components/g_map.dart';
import 'package:hackatum_sixt_flutter_app/components/location_info.dart';
import 'package:flutter/material.dart';
import 'package:hackatum_sixt_flutter_app/components/start_travel_input.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                  scale: 0.95,
                  loop: false,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) return StartTravelInput();
                    if (index == 1) return StartTravelInput(hint: "Where to pick up?");
                    return SizedBox();
                  }),
            ),
          ]),
        )),
      ]),
    );
  }
}
