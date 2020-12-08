import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tashcommerce/api_models/characters.dart' as api;
import 'package:tashcommerce/api_models/episodes.dart';
import 'package:tashcommerce/api_models/locations.dart';
import 'package:tashcommerce/clippers/concave_curved_bottom.dart';
import 'package:tashcommerce/constants/constants.dart';
import 'package:tashcommerce/providers/api_data.dart';
import 'package:tashcommerce/providers/categories.dart';
import 'package:tashcommerce/widgets/episodes_card.dart';
import 'package:tashcommerce/widgets/fade_on_scroll.dart';
import 'package:tashcommerce/widgets/character_card.dart';
import 'package:tashcommerce/widgets/locations_card.dart';
import 'package:tashcommerce/widgets/animated_fade_transition.dart';
import 'package:tashcommerce/widgets/page_button.dart';
import 'package:tashcommerce/widgets/pagination.dart';

import 'drawer_background.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen();

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  EnterAnimation animation;
  AnimationController _controller;
  ScrollController _scrollController;

  int _currentIndex = 0;
  int _currentCategoryPage = 1;

  Categories categories = Categories();
  Size size;
  dynamic dataList;

  // double paginationOffset = 0;

  @override
  Widget build(BuildContext context) {
    print('build $widget');
    size = MediaQuery.of(context).size;

    return Consumer(
      builder: (context, watch, child) {
        categories = watch(categoriesProvider);
        if (_currentCategoryPage != categories.currentCategoryPage) {
          _currentCategoryPage = categories.currentCategoryPage;
          // updateData();
          // resetAnimation();
          expandAppBar();
        }
        if (_currentIndex != categories.currentIndex) {
          _currentIndex = categories.currentIndex;
          expandAppBar();
          resetAnimation();
          // updateData();
        }
        return child;
      },
      child: Scaffold(
        floatingActionButton: Opacity(
          opacity: 0.7,
          child: FloatingActionButton.extended(
            icon: Icon(Icons.arrow_forward_ios),
            label: Consumer(builder: (context, watch, child) {
              final page = watch(categoriesProvider).currentCategoryPage;
              return Text(
                'Page $page',
                style: TextStyle(fontSize: 18),
              );
            }),
            onPressed: () {
              showModalBottomSheet(
                elevation: 0,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return Pagination();
                },
              );
            },
            backgroundColor: Colors.redAccent,
          ),
        ),
        drawer: Drawer(
          child: DrawerBackground(),
        ),
        body: AnimatedBuilder(
          animation: animation.controller,
          builder: (context, child) {
            return CustomScrollView(
              physics: BouncingScrollPhysics(),
              controller: _scrollController,
              slivers: <Widget>[
                SliverAppBar(
//                title: FadeOnScroll(
//                  scrollController: scrollController,
//                  fullOpacityOffset: 180,
//                  child: Center(
//                      child:
//                          Text('${categories.currentCategory}', style: kTitle)),
//                ),
//                 onStretchTrigger: () {
//                   return categories.notify(categories.currentIndex);
//                 },
                  elevation: 0,
                  pinned: true,
                  stretch: true,
                  backgroundColor: Colors.transparent,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(22.0),
                    child: Text(''),
                  ),
                  expandedHeight: animation.barHeight.value,
                  flexibleSpace: Stack(
                    children: [
                      Positioned(
                          child: ClipPath(
                            clipper: ConcaveCurvedBottom(),
                            child: Stack(
                              children: <Widget>[
                                Opacity(
                                  opacity: animation.barHeight.value / 250,
                                  child: Consumer(
                                    builder: (context, watch, child) {
                                      String cat = watch(categoriesProvider)
                                          .currentCategory;
                                      return Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              'images/$cat.png',
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Opacity(
                                  opacity: animation.barHeight.value / 250,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: kGradient,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: size.width,
                          height: 70,
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.diagonal3Values(
                              animation.avatarSize.value * 2,
                              animation.avatarSize.value * 2,
                              1,
                            ),
                            child: Stack(
                              alignment: Alignment.topCenter,
                              fit: StackFit.expand,
                              children: <Widget>[
                                FadeOnScroll(
                                  zeroOpacityOffset: 180.0,
                                  fullOpacityOffset: 0.0,
                                  scrollController: _scrollController,
                                  child: ClipOval(
                                    child: Image(
                                      image: AssetImage(
                                        'images/Portal.png',
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Consumer(
                                      builder: (context, watch, child) {
                                    String cat = watch(categoriesProvider)
                                        .currentCategory;
                                    return Text(
                                      cat,
                                      style: kTitle,
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: animation.titleOpacity.value,
                    decoration: BoxDecoration(),
                  ),
                ),
                child,
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 15.0,
                  ),
                ),
              ],
            );
          },
          child: Consumer(
            builder: (context, watch, child) {
              final cat = watch(categoriesProvider).currentCategory;
              var responseAsyncValue;
              if (cat == (Characters).toString()) {
                responseAsyncValue = watch(charactersProvider);
              } else if (cat == (Episodes).toString())
                responseAsyncValue = watch(episodesProvider);
              else if (cat == (Locations).toString())
                responseAsyncValue = watch(locationsProvider);
              return responseAsyncValue.map(
                data: (_) {
                  context
                      .read(categoriesProvider)
                      .setCurrentCategoryMaxPages(_.value.info.pages);
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index != _.value.results.length) {
                          return AnimatedFadeTransition(
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: buildCard(index, _.value),
                            ),
                          );
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_back_ios_rounded),
                                onPressed: () => context
                                    .read(categoriesProvider)
                                    .decrementCurrentCategoryPage(),
                              ),
                              SizedBox(width: 50),
                              IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                onPressed: () => context
                                    .read(categoriesProvider)
                                    .incrementCurrentCategoryPage(),
                              ),
                            ],
                          );
                        }
                      },
                      childCount:
                          _.value.results.length + 1, //child.results.length,
                    ),
                  );
                },
                loading: (_) => SliverToBoxAdapter(
                  child: Container(
                    height: size.height / 3,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                error: (_) => SliverToBoxAdapter(
                  child: Text(
                    _.error.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              );
            },
          ),
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

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      keepScrollOffset: false,
      initialScrollOffset: 0,
    );

    // ..addListener(_scrollListener);

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      //reverseDuration: Duration(milliseconds: 500),
      vsync: this,
    );
    animation = EnterAnimation(_controller);
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

  dynamic buildCard(int index, snapshot) {
    if (categories.currentCategory == (api.Characters).toString())
      return CharacterCard(
        result: snapshot.results[index],
      );
    else if (categories.currentCategory == (Locations).toString())
      return LocationsCard(
        result: snapshot.results[index],
      );
    else if (categories.currentCategory == (Episodes).toString())
      return EpisodesCard(
        result: snapshot.results[index],
      );
  }

  void expandAppBar() {
    if (_scrollController.hasClients && _scrollController.offset > 10)
      _scrollController.animateTo(
        animation.barHeight.value,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 10),
      );
  }

  Text buildDots() {
    return Text(
      '...',
      style: TextStyle(fontSize: 35, color: Theme.of(context).primaryColor),
    );
  }
}

class EnterAnimation {
  final AnimationController controller;
  final Animation<double> barHeight;
  final Animation<double> avatarSize;
  final Animation<double> titleOpacity;
  final Animation<double> textOpacity;

  EnterAnimation(this.controller)
      : barHeight = Tween<double>(begin: 0, end: 250).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0, 0.35, curve: Curves.easeOutQuart),
          ),
        ),
        avatarSize = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.2, 0.8, curve: Curves.elasticOut),
          ),
        ),
        titleOpacity = Tween<double>(begin: 800, end: 30).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.5, 0.8, curve: Curves.easeOutCirc),
          ),
        ),
        textOpacity = Tween<double>(begin: 5, end: 0.6).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 1.0, curve: Curves.easeOutCirc),
          ),
        );
}
