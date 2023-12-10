import 'package:flutter/material.dart';
import 'package:sida_mangan/common/style.dart';
import 'package:sida_mangan/data/model/restaurant.dart';
import 'package:sida_mangan/ui/detail_restaurant_page.dart';
import 'package:sida_mangan/ui/home_page.dart';
import 'package:sida_mangan/ui/splash_screen.dart';

void main() {
  runApp(const MyApp());
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
            backgroundColor: Colors.amber,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomePage.routeName: (context) => const HomePage(),
        DetailRestaurant.routeName: (context) => DetailRestaurant(
              restaurant:
                  ModalRoute.of(context)!.settings.arguments as Restaurant,
            ),
      },
    );
  }
}
