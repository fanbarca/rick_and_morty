import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'drawer_animation.dart';
import 'drawer_background.dart';
import 'splash_screen.dart';

class Root extends StatelessWidget {
  const Root({
    Key key,
  }) : super(key: key);

  Widget build(BuildContext context) {
    print('build $this');
    return Stack(
      children: <Widget>[
        DrawerBackground(),
        DrawerAnimation(
          page: SplashScreen(),
        ),
      ],
    );
  }
}
