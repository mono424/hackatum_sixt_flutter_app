import 'package:hackatum_sixt_flutter_app/components/g_map.dart';
import 'package:hackatum_sixt_flutter_app/components/location_info.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Stack(
        children: [
          Positioned.fill(child:  GMap()),
          Positioned.fill(child:  SafeArea( 
            child: Stack(
              children: [
                Positioned(
                  top: 16,
                  right: 12,
                  left: 12,
                  child: LocationInfo(),
                ),
              ]
            ),
          )),
        ]
      ),
    );
  }
}
