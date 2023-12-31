import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sida_mangan/common/navigation.dart';
import 'package:sida_mangan/common/style.dart';
import 'package:sida_mangan/provider/restaurants_provider.dart';
import 'package:sida_mangan/ui/detail_restaurant_page.dart';
import 'package:sida_mangan/ui/search_restaurant_page.dart';
import 'package:sida_mangan/utils/result_state.dart';
import 'package:sida_mangan/widgets/card_restaurant.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
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
                IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchRestaurantPage(),
                    ),
                  ),
                  icon: const Icon(Icons.search),
                  iconSize: 24,
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildList(),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    return Consumer<RestaurantsProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return GestureDetector(
                onTap: () => Navigation.intentWithData(
                  DetailRestaurant.routeName,
                  restaurant.id!,
                ),
                child: CardRestaurant(restaurant: restaurant),
              );
            },
          );
        } else if (state.state == ResultState.noData) {
          return const Center(
            child: Material(
              child: Text('Tidak ada Data!'),
            ),
          );
        } else if (state.state == ResultState.error) {
          return const Center(
            child: Material(
              child: Text('Tidak ada koneksi Internet!'),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text(''),
            ),
          );
        }
      },
    );
  }
}
