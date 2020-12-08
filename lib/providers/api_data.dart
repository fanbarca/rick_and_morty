import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tashcommerce/api_models/characters.dart';
import 'package:tashcommerce/api_models/episodes.dart';
import 'package:tashcommerce/api_models/locations.dart';
import 'package:tashcommerce/constants/constants.dart';
import 'package:tashcommerce/providers/categories.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpClient {
  String param(int page) {
    return page > 1 ? '?page=$page' : '';
  }

  Future<Characters> getCharacters(int page) async {
    final url = "https://rickandmortyapi.com/api/character${param(page)}";
    final response = await http.get('$url');
    if (response.statusCode == 200) {
      return Characters.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<Episodes> getEpisodes(int page) async {
    final url = "https://rickandmortyapi.com/api/episode${param(page)}";
    final response = await http.get('$url');
    if (response.statusCode == 200) {
      return Episodes.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<Locations> getLocations(int page) async {
    final url = "https://rickandmortyapi.com/api/location${param(page)}";
    final response = await http.get('$url');
    if (response.statusCode == 200) {
      return Locations.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}

final httpClientProvider = Provider((ref) => HttpClient());

final charactersProvider = FutureProvider<Characters>((ref) async {
  final page = ref.watch(categoriesProvider).currentCategoryPage;
  final httpClient = ref.read(httpClientProvider);
  return httpClient.getCharacters(page);
});
final episodesProvider = FutureProvider<Episodes>((ref) async {
  final page = ref.watch(categoriesProvider).currentCategoryPage;
  final httpClient = ref.read(httpClientProvider);
  return httpClient.getEpisodes(page);
});
final locationsProvider = FutureProvider<Locations>((ref) async {
  final page = ref.watch(categoriesProvider).currentCategoryPage;
  final httpClient = ref.read(httpClientProvider);
  return httpClient.getLocations(page);
});
