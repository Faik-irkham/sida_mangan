import 'dart:convert';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menus menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
        menus: Menus.fromJson(json["menus"]),
      );
}

class Menus {
  final List<Food> foods;
  final List<Drink> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<Food>.from(json["foods"].map((x) => Food.fromJson(x))),
        drinks: List<Drink>.from(json["drinks"].map((x) => Drink.fromJson(x))),
      );
}

class Food {
  final String name;

  Food({
    required this.name,
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        name: json["name"],
      );
}

class Drink {
  final String name;

  Drink({
    required this.name,
  });

  factory Drink.fromJson(Map<String, dynamic> json) => Drink(
        name: json["name"],
      );
}

List<Restaurant> parseRestaurant(String? json) {
  if (json == null) {
    return [];
  }

  final Map<String, dynamic> parsed = jsonDecode(json);
  final List<dynamic> restaurantList = parsed['restaurants'];

  return restaurantList.map((json) => Restaurant.fromJson(json)).toList();
}
