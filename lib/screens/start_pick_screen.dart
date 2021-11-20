import 'package:flutter/material.dart';
import 'package:hackatum_sixt_flutter_app/components/start_travel_input.dart';

class StartPickScreen extends StatefulWidget {
  const StartPickScreen({Key? key}) : super(key: key);

  @override
  State<StartPickScreen> createState() => _StartPickScreenState();
}

class _StartPickScreenState extends State<StartPickScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(35, 31, 32, 1),
      body: Column(
        children: [
          Hero(tag: "destinput-pick", child: StartTravelInput(hint: "Not available yet", onPressed: () {})),
        ],
      )
  );
  }
}
