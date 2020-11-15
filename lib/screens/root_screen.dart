import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:tashcommerce/models/categories.dart';

import 'menu_screen/drawer_animation_stateful.dart';
import 'menu_screen/drawer_background.dart';
import 'menu_screen/splash_animation_stateful.dart';

class Root extends StatefulWidget {
  const Root({
    Key key,
  }) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    double drawerSpecs = 0;
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider(create: (_) => Categories()),
        //ChangeNotifierProvider(create: (_) => DrawerSpecs()),
      ],
      child: Stack(
        children: <Widget>[
          DrawerBackground(
            drawerSpecs: drawerSpecs,
            onTap: () {
              setState(() {
                if (drawerSpecs > 0) drawerSpecs = 0;
                // closeDrawer();
              });
            },
          ),
          DrawerAnimation(page: SplashAnimation(), drawerSpecs: drawerSpecs),
        ],
      ),
    );
  }
}
