import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant2/data/api/api_service.dart';
import 'package:restaurant2/data/model/detail.dart';
import 'package:restaurant2/data/model/restaurant.dart';
import 'package:restaurant2/provider/restaurant_provider.dart';

import '../../json_reader.dart';
import 'restaurant_provider_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  group('Restaurant Provider Test', () {
    var apiMock = MockApiService();
    RestaurantProvider? restaurantProvider;

    setUp(() {
      when(apiMock.list()).thenAnswer((_) async => Future.value(
          RestaurantResult.fromJson(
              json.decode(readJson('dummy_data/list_response.json')))));
      restaurantProvider =
          RestaurantProvider(id: null, query: null, apiService: apiMock);
    });

    test('verify that fetch all restaurants json parse run as expected',
        () async {
      var result = restaurantProvider!.result.restaurants[0];
      var jsonRestaurant = Restaurant.fromJson(
          json.decode(readJson('dummy_data/item_response.json')));
      expect(result.id, equals(jsonRestaurant.id));
      expect(result.name, equals(jsonRestaurant.name));
      expect(result.description, equals(jsonRestaurant.description));
      expect(result.pictureId, equals(jsonRestaurant.pictureId));
      expect(result.city, equals(jsonRestaurant.city));
      expect(result.rating, equals(jsonRestaurant.rating));
    });

    test('verify that restaurants search json parse run as expected', () async {
      when(apiMock.search('melting')).thenAnswer((_) async =>
          SearchResult.fromJson(
              json.decode(readJson('dummy_data/search_response.json'))));
      var result = restaurantProvider!.result.restaurants[0];
      var jsonRestaurant = Restaurant.fromJson(
          json.decode(readJson('dummy_data/item_response.json')));
      expect(result.id, equals(jsonRestaurant.id));
      expect(result.name, equals(jsonRestaurant.name));
      expect(result.description, equals(jsonRestaurant.description));
      expect(result.pictureId, equals(jsonRestaurant.pictureId));
      expect(result.city, equals(jsonRestaurant.city));
      expect(result.rating, equals(jsonRestaurant.rating));
    });
  });

  group('Restaurant Provider Test', () {
    var apiMock = MockApiService();
    const id = "rqdv5juczeskfw1e867";
    RestaurantProvider? restaurantProvider;

    setUp(() {
      when(apiMock.get(id)).thenAnswer((_) async => Future.value(
          DetailResult.fromJson(
              json.decode(readJson('dummy_data/detail_response.json')))));
      restaurantProvider =
          RestaurantProvider(id: id, query: null, apiService: apiMock);
    });

    test('verify that fetch detail of restaurants json parse run as expected',
        () async {
      var result = restaurantProvider!.detail.detail;
      var jsonRestaurant = DetailResult.fromJson(
              json.decode(readJson('dummy_data/detail_response.json')))
          .detail;
      expect(result.id, equals(jsonRestaurant.id));
      expect(result.name, equals(jsonRestaurant.name));
      expect(result.description, equals(jsonRestaurant.description));
      expect(result.pictureId, equals(jsonRestaurant.pictureId));
      expect(result.city, equals(jsonRestaurant.city));
      expect(result.rating, equals(jsonRestaurant.rating));
    });
  });
}
