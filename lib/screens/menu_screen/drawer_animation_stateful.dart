import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tashcommerce/models/categories.dart';
import 'package:tashcommerce/widgets/menu_tile.dart';

// ignore: must_be_immutable
class DrawerAnimation extends StatefulWidget {
  final Widget page;
  double drawerSpecs;

  DrawerAnimation({Key key, this.page, this.drawerSpecs}) : super(key: key);

  @override
  _DrawerAnimationState createState() => _DrawerAnimationState();
}

class _DrawerAnimationState extends State<DrawerAnimation> {
  @override
  Widget build(BuildContext context) {
    Categories categories = Provider.of<Categories>(context);

    List<Widget> items = [];

    for (int index = 0; index < categories.categoriesCount; index++) {
      items.add(
        MenuTile(
          onTap: () {
            //onTap();
            categories.setIndex(index);
            closeDrawer();
          },
//          drawerSpecs: drawerSpecs,
          index: index,
        ),
      );
    }

    Size size = MediaQuery.of(context).size;
    double newValue = widget.drawerSpecs < 0 ? 0 : widget.drawerSpecs;
    return Stack(
      children: <Widget>[
        TweenAnimationBuilder(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeOutExpo,
          tween: Tween(begin: 0.0, end: newValue),
          builder: (context, value, child) {
            //double newX = ;
            //double newY = (size.height * (value * 0.2 / size.width)) / 2;
            double newScale = (1 - value * 0.8 / size.width);
            return Transform(
              alignment: Alignment.centerRight,
              transform: Matrix4.identity()
                ..add(Matrix4.translationValues(value * 0.8, 0, 0))
                ..setEntry(3, 2, 0.002)
                ..rotateY(-value * 1.6 / size.width)
                ..scale(newScale),
              child: GestureDetector(
                dragStartBehavior: DragStartBehavior.down,
                onTap: () {
                  if (value > 0) {
                    closeDrawer();
                  }
                },
                onHorizontalDragEnd: (details) {
                  if ((details.velocity.pixelsPerSecond.dx > 0)) {
                    openDrawer(size);
                  } else if ((details.velocity.pixelsPerSecond.dx < 0)) {
                    closeDrawer();
                  } else {
                    if (newValue < size.width * 0.18) {
                      closeDrawer();
                    } else {
                      openDrawer(size);
                    }
                  }
                },
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx > 0) {
                    if (newValue < size.width * 0.48) {
                      moveRight(details);
                    }
                  } else if (details.delta.dx < 0) {
                    if (newValue > 0) {
                      moveLeft(details);
                    }
                  }
                },
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(100.0 * value / size.width),
                      child: child,
                    ),
                    widget.drawerSpecs == 0
                        ? SizedBox()
                        : Container(
                            color: Colors.transparent,
                            height: size.height,
                            width: size.width,
                          ),
                  ],
                ),
              ),
            );
          },
          child: widget.page,
        ),
        SafeArea(
          child: GestureDetector(
            onTap: () {
              setState(
                () {
                  if (widget.drawerSpecs > 0)
                    closeDrawer();
                  else if (widget.drawerSpecs == 0) openDrawer(size);
                },
              );
            },
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Icon(
                Icons.menu,
                size: 40,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void moveLeft(DragUpdateDetails details) {
    setState(() {
      widget.drawerSpecs -= details.delta.dx.abs();
    });
  }

  void moveRight(DragUpdateDetails details) {
    setState(() {
      widget.drawerSpecs += details.delta.dx;
    });
  }

  void openDrawer(Size size) {
    setState(() {
      widget.drawerSpecs = (size.width * 0.5);
    });
  }

  void closeDrawer() {
    setState(() {
      widget.drawerSpecs = (0);
    });
  }
}
