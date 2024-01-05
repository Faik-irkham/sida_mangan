import 'package:sida_mangan/data/model/category_restaurant_model.dart';
import 'package:sida_mangan/data/model/customer_review_model.dart';
import 'package:sida_mangan/data/model/menu_model.dart';

class DetailRestaurantModel {
  final bool error;
  final String message;
  final Restaurant restaurant;

  DetailRestaurantModel({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory DetailRestaurantModel.fromJson(Map<String, dynamic> json) {
    return DetailRestaurantModel(
      error: json["error"],
      message: json["message"],
      restaurant: Restaurant.fromJson(json["restaurant"]),
    );
  }
}

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<Category> category;
  final Menu menu;
  final double rating;
  final List<CustomerReview> customerReview;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.category,
    required this.menu,
    required this.rating,
    required this.customerReview,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"] ?? "-",
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        category: json["categories"] != null
            ? List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x)))
            : [],
        menu: json["menus"] != null
            ? Menu.fromJson(json["menus"])
            : Menu(food: [], drink: []),
        rating: json["rating"].toDouble(),
        customerReview: json["customerReviews"] != null
            ? List<CustomerReview>.from(
                json["customerReviews"].map((x) => CustomerReview.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "address": address,
        "rating": rating,
      };
}
