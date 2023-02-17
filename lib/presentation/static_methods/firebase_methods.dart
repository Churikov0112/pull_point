import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../home/home_page.dart' as home;

class FirebaseStaticMethods {
  static Future<void> requestNotificationPermission() async {
    final messaging = FirebaseMessaging.instance;

    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('Permission granted: ${settings.authorizationStatus}');
  }

  static Future<String?> getToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print("firebase token $token");
    // if (token != null) {
    //   await saveToken(token);
    // }
    return token;
  }

  static Future<void> saveToken(String token) async {
    await FirebaseFirestore.instance.collection("UserTokens").doc("Egor").set({
      'token': token,
    });
    print("token $token saved to FirebaseFirestore");
  }

  static initInfo() {
    var androidInitialize = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(android: androidInitialize);
    home.flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        print(response.notificationResponseType);
      },
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("-----------------------------on message------------------------------");
      print("onMessage: ${message..notification?.title}/${message.notification?.body}");

      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification?.body ?? "null",
        htmlFormatBigText: true,
        contentTitle: message.notification?.title ?? "null",
        htmlFormatContentTitle: true,
      );

      AndroidNotificationDetails adnroidPlatformChanelSpecifics = AndroidNotificationDetails(
        'dbfood',
        'dbfood',
        importance: Importance.high,
        styleInformation: bigTextStyleInformation,
        priority: Priority.high,
        playSound: true,
      );

      NotificationDetails platformChanelSpecifics = NotificationDetails(android: adnroidPlatformChanelSpecifics);

      await home.flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title,
        message.notification?.body,
        platformChanelSpecifics,
        payload: message.data['body'],
      );
    });
  }

  static Future<void> sendNotification(
    String token,
    String title,
    String body,
  ) async {
    const serverKey =
        "AAAALwu6y-Y:APA91bFiR8u8lENhGKWg0c3-QMkK1kEcpbwKvVQH_eMC-y_nNnpNAji_j55Lw482eLrq72Z2Gjr-YCx6uXsTzmpwj0obuCMxPTo_kS_nIi-bI1yRtR9zCbpglXy4giu8ZsjdUutl4MSP";
    await http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "key=$serverKey",
      },
      body: jsonEncode(
        <String, dynamic>{
          "priority": "high",
          "data": <String, dynamic>{
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
            "status": "done",
            "body": body,
            "title": title,
          },
          "notification": <String, dynamic>{
            "title": title,
            "body": body,
            "android_channel_id": "dbfood",
          },
          "to": token,
        },
      ),
    );
  }
}
