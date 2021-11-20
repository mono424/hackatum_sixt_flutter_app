import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackatum_sixt_flutter_app/components/places_list.dart';
import 'package:hackatum_sixt_flutter_app/components/start_travel_input.dart';

class StartRideScreen extends StatefulWidget {
  const StartRideScreen({Key? key}) : super(key: key);

  @override
  State<StartRideScreen> createState() => _StartRideScreenState();
}

class _StartRideScreenState extends State<StartRideScreen> {
  final query = "".obs;

  void onInput(String val) {
    query(val);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(35, 31, 32, 1),
      body: Obx(() => Column(
        children: [
          Hero(tag: "destinput-ride", child: StartTravelInput(focused: true, onInput: onInput)),
          query.value == "" ? SizedBox() : Expanded(child: PlacesList(
            query: query
          ))
        ],
      ))
  );
  }
}
