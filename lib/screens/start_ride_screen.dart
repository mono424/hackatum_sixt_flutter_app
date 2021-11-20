import 'package:flutter/material.dart';
import 'package:hackatum_sixt_flutter_app/components/start_travel_input.dart';

class StartRideScreen extends StatelessWidget {
  const StartRideScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(35, 31, 32, 1),
      body: Column(
        children: [
          Hero(tag: "destinput-ride", child: StartTravelInput(focused: true))

        ],
      )
  );
  }
}
