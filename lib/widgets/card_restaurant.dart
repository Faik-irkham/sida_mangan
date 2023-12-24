import 'package:flutter/material.dart';
import 'package:sida_mangan/common/constant.dart';
import 'package:sida_mangan/common/style.dart';
import 'package:sida_mangan/data/model/restaurant.dart';
import 'package:sida_mangan/widgets/ratings_bar.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurants restaurant;
  const CardRestaurant({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
              offset: Offset(0, 5.0),
            ),
          ],
        ),
        child: Row(
          children: [
            Hero(
              tag: restaurant.id!,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imageUrl + restaurant.pictureId!),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                MyRatingBar(nilaiRating: restaurant.rating!),
                Text(
                  restaurant.city!,
                  style: myTextTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
