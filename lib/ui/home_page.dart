import 'package:flutter/material.dart';
import 'package:sida_mangan/common/style.dart';
import 'package:sida_mangan/data/model/restaurant.dart';
import 'package:sida_mangan/ui/detail_restaurant_page.dart';
import 'package:sida_mangan/widgets/ratings_bar.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi! Welcome to',
                  style: myTextTheme.titleMedium,
                ),
                Text(
                  'Restaurant App',
                  style: myTextTheme.headlineSmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Recomended For You',
              style: myTextTheme.bodyLarge,
            ),
          ),
          Expanded(
            child: _buildList(context),
          ),
        ],
      ),
    );
  }

  Future<List<Restaurant>> _loadRestaurantData() async {
    try {
      final jsonString = await DefaultAssetBundle.of(context)
          .loadString('assets/local_restaurant.json');
      return parseRestaurant(jsonString);
    } catch (e) {
      return [];
    }
  }

  FutureBuilder<List<Restaurant>> _buildList(BuildContext context) {
    return FutureBuilder<List<Restaurant>>(
      future: _loadRestaurantData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
          );
        } else {
          final List<Restaurant> restaurants = snapshot.data!;
          if (restaurants.isEmpty) {
            return const Center(
              child: Text(
                'Tidak ada data!',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                return _builRestaurantItem(context, restaurants[index]);
              },
            );
          }
        }
      },
    );
  }

  Widget _builRestaurantItem(BuildContext context, Restaurant restaurant) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            DetailRestaurant.routeName,
            arguments: restaurant,
          );
        },
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
                tag: restaurant.id,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(restaurant.pictureId),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  MyRatingBar(nilaiRating: restaurant.rating),
                  Text(
                    restaurant.city,
                    style: myTextTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
