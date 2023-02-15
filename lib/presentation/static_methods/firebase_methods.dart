import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseStaticMethods {
  static void requestNotificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user granted permission");
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print("user granted provisional permission");
    } else {
      print("user declined or has not accepted permission provisional permission");
    }
  }

  static Future<String?> getToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print("firebase token $token");
    if (token != null) {
      saveToken(token);
    }
    return token;
  }

  static void saveToken(String token) async {
    await FirebaseFirestore.instance.collection("UserTokens").doc("User1").set({
      'token': token,
    });
    print("token $token saved to FirebaseFirestore");
  }
}
