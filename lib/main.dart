import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ui/character_details_screen.dart';

import 'ui/menu_screen/splash_screen.dart';
import 'ui/settings_screen.dart';

//void main() => runApp(MyApp());
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(ProviderScope(child: MyApp()));
    print('build MAIN');
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build $this');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.deepOrange.shade900,
        iconTheme: IconThemeData(
          color: Colors.deepOrange.shade900,
        ),
        primarySwatch: Colors.red,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontFamily: 'Neucha',
          ),
        ),
      ),
      routes: {
        '/': (context) => SplashScreen(),
        '/settings': (context) => SettingsScreen(),
        '/character_details': (context) => CharacterDetails(),
      },
      initialRoute: '/',
      onGenerateRoute: (routeSettings) {
        if (routeSettings.name == "/settings")
          return PageRouteBuilder(
              maintainState: false,
              pageBuilder: (_, a1, a2) => SettingsScreen());
        return null;
      },
    );
  }
}
