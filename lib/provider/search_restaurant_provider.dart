import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sida_mangan/data/api/api_service.dart';
import 'package:sida_mangan/data/model/search_restaurant_model.dart';

enum ResultState { loading, noData, hasData, error }

class SearchRestaurantsProvider extends ChangeNotifier {
  ApiService apiService = ApiService();
  late SearchRestaurantModel _restaurantResult =
      SearchRestaurantModel(error: false, founded: 0, restaurants: []);
  late bool _isLoading = false;
  late String _message = '';
  String get message => _message;
  bool get isLoading => _isLoading;
  SearchRestaurantModel get result => _restaurantResult;

  Future<dynamic> searchRestaurant(String query) async {
    try {
      _restaurantResult =
          SearchRestaurantModel(error: true, founded: 0, restaurants: []);
      _isLoading = true;
      notifyListeners();
      final restaurantLists = await apiService.searchRestaurants(query);
      if (restaurantLists.restaurants.isEmpty) {
        _isLoading = false;
        notifyListeners();
        return _message = 'Restaurant or Menu not found';
      } else {
        notifyListeners();
        _isLoading = false;
        return _restaurantResult = restaurantLists;
      }
    } catch (e) {
      if (e is SocketException) {
        _isLoading = false;
        notifyListeners();
        return _message = 'No Internet Connection';
      } else {
        _isLoading = false;
        notifyListeners();
        return _message = 'Failed to Load Data';
      }
    }
  }
  // ApiService apiService = ApiService();

  // late SearchRestaurantModel _restaurantsResult;
  // late ResultState _state;
  // String _message = '';

  // String get message => _message;
  // SearchRestaurantModel get result => _restaurantsResult;
  // ResultState get state => _state;

  // Future<dynamic> searchRestaurants(String value) async {
  //   try {
  //     _state = ResultState.loading;
  //     notifyListeners();
  //     final listRestaurant = await apiService.searchRestaurants(value);
  //     if (listRestaurant.restaurants.isEmpty) {
  //       _state = ResultState.noData;
  //       notifyListeners();
  //       return _message = 'Empty Data';
  //     } else {
  //       _state = ResultState.hasData;
  //       notifyListeners();
  //       _restaurantsResult = listRestaurant;
  //     }
  //   } catch (e) {
  //     if (e is SocketException) {
  //       _state = ResultState.error;
  //       notifyListeners();
  //       return _message = 'Tidak ada koneksi Internet!';
  //     } else {
  //       _state = ResultState.error;
  //       notifyListeners();
  //       return _message = 'Failed to Load Data';
  //     }
  //   }
  // }
}
