import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackatum_sixt_flutter_app/global_state.dart';

import 'package:hackatum_sixt_flutter_app/models/ride_destination_model.dart';

class RideSummary extends StatefulWidget {
  const RideSummary({Key? key, required this.destination, this.onCancel, this.onSubmit}) : super(key: key);

  final RideDestinationModel destination;
  final VoidCallback? onSubmit;
  final VoidCallback? onCancel;

  @override
  State<RideSummary> createState() => _RideSummaryState();
}

class _RideSummaryState extends State<RideSummary> {

  Widget summaryItem(String title, String value) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: TextStyle(fontSize: 12, color: Colors.black54))
          ]
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(value, style: TextStyle(fontSize: 18))
          ]
        )
      ],
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 264,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 32),
                Text("Book Sixt RoboTaxi", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
                IconButton(onPressed: widget.onCancel, icon: Icon(Icons.close))
              ],
            ),
            Expanded(child: SizedBox()),
            Obx(() => summaryItem("Pick you up at", GlobalState.currentPositionAddress.value)),
            SizedBox(height: 24),
            summaryItem("Drop you off at", widget.destination.title),
            Expanded(child: SizedBox()),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(32))),
                      backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 18)),
                    ),
                    onPressed: widget.onSubmit,
                    child: Text("GET THE RIDE", style: TextStyle( color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))
                  ),
                )
              ],
            )
          ],
        )
    );
  }
}
