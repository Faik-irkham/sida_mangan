import 'package:flutter/material.dart';
import 'package:sida_mangan/common/style.dart';
import 'package:sida_mangan/data/model/restaurant.dart';
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
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: myTextTheme.headlineSmall,
                ),
                const SizedBox(height: 10),
                MyRatingBar(
                  nilaiRating: restaurant.rating,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // DefaultTabController(
          //   length: 3,
          //   child: Column(
          //     children: [
          //       TabBar(
          //         labelColor: Colors.black,
          //         tabs: [
          //           Tab(
          //             child: Text(
          //               'Info',
          //               style: myTextTheme.bodyMedium,
          //             ),
          //           ),
          //           Tab(
          //             child: Text(
          //               'Foods',
          //               style: myTextTheme.bodyMedium,
          //             ),
          //           ),
          //           Tab(
          //             child: Text(
          //               'Drinks',
          //               style: myTextTheme.bodyMedium,
          //             ),
          //           ),
          //         ],
          //       ),
          //       const Expanded(
          //           child: TabBarView(
          //         children: [
          //           // Tab Restoran
          //           RestaurantInfoTab(),

          //           // Tab Makanan
          //           FoodTab(),

          //           // Tab Minuman
          //           DrinkTab(),
          //         ],
          //       ))
          //     ],
          //   ),
          // ),
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                  labelColor: Colors.black,
                  tabs: [
                    Tab(
                      child: Text(
                        'Info',
                        style: myTextTheme.bodyMedium,
                      ),
                    ),
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

class RestaurantInfoTab extends StatelessWidget {
  const RestaurantInfoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Informasi Restoran'),
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
