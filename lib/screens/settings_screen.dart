import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackatum_sixt_flutter_app/screens/home_screen.dart';



class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);


  @override
  _SettingsScreen createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  bool isSwitched = false;
  bool isSwitched_1 = false;
  bool isSwitched_2 = false;
  @override
  void initState(){
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }



  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
      children: [
        Positioned(
        top: 20.0,
        left: 15.0,
        child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(width: 330.0, height: 10.0),
                    IconButton(
                      iconSize: 40.0,
                      icon: new Icon(Icons.close),
                      highlightColor: Colors.orange,
                      color: Colors.orange,
                      onPressed: (){Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),);},
                    ),
                  ],
                ),

                Text(
                  '',
                  style: TextStyle(height: 3, fontSize: 20),
                ),
                Row(
                  children: [
                    Text(
                      '  ',
                      style: TextStyle(fontSize: 30),
                    ),
                    Image.asset("assets/images/gather_guy.png", alignment: Alignment.center, scale: 2.5),
                    Text(
                        '             ',
                      style: TextStyle(fontSize: 30),
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                        'Mr. Dennis Gölitz',
                        style: TextStyle(fontSize: 13, color: Colors.orange),
                      ),
                      Text(
                        'dennis.goelitz@tum.de',
                        style: TextStyle(fontSize: 13, color: Colors.orange),
                      ),
                        Text(
                          'Edit Profile',
                          style: TextStyle(fontSize: 13, color: Colors.orange, decoration: TextDecoration.underline,),
                        ),
          ]
                    )
                  ],
                ),


                Text(
                  '',
                  style: TextStyle(height: 1.5, fontSize: 20),
                ),
                const Text(
                  'Route-settings',
                  style: TextStyle(height: 2.5, fontSize: 28, color: Colors.orange, decoration: TextDecoration.underline),
                ),
                const Divider(color: Colors.orange, thickness: 1.0),

                Container(
                  child: Stack(
                    children: [
                      Row(children: [ Text(
                        '\n   Team-up with others traveling the same direction \n    --> reduce your CO2-footprint',    //7 tabs
                        style: TextStyle(height: 2.5, fontSize: 15, color: Colors.orange,),
                      ),]),
                      Row(children: [
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             Text(
                                'Social Traveling                         ',    //7 tabs
                                style: TextStyle(height: 2.5, fontSize: 20, color: Colors.orange,),
                              ),
                            ]),
                        Column(children: [
                          Transform.scale( scale: 1.1,
                            child: Switch(
                              value: isSwitched,
                              onChanged: (value){
                                setState(() {
                                  isSwitched=value;
                                });
                              },

                              activeTrackColor: Colors.orange,
                              inactiveTrackColor: Colors.white,
                              activeColor: Colors.white,
                              inactiveThumbColor: Colors.orange,

                            ),
                          ),
                        ]),],
                  ),

               ] ),
              ),
                Text(
                  ' ',    //7 tabs
                  style: TextStyle( height: 2.5, fontSize: 15, color: Colors.orange,),
                ),
                Container(
                  child: Stack(
                      children: [
                        Row(children: [ Text(
                          '\n   Looking for a sightseeing tour ? \n    --> all famous sights with stops, videos and descriptions',    //7 tabs
                          style: TextStyle(height: 2.5, fontSize: 15, color: Colors.orange,),
                        ),]),
                        Row(children: [
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sightseeing-Mode                     ',    //7 tabs
                                  style: TextStyle(height: 2.5, fontSize: 20, color: Colors.orange,),
                                ),
                              ]),

                          Column(children: [
                            Transform.scale( scale: 1.1,
                              child: Switch(
                                value: isSwitched_1,
                                onChanged: (value){
                                  setState(() {
                                    isSwitched_1=value;
                                  });
                                },

                                activeTrackColor: Colors.orange,
                                inactiveTrackColor: Colors.white,
                                activeColor: Colors.white,
                                inactiveThumbColor: Colors.orange,

                              ),
                            ),
                          ]),],
                        ),

                      ] ),
                ),
                Text(
                  ' ',    //7 tabs
                  style: TextStyle( height: 2.5, fontSize: 15, color: Colors.orange,),
                ),
                Container(
                  child: Stack(
                      children: [
                        Row(children: [ Text(
                          '\n   Let products and goods be delivered to you \n    --> no timewasting meeting people from Ebay anymore',    //7 tabs
                          style: TextStyle(height: 2.5, fontSize: 15, color: Colors.orange,),
                        ),]),
                        Row(children: [
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Auto-Delivery                               ',    //7 tabs
                                  style: TextStyle(height: 2.5, fontSize: 20, color: Colors.orange,),
                                ),
                              ]),

                          Column(children: [
                            Transform.scale( scale: 1.1,
                              child: Switch(
                                value: isSwitched_2,
                                onChanged: (value){
                                  setState(() {
                                    isSwitched_2=value;
                                  });
                                },

                                activeTrackColor: Colors.orange,
                                inactiveTrackColor: Colors.white,
                                activeColor: Colors.white,
                                inactiveThumbColor: Colors.orange,

                              ),
                            ),
                          ]),],
                        ),

                      ] ),
                ),




    ]),
      ),
      ])

    );

  }
}
