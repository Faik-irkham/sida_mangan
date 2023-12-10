import 'package:flutter/material.dart';
import 'package:sida_mangan/data/model/restaurant.dart';

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
        // padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15, bottom: 15),
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  restaurant.pictureId,
                ),
              ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                color: Colors.amber,
                height: 20,
                child: Text(
                  restaurant.name,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.grey,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('Ratings'),
                    Text(restaurant.rating.toString()),
                  ],
                ),
                Column(
                  children: [
                    Text('Tipe'),
                    Text(restaurant.rating.toString()),
                  ],
                ),
                Column(
                  children: [
                    Text('Lokasi'),
                    Text(restaurant.city),
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
