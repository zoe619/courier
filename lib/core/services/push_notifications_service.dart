import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:tcourier/modules/landing_screen.dart';

class PushNotificationService {
  // PushNotificationService();

  Future initialise() async {
    if (Platform.isIOS || Platform.isAndroid) {
      FirebaseMessaging.instance.requestPermission();
    }

    FirebaseMessaging.onMessage.listen((event) {
      print('onMessage: $event');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('onLaunch: $event');
      serialiseAndNavigate(event.data);
    });

    // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
}

void serialiseAndNavigate(Map<String, dynamic> message) {
  var notificationData = message['data'];
  var view = notificationData['topic'];
  if (view != null) {
    //This checks what the FCM data contains, then Navigate to the respective view
    if (view == 'Courier') {
      Get.to(() => LandingScreen());
    }
  } else if (view == 'VIDEO_FAILED') {
    Get.to(() => LandingScreen());
  } else if (view == 'VIDEO_CREATED') {}
  Get.to(() => LandingScreen());
}
