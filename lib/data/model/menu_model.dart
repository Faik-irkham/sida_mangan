import 'package:sida_mangan/data/model/category_restaurant_model.dart';

class Menu {
  final List<Category> food;
  final List<Category> drink;

  Menu({
    required this.food,
    required this.drink,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        food: List<Category>.from(
          json["foods"].map(
            (x) => Category.fromJson(x),
          ),
        ),
        drink: List<Category>.from(
          json["drinks"].map(
            (x) => Category.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(food.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drink.map((x) => x.toJson())),
      };
}
