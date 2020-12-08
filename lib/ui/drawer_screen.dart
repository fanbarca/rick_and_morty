import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:tashcommerce/providers/categories.dart';
import 'package:tashcommerce/providers/drawer_specs.dart';

import 'package:tashcommerce/widgets/menu_tile.dart';

class DrawerBackground2 extends ConsumerWidget {
  const DrawerBackground2({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context, watch) {
    Size size = MediaQuery.of(context).size;
    Categories categories = watch(categoriesProvider);
    DrawerSpecs drawerSpecs = watch(drawerSpecsProvider).state;
    List<Widget> items = [];
    for (int index = 0; index < categories.categoriesCount; index++) {
      items.add(
        MenuTile(
          index: index,
          onTap: () {
            categories.setIndex(index);
            drawerSpecs.setDrawerValue(0);
          },
        ),
      );
    }
    // double blur = 10 - drawerSpecs.getDrawerValue / size.width * 16;
    double newValue = drawerSpecs.getDrawerValue;
    return TweenAnimationBuilder(
        duration: Duration(milliseconds: 600),
        curve: Curves.easeOutExpo,
        tween: Tween(begin: 0.0, end: newValue),
        builder: (context, value, child) {
          double fraction = value / size.width * 1.5;
          double newX = fraction > 1.0
              ? 1.0
              : fraction < 0.0
                  ? 0.0
                  : fraction;
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              transform: GradientRotation(0.4),
              colors: [Colors.deepOrangeAccent, Colors.cyan],
            )),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 95.0,
                  ),
                  Column(
                    children: items,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FlatButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/settings');
                        },
                        icon: Icon(Icons.settings),
                        label: Text('Settings'),
                      ),
                      FlatButton.icon(
                        onPressed: null,
                        icon: Icon(Icons.feedback),
                        label: Text('Feedback'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
