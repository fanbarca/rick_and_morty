import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tashcommerce/models/categories.dart';
import 'package:tashcommerce/models/drawer_specs.dart';
import 'package:tashcommerce/widgets/menu_tile.dart';

class DrawerBackground extends StatelessWidget {
  DrawerBackground({Key key, double drawerSpecs}) : super(key: key);
  Categories categories;
  DrawerSpecs drawerSpecs;

  @override
  Widget build(BuildContext context) {
    categories = Provider.of<Categories>(context);
    drawerSpecs = Provider.of<DrawerSpecs>(context);

    List<Widget> items = [];
    for (int index = 0; index < categories.categoriesCount; index++) {
      items.add(
        MenuTile(
          onTap: () {
            categories.setIndex(index);
            drawerSpecs.setDrawerValue(0);
          },
          index: index,
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        transform: GradientRotation(0.4),
        colors: [Colors.deepOrangeAccent, Colors.cyan],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: items,
              ),
            ),
            SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            ),
          ],
        ),
      ),
    );
  }
}
