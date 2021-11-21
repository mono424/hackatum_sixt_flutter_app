import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackatum_sixt_flutter_app/enum/ride_status.dart';
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

  void searchTaxi() async {
    setState(() {
      isLoading = true;
    });
    try {
      BookingModel booking = await ApiService.createBooking(
        GlobalState.currentPosition.value!.latitude,
        GlobalState.currentPosition.value!.longitude,
        widget.destination.lat,
        widget.destination.lng,
      );
      GlobalState.currentBooking(booking);
    } catch (_) {
      BotToast.showSimpleNotification(title: "Something went wrong 😿");
    }
    setState(() {
      isLoading = false;
    });
  }

  void confirmTaxi() async {
    setState(() {
      isLoading = true;
    });
    try {
      BookingModel booking = GlobalState.currentBooking.value!;
      await ApiService.confirmBooking(booking.bookingID);
      booking.status = RideStatus.confirmed;
      GlobalState.currentBooking(booking);
    } catch (e) {
      BotToast.showSimpleNotification(title: "Something went wrong 😿");
    }
    setState(() {
      isLoading = false;
    });
  }

  void leaveRide() async {
    BookingModel booking = GlobalState.currentBooking.value!;
    booking.status = RideStatus.taxi_arrived_destination;
    GlobalState.currentBooking.trigger(booking);
  }

  void endRide() async {
    setState(() {
      isLoading = true;
    });
    try {
      BookingModel booking = GlobalState.currentBooking.value!;
      await ApiService.passengerGotOff(booking.bookingID, GlobalState.lastBookedCarPosition.value!.latitude, GlobalState.lastBookedCarPosition.value!.longitude);
      booking.status = RideStatus.ride_ended;
      GlobalState.currentBooking(booking);
    } catch (e) {
      BotToast.showSimpleNotification(title: "Something went wrong 😿");
    }
    setState(() {
      isLoading = false;
    });
  } 

  void startRide() async {
    setState(() {
      isLoading = true;
    });
    try {
      BookingModel booking = GlobalState.currentBooking.value!;
      await ApiService.passengerGotOn(booking.bookingID);
      booking.status = RideStatus.approaching_destination;
      GlobalState.currentBooking(booking);
    } catch (e) {
      BotToast.showSimpleNotification(title: "Something went wrong 😿");
    }
    setState(() {
      isLoading = false;
    });
  }

  Widget childContent(BookingModel? bookingModel) {
    if (bookingModel != null && bookingModel.status == RideStatus.ride_ended) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 32),
              Text("Sixt RoboTaxi", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
              IconButton(onPressed: widget.onCancel, icon: Icon(Icons.close))
            ],
          ),
          SizedBox(height: 48),
          Text("🎉", style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
          SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Thanks for riding with us!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
            ],
          ),
          SizedBox(height: 32),
        ],
      );
    }

    if (bookingModel != null && bookingModel.status == RideStatus.taxi_arrived_destination) {
      return Column(
        children: [
          Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("You arrived at your destination", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
            ],
          ),
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
                  onPressed: endRide,
                  child: Text("I AM OUTSIDE THE CAR, END RIDE", style: TextStyle( color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
        ],
      );
    }

    if (bookingModel != null && bookingModel.status == RideStatus.approaching_destination) {
      return Obx(() {
        int mins = GlobalState.distanceToDestination.value ~/ 100;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 32),
            Expanded(child: Image.asset("assets/images/sixt_car.png")),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("RoboTaxi is approaching destination", style: TextStyle(fontSize: 14, color: Colors.black54))
              ]
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(mins.toString() + " min", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
              ]
            ),
            SizedBox(height: 24),
            TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(32))),
                backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12, horizontal: 24)),
              ),
              onPressed: leaveRide,
              child: Text("I WANT TO LEAVE NOW", style: TextStyle( color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold))
            ),
            SizedBox(height: 7),
          ],
        );
      });
    }


    if (bookingModel != null && bookingModel.status == RideStatus.taxi_arrived_pickup) {
      return Column(
        children: [
          SizedBox(height: 32),
          Expanded(child: Image.asset("assets/images/sixt_car.png")),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Get in your RoboTaxi, its there!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
            ],
          ),
          SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(32))),
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 18)),
                  ),
                  onPressed: startRide,
                  child: Text("I AM INSIDE, START RIDE !", style: TextStyle( color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
        ],
      );
    }

    if (bookingModel != null && bookingModel.status == RideStatus.confirmed) {
      return Obx(() {
        int mins = GlobalState.lastBookedCarDistance.value ~/ 100;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(width: 64),
                Expanded(child: Image.asset("assets/images/sixt_car.png")),
                SizedBox(width: 64),
              ],
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("RoboTaxi is approaching you", style: TextStyle(fontSize: 14, color: Colors.black54))
              ]
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(mins.toString() + " min", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
              ]
            ),
          ],
        );
      });
    }

    if (bookingModel != null) {
      int minutes = bookingModel.suggestedVehicleTimeToTravelToPickupLocation ~/ 60;
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("RoboTaxi will pick you up in", style: TextStyle(fontSize: 14, color: Colors.black54))
            ]
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(minutes.toString() + " minutes", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
            ]
          ),
          Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("we will beam it to you in a couple of seconds", style: TextStyle(fontSize: 14, color: Colors.black26))
            ]
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(32))),
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 18)),
                  ),
                  onPressed: confirmTaxi,
                  child: Text("CONFIRM ROBOTAXI", style: TextStyle( color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
        ],
      );
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
                onPressed: searchTaxi,
                child: Text("SEARCH ROBOTAXI", style: TextStyle( color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))
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
    ) : Obx(() => childContent(GlobalState.currentBooking.value));

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
