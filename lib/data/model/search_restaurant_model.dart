import 'package:sida_mangan/data/model/restaurant_model.dart';

class SearchRestaurantModel {
  final bool error;
  final int founded;
  final List<Restaurant> restaurants;

  SearchRestaurantModel({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  SearchRestaurantModel copyWith({
    bool? error,
    int? founded,
    List<Restaurant>? restaurants,
  }) =>
      SearchRestaurantModel(
        error: error ?? this.error,
        founded: founded ?? this.founded,
        restaurants: restaurants ?? this.restaurants,
      );

  factory SearchRestaurantModel.fromJson(Map<String, dynamic> json) =>
      SearchRestaurantModel(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
