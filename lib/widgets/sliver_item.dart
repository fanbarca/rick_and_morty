import 'package:flutter/material.dart';

import 'menu_tile.dart';

class MenuItem extends StatelessWidget {
  final int index;
  MenuItem({this.index});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: Delegate(index: index),
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  int index;
  Delegate({this.index});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return MenuTile(index: index);
  }

  @override
  double get maxExtent => 150;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
