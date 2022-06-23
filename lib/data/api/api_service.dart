import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:restaurant2/data/model/detail.dart';
import 'package:restaurant2/data/model/restaurant.dart';

class ApiService {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev';
  static const String listEndpoint = 'list';
  static const String detailEndpoint = 'detail';
  static const String searchEndpoint = 'search';
  static const String reviewEndpoint = 'review';

  final Client client;

  ApiService(this.client);

  Future<RestaurantResult> list() async {
    final response = await client.get(Uri.parse('$baseUrl/$listEndpoint'));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load lists');
    }
  }

  Future<DetailResult> get(String id) async {
    final response =
        await client.get(Uri.parse('$baseUrl/$detailEndpoint/$id'));

    if (response.statusCode == 200) {
      return DetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail');
    }
  }

  Future<SearchResult> search(String query) async {
    final response =
        await client.get(Uri.parse('$baseUrl/$searchEndpoint?q=$query'));

    if (response.statusCode == 200) {
      return SearchResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

}
