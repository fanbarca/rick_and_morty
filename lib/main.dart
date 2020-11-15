import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/root_screen.dart';
import 'screens/settings_screen.dart';

//void main() => runApp(MyApp());
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontFamily: 'Neucha',
          ),
        ),
      ),
      routes: {
        '/': (context) => Root(),
        '/settings': (context) => SettingsScreen(),
      },
      initialRoute: '/',
      onGenerateRoute: (routeSettings) {
        if (routeSettings.name == "/settings")
          return PageRouteBuilder(pageBuilder: (_, a1, a2) => SettingsScreen());
        return null;
      },
    );
  }
}
