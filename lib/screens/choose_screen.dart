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

              Center(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
                      child: ExpansionTile(
                        title: Text('Birth of Universe'),
                        children: <Widget>[
                          Text('Big Bang'),
                          Text('Birth of the Sun'),
                          Text('Earth is Born'),
                        ],
                      ),
                    ),
                  )
                  ),


    ]),
      ),
      ])

    );

  }
}
