import 'dart:io';
import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tcourier/generated/l10n.dart';
import 'package:tcourier/utils/constants.dart';
import 'modules/onboarding/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AwesomeNotifications().initialize(
    'resource://drawable/mytcon.png',
    [
      // Your notification channels go here
      NotificationChannel(
        // playSound: true,
        importance: NotificationImportance.Max,
        icon: 'resource://drawable/mytcon.png',
        // soundSource: 'resource://res_morph_power_rangers.m4a',
        defaultRingtoneType: DefaultRingtoneType.Alarm,
        channelKey: 'high_intensity',
        channelName: 'High intensity notifications',
        channelDescription: 'Notification channel for notifications with high intensity',
        defaultColor: Colors.red,
        ledColor: Colors.red,
        enableLights: true,
        enableVibration: true,
        vibrationPattern: highVibrationPattern,
      ),
    ],
  );
  runApp(MyApp());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  void initFirebase() async {
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();
    initFirebase();
    // _initialization = Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: redColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    // return FutureBuilder<Object>(
    //   future: _initialization,
    //   // ignore: missing_return
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done) {
    return GetMaterialApp(
      defaultTransition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 500),
      title: 'Tcourier',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'popmedium',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      localizationsDelegates: [
        L10n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate, // Needed for iOS!
      ],
    );
    //     }
    //     return Container();
    //   },
    // );
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  AwesomeNotifications().createNotification(
      content: NotificationContent(
    icon: "asset://assets/img/myTcon.png",
    id: Random().nextInt(2147483647),
    channelKey: 'high_intensity',
    title: message.notification.title,
    body: message.notification.body,
  ));
  AwesomeNotifications().actionStream.listen((receivedNotification) {
    // serialiseAndNavigate(message.data);
  });
}
// void callBack(String tag) {
//   print(tag);
//   if (tag == "reject_button") {
//     CourierOrderService().rejectOrder(123);
//   } else if (tag == "accept_button") {
//     CourierOrderService().acceptOrder(123);
//   } else {
//     print(checkToken);
//     SystemAlertWindow.closeSystemWindow();
//   }
// }

// SystemAlertWindow.registerOnClickListener(callBack);
// if (isUserOnline == false) {
//   SystemAlertWindow.showSystemWindow(
//       height: 230,
//       header: uiHeader,
//       body: uiBody,
//       // footer: uiFooter,
//       margin: SystemWindowMargin(left: 8, right: 8, top: 200, bottom: 0),
//       gravity: SystemWindowGravity.TOP,
//       notificationTitle: "New Order",
//       notificationBody: "You have a new order",
//       prefMode: SystemWindowPrefMode.DEFAULT);
// } else {
//   print("not online so no notify");
// }

// String _platformVersion = 'Unknown';
// @override
// void initState() {
//   super.initState();
//   // _initPlatformState();
//   // _requestPermissions();
//   // SystemAlertWindow.registerOnClickListener(callBack);
// }

// Future<void> _requestPermissions() async {
//   await SystemAlertWindow.requestPermissions;
// }

// Future<void> _initPlatformState() async {
//   String platformVersion;
//   // Platform messages may fail, so we use a try/catch PlatformException.
//   // try {
//   //   platformVersion = await SystemAlertWindow.platformVersion;
//   // } on PlatformException {
//   //   platformVersion = 'Failed to get platform version.';
//   // }
//   // If the widget was removed from the tree while the asynchronous platform
//   // message was in flight, we want to discard the reply rather than calling
//   // setState to update our non-existent appearance.
//   if (!mounted) return;
//   setState(() {
//     _platformVersion = platformVersion;
//   });
//   print(_platformVersion);
// }

///this is to print hello when app is in background
// void printHello() {
//   final DateTime now = new DateTime.now();
//   final int isolateId = Isolate.current.hashCode;
//   print("===========================........................");
//   print("[$now] Hello, world! isolate=$isolateId function='$printHello'");
//   print("===========================........................");
// }

// await AndroidAlarmManager.initialize();
// final int helloAlarmID = 0;

// await AndroidAlarmManager.periodic(const Duration(seconds: 10), helloAlarmID, printHello);
