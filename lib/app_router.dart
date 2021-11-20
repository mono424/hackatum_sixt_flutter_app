import 'package:hackatum_sixt_flutter_app/screens/home_screen.dart';
import 'package:hackatum_sixt_flutter_app/screens/not_found_screen.dart';
import 'package:hackatum_sixt_flutter_app/services/NavigationService.dart';
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
      navigatorKey: NavigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {        
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => HomeScreen());
        }
        
        return MaterialPageRoute(builder: (context) => NotFoundScreen());
      },
    );
  }
}