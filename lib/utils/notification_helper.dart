import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant2/data/model/restaurant.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper{
  static NotificationHelper? _instance;

  factory NotificationHelper() {
    return _instance ?? NotificationHelper._internal();
  }

    NotificationHelper._internal(){
      _instance = this;
    }

    Future<void> initNotifications(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin)
    async {
      var initializationSettingAndroid = const AndroidInitializationSettings('app_icon');

      var initializationSettingIOS = const IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      );

      var initializationSetting = InitializationSettings(
        android: initializationSettingAndroid,
        iOS : initializationSettingIOS,
      );

      await flutterLocalNotificationsPlugin.initialize(
        initializationSetting,
          onSelectNotification: (String? payload) async{
            if (payload != null){
              print('notification payload: $payload');
            }
            selectNotificationSubject.add(payload ?? 'empty payload');
          }
      );
    }

    Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantResult restaurant)async{
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "Dicoding Restaurant Channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription,
      importance: Importance.max,
      ticker: 'ticker',
      styleInformation: const DefaultStyleInformation(true, true)
    );

    var  iOSPlatformChannelSpecifics = const IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    var titleNotification = "<b>Best Restaurant for You</b>";
    var titleRestaurnt = restaurant.restaurants[0].name ;

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      titleRestaurnt,
      platformChannelSpecifics,
      payload: json.encode(restaurants.toJson()),
    );
    }
}