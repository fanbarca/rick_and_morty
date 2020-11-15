import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tashcommerce/api/characters.dart';
import 'package:tashcommerce/api/episodes.dart';
import 'package:tashcommerce/models/food_item.dart';

class EpisodesCard extends StatelessWidget {
  final Episode result;
  final index;
  const EpisodesCard({
    Key key,
    this.result,
    this.index,
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
//          gradient: RadialGradient(
//            colors: [Colors.black, Colors.transparent],
//            radius: 1.9,
//            center: Alignment(0.0, 4.0),
//          ),
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
                    '${result.episode}',
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
                    '${result.airDate}',
                    style: GoogleFonts.ptMono(
                        fontSize: 20.0,
                        color: Colors.brown,
                        //fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        shadows: []),
                  ),
                ),
                // Positioned(
                //   bottom: 20.0,
                //   right: 0.0,
                //   child: FlatButton.icon(
                //     color: Colors.redAccent,
                //     onPressed: () {},
                //     label: Text('Add to cart',
                //         style: GoogleFonts.ptMono(
                //             fontSize: 15.0,
                //             //backgroundColor: Colors.redAccent,
                //             color: Colors.white,
                //             //fontStyle: FontStyle.italic,
                //             fontWeight: FontWeight.bold,
                //             shadows: [])),
                //     icon: Icon(
                //       Icons.add_shopping_cart,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          // Positioned(
          //   top: 15.0,
          //   right: 20.0,
          //   width: 130,
          //   height: 130,
          //   child: ClipOval(
          //     child: CachedNetworkImage(
          //       imageUrl: result.image,
          //       placeholder: (context, url) => CircularProgressIndicator(),
          //       errorWidget: (context, url, error) => Icon(Icons.error),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
