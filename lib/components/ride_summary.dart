import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackatum_sixt_flutter_app/global_state.dart';
import 'package:hackatum_sixt_flutter_app/models/booking_model.dart';

import 'package:hackatum_sixt_flutter_app/models/ride_destination_model.dart';
import 'package:hackatum_sixt_flutter_app/services/api_service.dart';

class RideSummary extends StatefulWidget {
  const RideSummary({Key? key, required this.destination, this.onCancel, this.onSubmit}) : super(key: key);

  final RideDestinationModel destination;
  final VoidCallback? onSubmit;
  final VoidCallback? onCancel;

  @override
  State<RideSummary> createState() => _RideSummaryState();
}

class _RideSummaryState extends State<RideSummary> {
  bool isLoading = false;

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

  void getRide() async {
    setState(() {
      isLoading = true;
    });
    BookingModel booking = await ApiService.createBooking(
      GlobalState.currentPosition.value!.latitude,
      GlobalState.currentPosition.value!.longitude,
      widget.destination.lat,
      widget.destination.lng,
    );
    GlobalState.currentBooking(booking);
    setState(() {
      isLoading = false;
    });
  }

  Widget childContent() {
    if (GlobalState.currentBooking.value != null) {
      return Text("*Placeholder* Created Booking :)");
    }

    return Column(
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
        SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(32))),
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 18)),
                ),
                onPressed: getRide,
                child: Text("GET THE RIDE", style: TextStyle( color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(238, 127, 0, 0.2),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
          ),
          margin: EdgeInsets.only(left: 32, right: 32),
          padding: EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Average waiting time: 3min", style: TextStyle(color: Color.fromRGBO(238, 127, 0, 0.7)))
            ],
          )
        ),
        SizedBox(height: 12),
      ],
    );
  }
  
  @override
  Widget build(BuildContext context) {
    Widget content = isLoading ? Center(
      child: SizedBox(
        width: 32,
        height: 32,
        child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
      )
    ) : childContent();

    return Container(
        height: 354,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Colors.white,
        ),
        child: content
    );
  }
}
