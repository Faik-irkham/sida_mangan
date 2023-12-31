import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sida_mangan/provider/database_provider.dart';
import 'package:sida_mangan/ui/detail_restaurant_page.dart';
import 'package:sida_mangan/utils/result_state.dart';
import 'package:sida_mangan/widgets/card_favorite.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Restaurant'),
        leading: Container(),
      ),
      body: _buildList(),
      // body: _buildList(),
    );
  }

  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailRestaurant(
                        id: provider.favorites[index].id,
                      ),
                    ),
                  );
                },
                child: CardFavorite(
                  restaurant: provider.favorites[index],
                ),
              );
            },
          );
        } else {
          return Center(
            child: Material(
              child: Text(provider.message),
            ),
          );
        }
      },
    );
  }
}
