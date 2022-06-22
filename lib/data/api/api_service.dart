import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../model/detail.dart';
import '../model/restaurant.dart';

class ApiService {

  static final String _baseUrl = 'https://restaurant-api.dicoding.dev';
  static final String _detailEndpoint = 'detail';
  static final String _searchEndpoint = 'search';

  Future<RestaurantResult> list() async {
    final response = await http.get(Uri.parse('$_baseUrl/list'));

    try {
      if (response.statusCode == 200) {
        return RestaurantResult.fromJson(json.decode(response.body));
      }
    } on SocketException {
      print('No Internet Access');
    } on HttpException {
      print('Not Found');
    } on FormatException {
      print('Bad Response');
    }

    throw Exception('Failed to load lists');
  }

  Future<DetailResult> get(String id) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/$_detailEndpoint/$id'));

    if (response.statusCode == 200) {
      return DetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail');
    }
  }

  Future<SearchResult> search(String query) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/$_searchEndpoint?q=$query'));

    if (response.statusCode == 200) {
      return SearchResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }
}
