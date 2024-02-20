// ignore_for_file: empty_constructor_bodies

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shopping_cart_app/screens/cart_screen.dart';

class CartNotification{
  var flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();

   static Future<void> showNotification(String title) async {
    var flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
    var android = const AndroidNotificationDetails('0', 'cart');
    var platform =  NotificationDetails(android: android);
    await flutterLocalNotificationsPlugin.show(
      0, 'New Notification', '$title added to cart successfully', platform,payload: 'test notification');
  }

  static void onSelectNotification(NotificationResponse notificationResponse)
     {
      BuildContext? ct;
      String? payload=notificationResponse.payload;
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
      Navigator.push(ct!, MaterialPageRoute(builder: 
      (ct){
        return const CartScreen();
      }
      ));
    }
}

 static void init()  {

    var flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();

    //Initialization Settings for Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    //InitializationSettings for initializing settings for both platforms (Android & iOS)
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            );

     flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onSelectNotification
      
    );
 }

}