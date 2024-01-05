import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:sida_mangan/common/navigation.dart';
import 'package:sida_mangan/common/style.dart';
import 'package:sida_mangan/data/api/api_service.dart';
import 'package:sida_mangan/data/db/database_helper.dart';
import 'package:sida_mangan/provider/database_provider.dart';
import 'package:sida_mangan/provider/restaurants_provider.dart';
import 'package:sida_mangan/provider/review_restaurant_provider.dart';
import 'package:sida_mangan/provider/search_restaurant_provider.dart';
import 'package:sida_mangan/ui/detail_restaurant_page.dart';
import 'package:sida_mangan/ui/home_page.dart';
import 'package:sida_mangan/ui/onboarding_screen.dart';
import 'package:sida_mangan/utils/background_service.dart';
import 'package:sida_mangan/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  await notificationHelper.initNotfications(flutterLocalNotificationsPlugin);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RestaurantsProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (context) => ReviewProviders(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchRestaurantsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
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
      navigatorKey: navigatorKey,
      theme: ThemeData(
        textTheme: myTextTheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
      home: const OnBoardingScreen(),
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        DetailRestaurant.routeName: (context) => DetailRestaurant(
              id: ModalRoute.of(context)?.settings.arguments as String,
            )
      },
    );
  }
}
