import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sida_mangan/common/constant.dart';
import 'package:sida_mangan/data/model/detail_restaurant.dart';
import 'package:sida_mangan/data/model/restaurant.dart';

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
}
