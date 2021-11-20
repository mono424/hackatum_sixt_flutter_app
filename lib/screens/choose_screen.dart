import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackatum_sixt_flutter_app/screens/home_screen.dart';



class ChooseScreen extends StatefulWidget {
  const ChooseScreen({Key? key}) : super(key: key);


  @override
  _ChooseScreen createState() => _ChooseScreen();
}

class _ChooseScreen extends State<ChooseScreen> {
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
                        ]
                    )
                  ],
                ),
              Text(' ', style: TextStyle(height: 0.5, fontSize: 25,),),
              Text('Choose your Option:', style: TextStyle(height: 2.5, fontSize: 30, color: Colors.orange, decoration: TextDecoration.underline,),),
              Text(' ', style: TextStyle(height: 1.5, fontSize: 25,),),
              Container(
                child: Stack(
                    children: [
                      Row(children: [ Text(
                        '\n   Travel alone \n    --> relaxing drive, best to work, higher costs',    //7 tabs
                        style: TextStyle(height: 2.5, fontSize: 15, color: Colors.orange,),
                      ),
                      ]),
                      Row(children: [
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                'RoboTaxi Drive                          ',    //7 tabs
                                style: TextStyle(height: 2.5, fontSize: 20, color: Colors.orange,),
                              ),
                            ]),
                        ElevatedButton.icon(
                          icon: Icon(Icons.directions_car_outlined, size: 25,),
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(130,45),
                            onPrimary: Colors.black,
                            primary: Colors.orange.withOpacity(0.75),
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            side: BorderSide(color: Colors.white, width: 1),
                            textStyle: TextStyle(
                              fontSize: 15,
                            ),

                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomeScreen()),
                            );
                          },

                          label: Text('Select now!'),
                        ),
                      ]),

                    ] ),
              ),
              Text(
                ' ',    //7 tabs
                style: TextStyle( height: 3.5, fontSize: 15, color: Colors.orange,),
              ),
                Container(
                  child: Stack(
                      children: [
                        Row(children: [ Text(
                          '\n   Team-up with other Travellers \n    --> reduce your CO2-footprint, cheaper',    //7 tabs
                          style: TextStyle(height: 2.5, fontSize: 15, color: Colors.orange,),
                        ),
                        ]),
                        Row(children: [
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(
                                  'Social Traveling                         ',    //7 tabs
                                  style: TextStyle(height: 2.5, fontSize: 20, color: Colors.orange,),
                                ),
                              ]),
                          ElevatedButton.icon(
                            icon: Icon(Icons.groups_outlined , size: 25,),
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(130,45),
                              onPrimary: Colors.black,
                              primary: Colors.orange.withOpacity(0.75),
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                              side: BorderSide(color: Colors.white, width: 1),
                              textStyle: TextStyle(
                                fontSize: 15,
                              ),

                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomeScreen()),
                              );
                            },

                            label: Text('Select now!'),
                          ),
                        ]),

                      ] ),
                ),
                Text(
                  ' ',    //7 tabs
                  style: TextStyle( height: 3.5, fontSize: 15, color: Colors.orange,),
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

                        ElevatedButton.icon(
                          icon: Icon(Icons.account_balance_outlined, size: 25,),
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(130,45),
                            onPrimary: Colors.black,
                            primary: Colors.orange.withOpacity(0.75),
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            side: BorderSide(color: Colors.white, width: 1),
                            textStyle: TextStyle(
                              fontSize: 15,
                            ),

                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomeScreen()),
                            );
                          },

                          label: Text('Select now!'),
                        ),
                      ]),

                    ] ),
              ),
              Text(
                ' ',    //7 tabs
                style: TextStyle( height: 3.5, fontSize: 15, color: Colors.orange,),
              ),
                Container(
                  margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                  height: 5.0,
                  color: Colors.red,
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

                        ElevatedButton.icon(
                          icon: Icon(Icons.fastfood_outlined, size: 25,),
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(130,45),
                            onPrimary: Colors.black,
                            primary: Colors.orange.withOpacity(0.75),
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            side: BorderSide(color: Colors.white, width: 1),
                            textStyle: TextStyle(
                              fontSize: 15,
                            ),

                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomeScreen()),
                            );
                          },

                          label: Text('Select now!'),
                        ),

                      ]),

                    ] ),
              ),

          ]),
    )
    ]
    )







    );

  }
}






/*

           ExpansionTile(
             collapsedIconColor: Colors.black,
             collapsedTextColor: Colors.black,
             backgroundColor: Colors.black,
             iconColor: Colors.orange,
             textColor: Colors.orange,
             collapsedBackgroundColor: Colors.orange,
              title: Text('RoboTaxi Service',  style: TextStyle(fontSize: 18,),),
              children: <Widget>[
                Text('Choose your starting point and end point', style: TextStyle(height: 3.5, color: Colors.orange)),
                Text('A RoboTaxi will pick you up if you decide to order it' , style: TextStyle(color: Colors.orange)),

              ],
            ),
          Text(' ', style: TextStyle(height: 2.5, fontSize: 25,),),
 */
