import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../conttroller/alert_handle_controller.dart';
import '../custom_bottom_bar.dart';

class NotificationService {
  final alertHandlerController = Get.put(AlertHandleController());
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings =
  const AndroidInitializationSettings("@mipmap/ic_launcher", );
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  DarwinInitializationSettings darwinInitializationSettings = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestSoundPermission: true,
      requestBadgePermission: true,
      defaultPresentSound: true,
      defaultPresentAlert: true,
      defaultPresentBadge: true);

  static Future<void> initializeFirebaseMessaging() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,

    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission for notifications');
    } else {
      print('User declined or has not accepted permission for notifications');
    }

    // Configure Firebase Messaging background handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
  }

  initializeNotification() async {
    InitializationSettings initializationSettings =
    InitializationSettings(android: androidInitializationSettings, iOS: darwinInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        if (response.payload != null) {
          print(response.payload.toString());
          // Map<dynamic, dynamic> map = jsonDecode(response.payload.toString());
        }
      },
    ).catchError((e) {
      throw Exception(e);
    });
  }
   Future<void> createNotificationChannel() async {
    AndroidNotificationChannel channel =     const AndroidNotificationChannel(
      'channel_id_2', // Replace with your channel ID
      'Custom_channel', // Replace with your channel name
      description: 'Custom Channel Description', // Replace with your channel description
      importance: Importance.max,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('ring'),
      // RawResourceAndroidNotificationSound('ring'),
      // alertHandlerController.userType.value == "1" ?
      //         const RawResourceAndroidNotificationSound("ring"):null,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  showNotificationWithPayLoad({
    required title,
    required body,
    required payload,
  }) async {

    AndroidNotificationDetails androidNotificationDetails =
       const AndroidNotificationDetails(
      "demo_100sss",
      "demo_app",
      channelDescription: "This is custom sound msg",
      priority: Priority.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('ring'),
      // RawResourceAndroidNotificationSound('ring'),
      importance: Importance.max,
    );

    NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails,);
    flutterLocalNotificationsPlugin
        .show(
      int.parse(DateTime.now()
          .millisecondsSinceEpoch
          .toString()
          .substring(DateTime.now().millisecondsSinceEpoch.toString().length - 5)),
      title,
      body,
      notificationDetails,
      payload: payload,
    )
        .catchError((e) {
      throw Exception(e);
    });

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }



   Future<void> showNotification(
     RemoteMessage message
      ) async {
    final userDataController = Get.put(AlertHandleController());
    userDataController.getUserType();
    String sound = message.data['sound'] ?? 'default';
    String soundFileName = sound.isNotEmpty ? sound : 'default';
     log("SOUND FROM PAYLOAD $sound");
     AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
      'custom_channel_id', // Same channel ID as created above
      'Custom Channel', // Same channel name as created above
      channelDescription: 'Custom Channel Description', // Same channel description as created above
      importance: Importance.max,
      playSound: true,
      priority: Priority.high,
      sound: userDataController.userType.value == "0" ? const RawResourceAndroidNotificationSound('ring'):null,
      //sound: ((sound!='default' || sound!='Default') ? RawResourceAndroidNotificationSound(message.data['sound']): null),
    );
     NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? 'Title',
      message.notification?.body ?? 'Body',
      platformChannelSpecifics,
      payload: message.data.toString(),

    );
  }
}
