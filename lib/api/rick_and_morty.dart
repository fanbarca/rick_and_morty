// To parse this JSON data, do
//
//     final rickAndMorty = rickAndMortyFromJson(jsonString);

import 'dart:convert';

RickAndMorty rickAndMortyFromJson(String str) =>
    RickAndMorty.fromJson(json.decode(str));

String rickAndMortyToJson(RickAndMorty data) => json.encode(data.toJson());

class RickAndMorty {
  RickAndMorty({
    this.characters,
    this.locations,
    this.episodes,
  });

  String characters;
  String locations;
  String episodes;

  factory RickAndMorty.fromJson(Map<String, dynamic> json) => RickAndMorty(
        characters: json["characters"],
        locations: json["locations"],
        episodes: json["episodes"],
      );

  Map<String, dynamic> toJson() => {
        "characters": characters,
        "locations": locations,
        "episodes": episodes,
      };
}
