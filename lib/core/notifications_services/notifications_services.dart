// import 'dart:convert';
// import 'dart:developer';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   log('🔙 [Background Message] ${message.messageId}');
// }

// class FirebaseApi {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _localNotifications =
//       FlutterLocalNotificationsPlugin();

//   final AndroidNotificationChannel _androidChannel =
//       const AndroidNotificationChannel(
//     'high_importance_channel',
//     'High Importance Notifications',
//     description: 'Used for important notifications',
//     importance: Importance.max,
//   );

//   Future<void> initNotifications() async {
//     await _requestPermission();
//     await _initLocalNotifications();
//     await _initFirebaseMessaging();
//   }

//   Future<void> _requestPermission() async {
//     NotificationSettings settings = await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     log('🔔 Notification permission status: ${settings.authorizationStatus}');
//   }

//   Future<void> _initLocalNotifications() async {
//     const initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     const initializationSettingsIOS = DarwinInitializationSettings();
//     const initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );

//     await _localNotifications.initialize(initializationSettings,
//         onDidReceiveNotificationResponse: (details) {
//       log('📱 Notification clicked with payload: ${details.payload}');
//     });

//     await _localNotifications
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(_androidChannel);
//   }

//   Future<void> _initFirebaseMessaging() async {
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       log('📩 [Foreground] Message received: ${message.notification?.title}');
//       _showLocalNotification(message);
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       log('📥 [onMessageOpenedApp] User tapped on notification: ${message.data}');
//     });

//     final token = await _firebaseMessaging.getToken();
//     log("📲 FCM Token: $token");
//   }

//   void _showLocalNotification(RemoteMessage message) {
//     final notification = message.notification;
//     final android = notification?.android;

//     if (notification != null && android != null) {
//       _localNotifications.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             _androidChannel.id,
//             _androidChannel.name,
//             channelDescription: _androidChannel.description,
//             icon: '@mipmap/ic_launcher',
//             importance: Importance.max,
//             priority: Priority.high,
//           ),
//         ),
//         payload: jsonEncode(message.data),
//       );
//     }
//   }
// }
