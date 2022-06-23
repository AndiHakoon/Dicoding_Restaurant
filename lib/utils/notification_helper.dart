import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant2/commons/navigation.dart';
import 'package:restaurant2/data/model/restaurant.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  factory NotificationHelper() {
    return _instance ?? NotificationHelper._internal();
  }

  NotificationHelper._internal() {
    _instance = this;
  }

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingIOS = const IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSetting = InitializationSettings(
      android: initializationSettingAndroid,
      iOS: initializationSettingIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        if (kDebugMode) {
          print('notification payload: $payload');
        }
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantResult restaurant) async {
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "Dicoding Restaurant Channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName,
        channelDescription: _channelDescription,
        importance: Importance.max,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    var titleNotification = "<b>Best Restaurant for You</b>";
    var random = Random();
    var position = random.nextInt(restaurant.restaurants.length);
    var titleRestaurant = restaurant.restaurants[position].name;

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      titleRestaurant,
      platformChannelSpecifics,
      payload: json.encode(restaurant.restaurants[position].toJson()),
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen((payload) async {
      var data = RestaurantResult.fromJson(json.decode(payload));
      var restaurant = data.restaurants[0];
      Navigation.intentWithData(route, restaurant);
    });
  }
}
