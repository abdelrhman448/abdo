import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:http/http.dart' as http;

import '../model/notification_model.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationProvider() {
    fcmListeners();
  }
  FirebaseMessaging _fcm = FirebaseMessaging.instance;

  String _deviceToken;

  String get getDeviceToken => _deviceToken;

  List<NotificationsModel> get getNotifications => notificationsList;

  int get getCounters => _calculateNotifications;
  int _calculateNotifications = 0;

  calculateNotifications() {
    _calculateNotifications = notificationsList.length;
    notifyListeners();
  }

  List<NotificationsModel> notificationsList = [
    NotificationsModel(
      type: 1,
      title: "المندوب في طريقة اليك الان",
      body: 'منذ 8 دقائق',
    ),
    NotificationsModel(
      type: 2,
      title: "سوف يصلك بعد دقيقه من الأن",
      body: 'منذ 3 دقائق',
    ),
    NotificationsModel(
      type: 3,
      title: "لقد وصلك المندوب الان",
      body: 'منذ 1 دقائق',
    ),
  ];


  ///FCM Listeners and get Device Token
  void fcmListeners()async {
    Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
      await Firebase.initializeApp();
      print('Handling a background message ${message.messageId}');
    }
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      sound: false,
      badge: false,
      alert: false,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


    if (Platform.isIOS) iOSPermission();
    _fcm.getToken().then((deviceToken) {
      _deviceToken = deviceToken;
    });

    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }


    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(' onMessage Got a message whilst in the foreground!');
      print('all data is : ${message.data}');
      print('title  is : ${message.notification.title}');

      if (message.notification != null) {
        print('onMessage body${message.notification.body}');
        FlutterRingtonePlayer.play(
          android: AndroidSounds.notification,
          ios: IosSounds.glass,
          looping: false,
          volume: 10,
          asAlarm: false,
        );
        print('\t\#####t\t on message \t#####\t\t$message');
        notificationsList.add(NotificationsModel(
          type: 1,
          title: message.notification.title,
          body: message.notification.body,
        ));
        calculateNotifications();
        notifyListeners();

      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(' onMessageOpenedApp Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        FlutterRingtonePlayer.play(
          android: AndroidSounds.notification,
          ios: IosSounds.glass,
          looping: false,
          volume: 10,
          asAlarm: false,
        );
        print('\t\t#####\ton resume \t#####\t\t$message');
        notificationsList.add(NotificationsModel(
          type: 1,
          title: message.notification.title,
          body: message.notification.body,
        ));
        calculateNotifications();
        notifyListeners();
      }
    });


    FirebaseMessaging.onBackgroundMessage((message) {
      print('onLaunch data is${message.data}');
      print('onLaunch body${message.notification.body}');
      FlutterRingtonePlayer.play(
        android: AndroidSounds.notification,
        ios: IosSounds.glass,
        looping: false,
        volume: 10,
        asAlarm: false,
      );
      print('\t\t#####\ton launch \t#####\t\t$message');
      notificationsList.add(NotificationsModel(
        type: 1,
        title: message.notification.title,
        body: message.notification.body,
      ));
      calculateNotifications();
      notifyListeners();
      return ;
    });



    notifyListeners();
  }

  ///Get IOS Permission
  void iOSPermission()async {
    await _fcm.setForegroundNotificationPresentationOptions(
      sound: true,
      badge: true,
      alert: true,
    );
    notifyListeners();
  }

  ///Send Notification Tester
  void notification() async {
    print("######## Send And Retrieve Message #########");
    var res = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAA_LKuZdI:APA91bFBAOn_B8F04yhBXfRu9ovKZIJfB2VwvJPs-eaRobgmZvOdz9Wzbi9AUbSB9glpYJeGiA9wfgEXL7ckxaBvFZ0R-wCG3GKSFstCUMF1gldWhXna55WDutShCybA8nn_kXtOufvF',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'this is a body',
            'title': 'this is a title'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': await _fcm.getToken(),
        },
      ),
    );
    print(res.body);
    notifyListeners();
  }
}
