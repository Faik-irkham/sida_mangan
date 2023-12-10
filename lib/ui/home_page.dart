import 'package:flutter/material.dart';
import 'package:sida_mangan/data/model/restaurant.dart';
import 'package:sida_mangan/ui/detail_restaurant_page.dart';

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
        children: [
          const SizedBox(height: 40),
          const Text('Rekomendasi Restaurant'),
          const SizedBox(height: 8),
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              onChanged: (value) {},
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                labelText: 'Search',
                suffixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(child: _buildList(context)),
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
          color: Colors.amber,
          child: Column(
            children: [
              Hero(
                tag: restaurant.id,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(restaurant.pictureId),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    restaurant.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(restaurant.rating.toString()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
