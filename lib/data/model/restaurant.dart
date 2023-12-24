class RestaurantsModel {
  final bool error;
  final String message;
  final int count;
  final List<Restaurants> restaurants;

  RestaurantsModel({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantsModel.fromJson(Map<String, dynamic> json) =>
      RestaurantsModel(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurants>.from((json["restaurants"] as List)
            .map((x) => Restaurants.fromJson(x))
            .where((restaurant) =>
                restaurant.id != null &&
                restaurant.name != null &&
                restaurant.description != null &&
                restaurant.pictureId != null &&
                restaurant.city != null &&
                restaurant.rating != null)),
        // restaurants: List<Restaurant>.from(
        //     json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );
}

class Restaurants {
  final String? id;
  final String? name;
  final String? description;
  final String? pictureId;
  final String? city;
  final double? rating;

  Restaurants({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurants.fromJson(Map<String, dynamic> json) => Restaurants(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );
}
