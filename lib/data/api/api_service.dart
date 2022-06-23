import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:restaurant2/data/model/detail.dart';
import 'package:restaurant2/data/model/restaurant.dart';
import 'package:restaurant2/utils/constants.dart';

class ApiService {
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
