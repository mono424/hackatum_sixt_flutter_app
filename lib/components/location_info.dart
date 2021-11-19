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
          SizedBox(width: 9),
          IconButton(onPressed: () {}, icon: Icon(Icons.info_outline_rounded), iconSize: 24, color: Colors.black),
          Expanded(child: SizedBox()),
          Column(
            children: [
              Text("Konradstraße", style: TextStyle(fontSize: 18)),
              SizedBox(height: 4),
              Text("München, Deutschland", style: TextStyle(fontSize: 12)),
            ],
          ),
          Expanded(child: SizedBox()),
          IconButton(onPressed: () {}, icon: Icon(Icons.my_location_rounded), iconSize: 24, color: Colors.black),
          SizedBox(width: 9),
        ],
      ),
    );
  }
}


