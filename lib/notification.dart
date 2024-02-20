// ignore_for_file: empty_constructor_bodies

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shopping_cart_app/model/products_model.dart';

class Notifications {
  Future<FlutterLocalNotificationsPlugin?> manInit() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (_) {});

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
    return flutterLocalNotificationsPlugin;
  }

  Future<void> display({required String? label, Products? product}) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'cart',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    var man = await manInit();
    await man!.show(0, '$label added to cart',
        product?.description ?? 'no description provided', notificationDetails,
        payload: 'item x');
  }
}
