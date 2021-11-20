import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackatum_sixt_flutter_app/screens/home_screen.dart';

class SettingsScreen extends StatefulWidget {

  @override
  _SettingsScreen createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {

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
      body: Center(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '',
                  style: TextStyle(height: 0.5, fontSize: 20),
                ),
                Image.asset("assets/icon/sixt_logo.png", alignment: Alignment.center, scale: 1.5),
                Text(
                  '',
                  style: TextStyle(height: 2.5, fontSize: 30),
                ),
                const Text(
                  'Welcome back, Mr. Gölitz',
                  style: TextStyle(height: 1.5, fontSize: 22, color: Colors.orange),
                ),
                Text(
                  '',
                  style: TextStyle(height: 4.5, fontSize: 30),
                ),
                Row(
                    children: <Widget>[

                      Spacer(),
                      ElevatedButton.icon(
                        icon: Icon(Icons.account_circle_outlined , size: 25,),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(150,60),
                          onPrimary: Colors.black,
                          primary: Colors.orange.withOpacity(0.75),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          side: BorderSide(color: Colors.white, width: 1),
                          textStyle: TextStyle(
                            fontSize: 15,
                          ),

                        ),
                        onPressed: () {},

                        label: Text('Change User'),
                      ),
                      Spacer(),
                      ElevatedButton.icon(
                        icon: Icon(Icons.directions_car_outlined, size: 25,),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(150,60),
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

                        label: Text('Book your ride'),
                      ),
                      Spacer(),


                    ]),
                Text(
                  '',
                  style: TextStyle(height: 4.5, fontSize: 30),
                ),

              ],

            ),
          ],
        ),
      ),

    );

  }
}
