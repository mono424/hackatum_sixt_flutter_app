import 'package:hackatum_sixt_flutter_app/screens/home_screen.dart';
import 'package:hackatum_sixt_flutter_app/screens/not_found_screen.dart';
import 'package:hackatum_sixt_flutter_app/screens/logIn_screen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class AppRouter extends StatefulWidget {
  const AppRouter({Key? key}) : super(key: key);

  @override
  _AppRouterState createState() => _AppRouterState();
}

class _AppRouterState extends State<AppRouter> {
  @override
  void initState() {
    initApp();
    super.initState();
  }

  void initApp() {}

  @override
  Widget build(BuildContext context) {    
    return MaterialApp(
      builder: BotToastInit(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Color.fromRGBO(238, 127, 0, 1),
        ),
      ),
      onGenerateRoute: (settings) {        
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => LogIn());
        }
        
        return MaterialPageRoute(builder: (context) => NotFoundScreen());
      },
    );
  }
}
