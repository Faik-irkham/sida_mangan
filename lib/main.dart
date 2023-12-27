import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sida_mangan/common/style.dart';
import 'package:sida_mangan/data/api/api_service.dart';
import 'package:sida_mangan/provider/restaurants_provider.dart';
import 'package:sida_mangan/provider/review_restaurant_provider.dart';
import 'package:sida_mangan/provider/search_restaurant_provider.dart';
import 'package:sida_mangan/ui/home_page.dart';
import 'package:sida_mangan/ui/onboarding_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ReviewProviders(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchRestaurantsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantsProvider(apiService: ApiService()),
        ),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant',
      theme: ThemeData(
        textTheme: myTextTheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
        ),
      ),
      initialRoute: OnBoardingScreen.routeName,
      routes: {
        OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
        HomePage.routeName: (context) => const HomePage(),
      },
    );
  }
}
