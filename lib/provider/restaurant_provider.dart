import 'package:flutter/material.dart';
import 'package:restaurant2/data/api/api_service.dart';
import 'package:restaurant2/data/model/detail.dart';
import 'package:restaurant2/data/model/restaurant.dart';
import 'package:restaurant2/utils/result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  String? query;
  String? id;

  RestaurantProvider({this.id, this.query, required this.apiService}) {
    if (id != null) {
      _fetchDetail(id!);
    } else if (query != null) {
      _fetchRestaurantByQuery(query!);
    } else {
      _fetchAllRestaurant();
    }
  }

  late RestaurantResult _restaurantResult;
  late SearchResult _searchResult;

  String _message = '';
  int _count = 0;
  late DetailResult _detailResult;
  late ResultState _state;

  String get message => _message;

  int get count => _count;

  RestaurantResult get result => _restaurantResult;

  DetailResult get detail => _detailResult;

  SearchResult get search => _searchResult;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.list();

      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        _count = restaurant.count;
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> _fetchRestaurantByQuery(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.search(query);

      if ((response.founded == 0) || (response.restaurants.isEmpty)) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'No Data Available';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _searchResult = response;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> _fetchDetail(String id) async {
    try {
      _state = ResultState.loading;

      notifyListeners();
      final detail = await apiService.get(id);

      if (detail.error == false) {
        _state = ResultState.hasData;

        notifyListeners();
        return _detailResult = detail;
      }
    } catch (e) {
      _state = ResultState.error;

      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
