import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tashcommerce/api_models/characters.dart';

class CharacterDetails extends StatelessWidget {
  const CharacterDetails({Key key, this.character}) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Hero(
              tag: '${character.id}${character.image}',
              child: CachedNetworkImage(imageUrl: character.image),
            ),
            Hero(
              tag: '${character.id}${character.name}',
              child: Text(
                character.name,
                style: GoogleFonts.ptMono(
                    fontSize: 30.0,
                    color: Colors.brown,
                    //fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    shadows: []),
              ),
            ),
            Text('Appeared in:'),
            Text('${character.episode}'),
            Text('Lives in:'),
            Text('${character.location.name}'),
            Text('Origin:'),
            Text('${character.origin.name}'),
            Text('Belongs to:'),
            Text('${character.species}'),
            Text('Gender:'),
            Text('${character.gender}'),
            Text('Type:'),
            Text('${character.type}'),
          ],
        ),
      ),
    );
  }
}
