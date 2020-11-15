import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
import 'package:http/http.dart' as http;
import 'package:tashcommerce/widgets/locations_card.dart';

Stream<dynamic> fetchData(Categories categories) async* {
  String param = categories.currentCategoryPage > 1
      ? '?page=${categories.currentCategoryPage}'
      : '';
  final response = await http.get('${rickAndMortyApi(categories)}$param');
  if (response.statusCode == 200) {
    if (categories.currentCategory == 'Characters')
      yield api.Characters.fromJson(json.decode(response.body));
    else if (categories.currentCategory == 'Locations')
      yield Locations.fromJson(json.decode(response.body));
    else if (categories.currentCategory == 'Episodes')
      yield Episodes.fromJson(json.decode(response.body));
    else
      throw Exception('Failed to load post');
  } else {
    throw Exception('Failed to load post');
  }
}

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
  @override
  Widget build(BuildContext context) {
    Categories categories = Provider.of<Categories>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
        animation: widget.animation.controller,
        builder: (context, child) {
          return CustomScrollView(
            // shrinkWrap: true,
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
              StreamBuilder<dynamic>(
                stream: fetchData(categories),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      categories
                          .setCurrentCategoryMaxPages(snapshot.data.info.pages);
                      return SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return Align(
                            alignment: Alignment.topCenter,
                            child: buildCard(
                                snapshot, index, categories.currentCategory),
                          );
                        }, childCount: snapshot.data.results.length),
                      );
                    } else
                      return Container();
                  } else {
                    return SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Container(
                            height: 250,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          SizedBox(
                            height: 300,
                          )
                        ],
                      ),
                    );
                  }
                },
              ),
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
}

Widget buildCard(dynamic snapshot, int index, String currentCategory) {
  if (currentCategory == 'Characters')
    return CharacterCard(
      result: snapshot.data.results[index],
      index: index,
    );
  else if (currentCategory == 'Locations')
    return LocationsCard(
      result: snapshot.data.results[index],
      index: index,
    );
  else if (currentCategory == 'Episodes')
    return EpisodesCard(
      result: snapshot.data.results[index],
      index: index,
    );
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
