import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tashcommerce/api/characters.dart';
import 'package:tashcommerce/models/food_item.dart';

class CharacterCard extends StatelessWidget {
  final Character result;
  const CharacterCard({
    Key key,
    this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(30.0),
            height: 170.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, -3),
                    color: Colors.black12,
                    blurRadius: 7.0)
              ],
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 20.0,
                  left: 20.0,
                  child: Text(
                    '${result.name}',
                    style: GoogleFonts.ptMono(
                        fontSize: 30.0,
                        color: Colors.brown,
                        //fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        shadows: []),
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
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: result.image,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
