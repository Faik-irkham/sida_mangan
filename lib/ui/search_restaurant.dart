import 'package:flutter/material.dart';
import 'package:sida_mangan/common/style.dart';

class SearchRestaurantPage extends StatelessWidget {
  const SearchRestaurantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 40),
          Text(
            'Search',
            style: myTextTheme.headlineMedium,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 50,
            child: TextFormField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.amber,
                  ),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
