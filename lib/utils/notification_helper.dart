import 'dart:convert';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:sida_mangan/common/navigation.dart';
import 'package:sida_mangan/data/model/restaurant_model.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotfications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        final payload = details.payload;
        if (payload != null) {
          // ignore: avoid_print
          print('notification payload: $payload');
        }
        selectNotificationSubject.add(payload ?? 'empty payload');
      },
    );
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantsModel restaurants) async {
    var channelId = "1";
    var channelName = "channel_01";
    var channelDescription = "Recomendation Restaurant channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId, channelName,
        channelDescription: channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    var titleNotification = "<b>Recomendation Restaurants</b>";
    // var randomIndex = random.nextInt(restaurants.restaurants.length);
    var randomRestaurant = Random().nextInt(restaurants.count);
    var titleRestaurant = restaurants.restaurants[randomRestaurant];

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleRestaurant.name, platformChannelSpecifics,
        payload: json.encode(restaurants.toJson()));
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = RestaurantsModel.fromJson(json.decode(payload));
        var restaurantRandom = Random().nextInt(data.count);
        var restaurant = data.restaurants[restaurantRandom];
        Navigation.intentWithData(route, restaurant.id!);
      },
    );
  }
}
