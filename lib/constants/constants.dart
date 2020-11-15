import 'package:flutter/material.dart';
import 'package:tashcommerce/models/categories.dart';

enum DrawerState { closed, closing, opening, opened }

Color kBackgroundColor = Colors.teal;
TextStyle kTitle = TextStyle(
  shadows: [
    Shadow(
      offset: Offset(0, 0),
      color: Colors.black.withOpacity(1),
      blurRadius: 20.0,
    )
  ],
  fontFamily: 'Neucha',
  color: Colors.white,
  fontSize: 40,
  fontWeight: FontWeight.bold,
  decoration: TextDecoration.none,
);
TextStyle kTitleMedium = TextStyle(
  shadows: [
    Shadow(
      offset: Offset(0, 0),
      color: Colors.black.withOpacity(1),
      blurRadius: 20.0,
    )
  ],
  fontFamily: 'Neucha',
  color: Colors.white,
  fontSize: 55,
  fontWeight: FontWeight.bold,
  decoration: TextDecoration.none,
);
TextStyle kTitleBig = TextStyle(
  shadows: [
    Shadow(
      offset: Offset(0, 0),
      color: Colors.black.withOpacity(1),
      blurRadius: 20.0,
    )
  ],
  fontFamily: 'Neucha',
  color: Colors.white,
  fontSize: 80,
  fontWeight: FontWeight.bold,
  decoration: TextDecoration.none,
);
BoxShadow kBoxShadow = BoxShadow(
  offset: Offset(0, 4),
  color: Colors.black.withOpacity(0.3),
  blurRadius: 7.0,
);
LinearGradient kGradient = LinearGradient(
  //stops: [0.5, 1.0],
  begin: Alignment.bottomCenter,
  end: Alignment.center,
  colors: [
    Colors.black.withOpacity(0.5),
    Colors.transparent,
  ], //
  // whitish to gray

  //tileMode: TileMode.clamp, // repeats the gradient over the canvas
);
String rickAndMortyApi(Categories categories) {
  if (categories.currentCategory == 'Characters')
    return rickAndMortyCharacters;
  else if (categories.currentCategory == 'Locations')
    return rickAndMortyLocations;
  else if (categories.currentCategory == 'Episodes')
    return rickAndMortyEpisodes;
  else
    return 'https://rickandmortyapi.com/api/';
}

String rickAndMortyCharacters = "https://rickandmortyapi.com/api/character";
String rickAndMortyLocations = "https://rickandmortyapi.com/api/location";
String rickAndMortyEpisodes = "https://rickandmortyapi.com/api/episode";
