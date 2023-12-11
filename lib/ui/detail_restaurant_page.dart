import 'package:flutter/material.dart';
import 'package:sida_mangan/common/style.dart';
import 'package:sida_mangan/data/model/restaurant.dart';
import 'package:sida_mangan/widgets/text_deskripsi.dart';
import 'package:sida_mangan/widgets/ratings_bar.dart';

class DetailRestaurant extends StatelessWidget {
  static const routeName = '/detail_restaurant';

  final Restaurant restaurant;
  const DetailRestaurant({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   iconTheme: const IconThemeData(
      //     color: Colors.black,
      //   ),
      // ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Hero(
            tag: restaurant.id,
            child: Container(
              padding: const EdgeInsets.only(left: 15, bottom: 15),
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    restaurant.pictureId,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: myTextTheme.bodyLarge,
                    ),
                    const SizedBox(height: 10),
                    MyRatingBar(
                      nilaiRating: restaurant.rating,
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  // height: 30,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    restaurant.city,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ReadMoreText(
              text: restaurant.description,
              maxLength: 120,
            ),
          ),
          const SizedBox(height: 20),
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicatorPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  indicator: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  tabs: [
                    Tab(
                      child: Text(
                        'Foods',
                        style: myTextTheme.bodyMedium,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Drinks',
                        style: myTextTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FoodTab extends StatelessWidget {
  const FoodTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Menu Makanan'),
    );
  }
}

class DrinkTab extends StatelessWidget {
  const DrinkTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Menu Minuman'),
    );
  }
}
