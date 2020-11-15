import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tashcommerce/models/categories.dart';

import 'package:tashcommerce/screens/menu_screen/splash_screen.dart';
import 'package:tashcommerce/widgets/character_card.dart';
import 'package:tashcommerce/widgets/episodes_card.dart';
import 'package:tashcommerce/widgets/locations_card.dart';

import '../shopping_cart.dart';

class SplashAnimation extends StatefulWidget {
  @override
  _SplashAnimationState createState() => _SplashAnimationState();
}

class _SplashAnimationState extends State<SplashAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  ScrollController _scrollController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      keepScrollOffset: false,
      initialScrollOffset: 0,
    )..addListener(_scrollListener);

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      //reverseDuration: Duration(milliseconds: 500),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();

    _scrollController.dispose();
  }

  void _scrollListener() {
    // print(_scrollController.position.extentAfter);
    if (_scrollController.position.extentAfter < 100) {
      // setState(() {
      // requestData(context);
      // print('yeeees');
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Categories>(
      builder: (context, value, child) {
        if (_currentIndex != value.currentIndex) {
          _currentIndex = value.currentIndex;
          resetAnimation();
        }
        return child;
      },
      child: Scaffold(
        body: SplashScreen(
          controller: _controller,
          scrollController: _scrollController,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.shopping_cart),
          onPressed: () {
            showModalBottomSheet(
              elevation: 0,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) {
                return ShoppingCart();
              },
            );
          },
          backgroundColor: Colors.redAccent,
        ),
      ),
    );
  }

  Future resetAnimation() async {
    _controller.reset();
    _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 10),
    );
    await Future.delayed(Duration(milliseconds: 200));
    _controller.forward();
  }
}
