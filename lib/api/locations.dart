// To parse this JSON data, do
//
//     final locations = locationsFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:tashcommerce/constants/constants.dart';

Locations locationsFromJson(String str) {
  Locations.fromJson(json.decode(str));
}

String locationsToJson(Locations data) => json.encode(data.toJson());

class Locations {
  Locations({
    this.info,
    this.results,
  });

  Info info;
  List<Location> results;

  factory Locations.fromJson(Map<String, dynamic> json) => Locations(
        info: Info.fromJson(json["info"]),
        results: List<Location>.from(
            json["results"].map((x) => Location.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info": info.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };

  Future<Locations> fetchData(int page) async {
    String param = page > 1 ? '?page=$page' : '';
    final response = await http.get('$rickAndMortyLocations$param');
    if (response.statusCode == 200) {
      return Locations.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}

class Info {
  Info({
    this.count,
    this.pages,
    this.next,
    this.prev,
  });

  int count;
  int pages;
  String next;
  dynamic prev;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
      };
}

class Location {
  Location({
    this.id,
    this.name,
    this.type,
    this.dimension,
    this.residents,
    this.url,
    this.created,
  });

  int id;
  String name;
  String type;
  String dimension;
  List<String> residents;
  String url;
  DateTime created;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        dimension: json["dimension"],
        residents: List<String>.from(json["residents"].map((x) => x)),
        url: json["url"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "dimension": dimension,
        "residents": List<dynamic>.from(residents.map((x) => x)),
        "url": url,
        "created": created.toIso8601String(),
      };
}
