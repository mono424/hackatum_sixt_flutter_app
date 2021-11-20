import 'package:flutter/material.dart';

class LocationInfo extends StatelessWidget {
  const LocationInfo({Key? key}) : super(key: key);

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
            onPressed: () {},
            child: Container(
              width: 60,
              decoration: BoxDecoration(
                color: Color.fromRGBO(35, 31, 32, 1),
                borderRadius: BorderRadius.circular(24),
              ),
              padding: EdgeInsets.all(4),
              clipBehavior: Clip.antiAlias,
              child: Image.asset("assets/images/sixt_logo.png")
            ),
          ),
          Expanded(child: SizedBox()),
          Column(
            children: [
              Text("Konradstraße", style: TextStyle(fontSize: 18)),
              SizedBox(height: 4),
              Text("München, Deutschland", style: TextStyle(fontSize: 12)),
            ],
          ),
          Expanded(child: SizedBox()),
          SizedBox(width: 34),
          IconButton(onPressed: () {}, icon: Icon(Icons.my_location_rounded), iconSize: 24, color: Colors.black),
          SizedBox(width: 9),
        ],
      ),
    );
  }
}


