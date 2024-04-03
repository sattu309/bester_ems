import 'package:ecom_demo/push_notification/notifcation_service.dart';
import 'package:ecom_demo/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'conttroller/alert_handle_controller.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.instance.requestPermission(
    sound: true,
    alert: true,
    announcement: true,
    criticalAlert: true,
    carPlay: true,
  );
  getFcmToken();
  messageHandler();
   NotificationService().initializeNotification();
   NotificationService.initializeFirebaseMessaging();
  await NotificationService().createNotificationChannel();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      darkTheme: ThemeData.light(),
      defaultTransition: Transition.rightToLeft,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData(
        useMaterial3: false,
        fontFamily: 'Poppins',
        bottomAppBarTheme: const BottomAppBarTheme(color: Colors.transparent, elevation: 0),
        //primaryColor: AppTheme.primaryColor,
        scaffoldBackgroundColor: const Color(0xffF6F6F6),
        // highlightColor: AppTheme.primaryColor,
      ),
      themeMode: ThemeMode.light,
    );
  }
}
getFcmToken() async {
  final userTypeController = Get.put(AlertHandleController());
  userTypeController.getUserType();
  var fcmToekn = await FirebaseMessaging.instance.getToken();
  print("FCM TOEKN IS $fcmToekn");
  AndroidNotificationDetails androidNotificationDetails =
  const AndroidNotificationDetails(
    "demo_22",
    "demo_app",
    priority: Priority.high,
    playSound: true,
    sound: RawResourceAndroidNotificationSound('ring'), // Default sound
    importance: Importance.max,
  );
  NotificationDetails(android: androidNotificationDetails);

}
Future<void> messageHandler() async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    NotificationService.showNotification(event);
  });

}