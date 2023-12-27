import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sida_mangan/data/api/api_service.dart';
import 'package:sida_mangan/data/model/add_review_model.dart';

enum ResultState { loading, noData, hasData, error }

class ReviewProviders extends ChangeNotifier {
  ApiService apiService = ApiService();

  late ResultState _state;
  String _message = '';

  String get message => _message;
  ResultState get state => _state;

  Future addReviews(AddReviewModel data) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      await apiService.addReviews(data);
    } catch (e) {
      if (e is SocketException) {
        _state = ResultState.error;
        notifyListeners();
        return _message = 'Tidak ada koneksi Internet!';
      } else {
        _state = ResultState.error;
        notifyListeners();
        return _message = 'Failed to Load Data';
      }
    }
  }
}
