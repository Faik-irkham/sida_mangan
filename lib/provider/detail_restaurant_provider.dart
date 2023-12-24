import 'package:flutter/material.dart';
import 'package:sida_mangan/data/api/api_service.dart';
import 'package:sida_mangan/data/model/detail_restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class DetailRestaurantsProvider extends ChangeNotifier {
  final ApiService apiService;
  String id;

  DetailRestaurantsProvider({required this.apiService, required this.id}) {
    _fetchDetailRestaurant();
  }

  late DetailRestaurantModel _detailRestaurantResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  DetailRestaurantModel get result => _detailRestaurantResult;

  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final detailRestaurant = await apiService.detailRestaurant(id);
      if (detailRestaurant.restaurant.id.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailRestaurantResult = detailRestaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
