import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sida_mangan/common/constant.dart';
import 'package:sida_mangan/data/model/add_review_model.dart';
import 'package:sida_mangan/data/model/detail_restaurant_model.dart';
import 'package:sida_mangan/data/model/restaurant_model.dart';
import 'package:sida_mangan/data/model/search_restaurant_model.dart';

class ApiService {
  Future<RestaurantsModel> listRestaurant() async {
    final response = await http.get(Uri.parse('$baseUrl/list'));
    if (response.statusCode == 200) {
      return RestaurantsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load list restaurant');
    }
  }

  Future<DetailRestaurantModel> detailRestaurant(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/detail/$id'));
    if (response.statusCode == 200) {
      return DetailRestaurantModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }

  Future<SearchRestaurantModel> searchRestaurants(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/search?q=$query'),
    );
    if (response.statusCode == 200) {
      return SearchRestaurantModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to search');
    }
  }

  Future addReviews(AddReviewModel data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/review'),
      body: data.toJson(),
    );

    if (response.statusCode == 201) {
      // Handle success
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to Review');
    }
  }
}
