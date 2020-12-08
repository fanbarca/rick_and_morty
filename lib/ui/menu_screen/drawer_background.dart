import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tashcommerce/constants/constants.dart';
import 'package:tashcommerce/providers/categories.dart';
import 'package:tashcommerce/widgets/menu_tile.dart';

class DrawerBackground extends ConsumerWidget {
  DrawerBackground({Key key, double drawerSpecs}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    Categories categories = watch(categoriesProvider);
    // DrawerSpecs drawerSpecs = Provider.of<DrawerSpecs>(context, listen: false);
    print('build $this');

    List<Widget> items = [];
    for (int index = 0; index < categories.categoriesCount; index++) {
      items.add(
        MenuTile(
          onTap: () {
            context.read(categoriesProvider).setIndex(index);
            Navigator.of(context).pop();
            // drawerSpecs.setDrawerValue(0);
          },
          index: index,
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        gradient: kBackgroundGradient,
      ),
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
