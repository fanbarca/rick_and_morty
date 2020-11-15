import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tashcommerce/api/characters.dart' as api;
import 'package:tashcommerce/api/episodes.dart';
import 'package:tashcommerce/api/locations.dart';
import 'package:tashcommerce/constants/constants.dart';
import 'package:tashcommerce/models/categories.dart';
import 'package:tashcommerce/widgets/episodes_card.dart';
import 'package:tashcommerce/widgets/fade_on_scroll.dart';
import 'package:tashcommerce/widgets/character_card.dart';
import 'package:tashcommerce/widgets/locations_card.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({
    AnimationController controller,
    @required this.scrollController,
  }) : animation = EnterAnimation(controller);

  final ScrollController scrollController;
  final EnterAnimation animation;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Categories categories;
  Size size;
  dynamic dataList;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    categories = Provider.of<Categories>(context);
    updateData();

    return Scaffold(
      body: AnimatedBuilder(
        animation: widget.animation.controller,
        builder: (context, child) {
          return CustomScrollView(
            physics: BouncingScrollPhysics(),
            controller: widget.scrollController,
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
//                   return updateData();
//                 },
                elevation: 0,
                pinned: true,
                stretch: true,
                backgroundColor: Colors.transparent,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(22.0),
                  child: Text(''),
                ),
                expandedHeight: widget.animation.barHeight.value,
                flexibleSpace: Stack(
                  children: [
                    Positioned(
                        child: ClipPath(
                          clipper: ConcaveCurvedBottom(),
                          child: Stack(
                            children: <Widget>[
                              Opacity(
                                opacity: widget.animation.barHeight.value / 250,
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'images/${categories.currentCategory}.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Opacity(
                                opacity: widget.animation.barHeight.value / 250,
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
                            widget.animation.avatarSize.value * 2,
                            widget.animation.avatarSize.value * 2,
                            1,
                          ),
                          child: Stack(
                            alignment: Alignment.topCenter,
                            fit: StackFit.expand,
                            children: <Widget>[
                              FadeOnScroll(
                                zeroOpacityOffset: 180.0,
                                fullOpacityOffset: 0.0,
                                scrollController: widget.scrollController,
                                child: ClipOval(
                                  child: Image(
                                    image: AssetImage(
                                      'images/Portal.png',
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  '${categories.currentCategory}',
                                  style: kTitle,
                                ),
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
                  height: widget.animation.titleOpacity.value,
                  decoration: BoxDecoration(),
                ),
              ),
              FutureBuilder(
                  future: dataList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      categories
                          .setCurrentCategoryMaxPages(snapshot.data.info.pages);
                      if (snapshot.connectionState == ConnectionState.done)
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return Align(
                                alignment: Alignment.topCenter,
                                child: buildCard(index, snapshot),
                              );
                            },
                            childCount: snapshot
                                .data.results.length, //child.results.length,
                          ),
                        );
                      else
                        return SliverToBoxAdapter(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                    } else
                      return SliverToBoxAdapter(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                  }),
              SliverToBoxAdapter(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: categories.currentCategoryPage > 1
                              ? () {
                                  expandAppBar();
                                  categories.decrementCurrentCategoryPage();
                                }
                              : null,
                          child: Text('Previous page'),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            '${categories.currentCategoryPage}',
                            style: TextStyle(
                              fontSize: 30,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: categories.currentCategoryPage <
                                  categories.currentCategoryMaxPages
                              ? () {
                                  expandAppBar();
                                  categories.incrementCurrentCategoryPage();
                                }
                              : null,
                          child: Text('Next page'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 15.0,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  dynamic buildCard(int index, snapshot) {
    if (categories.currentCategory == (api.Characters).toString())
      return CharacterCard(
        result: snapshot.data.results[index],
      );
    else if (categories.currentCategory == (Locations).toString())
      return LocationsCard(
        result: snapshot.data.results[index],
      );
    else if (categories.currentCategory == (Episodes).toString())
      return EpisodesCard(
        result: snapshot.data.results[index],
      );
  }

  Future<void> updateData() {
    if (categories.currentCategory == (api.Characters).toString())
      dataList = api.Characters().fetchData(categories.currentCategoryPage);
    else if (categories.currentCategory == (Locations).toString())
      dataList = Locations().fetchData(categories.currentCategoryPage);
    else if (categories.currentCategory == (Episodes).toString())
      dataList = Episodes().fetchData(categories.currentCategoryPage);
  }

  void expandAppBar() {
    widget.scrollController.animateTo(
      widget.animation.barHeight.value,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 10),
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
            curve: Interval(0.3, 0.8, curve: Curves.easeOutCirc),
          ),
        ),
        textOpacity = Tween<double>(begin: 5, end: 0.6).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 1.0, curve: Curves.easeOutCirc),
          ),
        );
}

class ConcaveCurvedBottom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = 30;
    Path path = Path();
    path.lineTo(0.0, size.height);
    path.quadraticBezierTo(size.width / 4, size.height - height, size.width / 2,
        size.height - height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height - height,
        size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
