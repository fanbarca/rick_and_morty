import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tashcommerce/api_models/characters.dart';
import 'package:tashcommerce/ui/character_details_screen.dart';

class CharacterCard extends StatelessWidget {
  final Character result;
  const CharacterCard({
    Key key,
    this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return CharacterDetails(
              character: result,
            );
          }),
        );
      },
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            height: 160.0,
            decoration: BoxDecoration(
              color: Colors.white,
              // gradient: LinearGradient(
              //   colors: [
              //     Colors.tealAccent.shade100,
              //     Colors.cyan.shade200,
              //   ],
              //   end: Alignment.bottomCenter,
              //   begin: Alignment.topLeft,
              // ),
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.5, 4.0),
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 15.0,
                  spreadRadius: 1,
                )
              ],
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 20.0,
                  left: 20.0,
                  child: Hero(
                    tag: '${result.id}${result.name}',
                    child: Text(
                      result.name,
                      style: GoogleFonts.ptMono(
                          fontSize: 30.0,
                          color: Colors.brown,
                          //fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          shadows: []),
                    ),
                  ),
                ),
                Positioned(
                  top: 50.0,
                  left: 20.0,
                  child: Text(
                    '${result.status ?? result.type}',
                    style: GoogleFonts.ptMono(
                        fontSize: 20.0,
                        color: Colors.brown,
                        //fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        shadows: []),
                  ),
                ),
                Positioned(
                  bottom: 40.0,
                  left: 20.0,
                  child: Text(
                    '${result.species}',
                    style: GoogleFonts.ptMono(
                        fontSize: 20.0,
                        color: Colors.brown,
                        //fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        shadows: []),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 15.0,
            right: 20.0,
            width: 130,
            height: 130,
            child: Hero(
              tag: '${result.id}${result.image}',
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: result.image,
                  placeholder: (context, url) => CircularProgressIndicator(
                    strokeWidth: 15,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
