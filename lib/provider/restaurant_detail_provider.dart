import 'package:flutter/foundation.dart';
import 'package:restaurant2/data/api/api_service.dart';
import 'package:restaurant2/data/model/detail.dart';
import 'package:restaurant2/utils/result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  String id;

  RestaurantDetailProvider({required this.id, required this.apiService}) {
    _fetchDetail(id);
  }

  String _message = '';
  final int _count = 0;
  late ResultState _state;
  late DetailResult _detailResult;

  String get message => _message;

  int get count => _count;

  DetailResult get detail => _detailResult;

  ResultState get state => _state;

  Future<dynamic> _fetchDetail(String id) async {
    try {
      _state = ResultState.loading;
      _detailResult = await apiService.get(id);

      if (kDebugMode) {
        print('Detail Result state error : ${_detailResult.error}');
      }

      if (_detailResult.error == false) {
        _state = ResultState.hasData;
        notifyListeners();
      } else {
        _state = ResultState.noData;
        _message = 'Empty Data';
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error --> $e';
      notifyListeners();
    }
  }
}
