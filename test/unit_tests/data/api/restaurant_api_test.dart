import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant2/data/api/api_service.dart';
import 'package:restaurant2/data/model/detail.dart';
import 'package:restaurant2/data/model/restaurant.dart';
import 'package:restaurant2/utils/constants.dart';

import '../../../json_reader.dart';
import 'restaurant_api_test.mocks.dart';

final restaurantResult = RestaurantResult.fromJson(
    json.decode(readJson('dummy_data/list_response.json')));

final detailResult = DetailResult.fromJson(
    json.decode(readJson('dummy_data/detail_response.json')));

final searchResult = SearchResult.fromJson(
    json.decode(readJson('dummy_data/search_response.json')));

@GenerateMocks([http.Client])
void main() {
  group('API Testing', () {
    test('Return list of a restaurant', () async {
      var client = MockClient();

      // Use mockito to return a successful response when it calls the
      // provided http.Client

      // arrange
      when(client.get(Uri.parse('$baseUrl/$listEndpoint')))
          .thenAnswer((_) async => http.Response(
                readJson('dummy_data/list_response.json'),
                200,
                headers: {
                  HttpHeaders.contentTypeHeader:
                      'application/json; charset=utf-8',
                },
              ));
      // act
      final result = await ApiService(client).list();

      // result
      expect(result, isA<RestaurantResult>());
      expect(result, equals(restaurantResult));
    });

    test('Return Restaurant by Id', () async {
      var client = MockClient();
      const id = 'rqdv5juczeskfw1e867';

      // Use Mockito to return a successful response when it calls the
      // provided http.Client,

      // arrange
      when(client.get(
              Uri.parse('$baseUrl/$detailEndpoint/$id'))) //id of Melting Pot
          .thenAnswer((_) async => http.Response(
                readJson('dummy_data/detail_response.json'),
                200,
                headers: {
                  HttpHeaders.contentTypeHeader:
                      'application/json; charset=utf-8',
                },
              ));

      // act
      final result = await ApiService(client).get(id);

      // assert
      expect(result, isA<DetailResult>());
      expect(result, detailResult);
    });

    test('Return Restaurant by Query in search', () async {
      var client = MockClient();
      const query = 'melting';

      // Use Mockito to return a successful response when it calls the
      // provided http.Client,

      // arrange
      when(client.get(Uri.parse(
              '$baseUrl/$searchEndpoint?q=$query'))) //id of Melting Pot
          .thenAnswer((_) async => http.Response(
                readJson('dummy_data/search_response.json'),
                200,
                headers: {
                  HttpHeaders.contentTypeHeader:
                      'application/json; charset=utf-8',
                },
              ));
      // act
      final result = await ApiService(client).search(query);

      // assert
      expect(result, isA<SearchResult>());
      expect(result, searchResult);
    });
  });
}
