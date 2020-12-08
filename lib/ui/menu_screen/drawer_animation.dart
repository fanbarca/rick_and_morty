import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tashcommerce/providers/drawer_specs.dart';

class DrawerAnimation extends StatefulWidget {
  DrawerAnimation({Key key, this.page}) : super(key: key);
  final Widget page;

  @override
  _DrawerAnimationState createState() => _DrawerAnimationState();
}

class _DrawerAnimationState extends State<DrawerAnimation> {
  DrawerSpecs drawerSpecs;
  Size size;
  double newValue = 0;
  bool moving = false;

  @override
  Widget build(BuildContext context) {
    print('build of $this');
    // drawerSpecs = Provider.of<DrawerSpecs>(context);
    size = MediaQuery.of(context).size;
    // if (!moving) newValue = drawerSpecs.getDrawerValue;

    return Stack(
      children: <Widget>[
        TweenAnimationBuilder(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeOutExpo,
          tween: Tween(begin: 0.0, end: newValue),
          builder: (context, value, child) {
            //double newX = ;
            //double newY = (size.height * (value * 0.2 / size.width)) / 2;
            double newScale = (1 - value * 0.6 / size.width);
            return Transform(
              alignment: Alignment.centerRight,
              transform: Matrix4.translationValues(value * 0.5, 0, 0)
                ..scale(newScale)
                ..setEntry(3, 2, -0.0009)
                ..rotateY(-value / size.width),
              // ..scale(newScale),
              child: GestureDetector(
                dragStartBehavior: DragStartBehavior.down,
                onTap: () {
                  if (value > 0) {
                    closeDrawer();
                  }
                },
                onHorizontalDragEnd: (details) {
                  if ((details.velocity.pixelsPerSecond.dx > 0)) {
                    openDrawer();
                  } else if ((details.velocity.pixelsPerSecond.dx < 0)) {
                    closeDrawer();
                  } else {
                    if (newValue < size.width * 0.18) {
                      closeDrawer();
                    } else {
                      openDrawer();
                    }
                  }
                  if (moving) moving = false;
                },
                onHorizontalDragUpdate: (details) {
                  if (!moving) moving = true;
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
                    child,
                    newValue == 0
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
        Drawer(),
        SafeArea(
          child: GestureDetector(
            onTap: () {
              if (newValue > 0)
                closeDrawer();
              else if (newValue == 0) openDrawer();
            },
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Icon(
                Icons.menu,
                size: 40,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void moveLeft(DragUpdateDetails details) {
    // setState(() {
    // });
    newValue -= details.delta.dx.abs();
    drawerSpecs.setDrawerValue(newValue);
  }

  void moveRight(DragUpdateDetails details) {
    // setState(() {
    // });
    newValue += details.delta.dx;
    drawerSpecs.setDrawerValue(newValue);
  }

  void openDrawer() {
    // setState(() {
    // });
    newValue = (size.width * 0.5);
    drawerSpecs.setDrawerValue(newValue);
  }

  void closeDrawer() {
    // setState(() {
    // });
    newValue = (0);
    drawerSpecs.setDrawerValue(newValue);
  }
}
