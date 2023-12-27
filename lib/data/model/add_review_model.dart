class AddReviewModel {
  final String id;
  final String name;
  final String review;

  AddReviewModel({
    required this.id,
    required this.name,
    required this.review,
  });

  factory AddReviewModel.fromJson(Map<String, dynamic> json) => AddReviewModel(
        id: json["id"],
        name: json["name"],
        review: json["review"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "review": review,
      };

  AddReviewModel copyWith({
    String? id,
    String? name,
    String? review,
  }) =>
      AddReviewModel(
        id: id ?? this.id,
        name: name ?? this.name,
        review: review ?? this.review,
      );
}
