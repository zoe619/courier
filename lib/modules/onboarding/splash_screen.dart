import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:tcourier/core/services/locator_service.dart';
import 'package:tcourier/core/services/push_notifications_service.dart';
import 'package:tcourier/main.dart';
import 'package:tcourier/modules/check_if_approved.dart';
import 'package:tcourier/utils/constants.dart';
import 'package:location_permissions/location_permissions.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

var checkToken;

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  // Future<String> getCountryName() async {
  //   Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) async {
  //     print('location: ${value.latitude}');
  //     final coordinates = new Coordinates(value.latitude, value.longitude);
  //     var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  //     var first = addresses.first;
  //     countrySplashCode = first.countryCode;
  //   });

  //   // this will return country name
  // }
  Future requestPermission() async {
    await LocationPermissions().requestPermissions();
    // PermissionStatus permission = await LocationPermissions().requestPermissions().then((value) {

    // });
  }

  initialize() async {
    final PushNotificationService _pushNotificationService = locator<PushNotificationService>();
    await _pushNotificationService.initialise();
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  @override
  void initState() {
    super.initState();
    requestPermission();
    // setUpLocatorServices();
    // initialize();

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    Future.delayed(Duration(seconds: 1), () {
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) async {
        print('location: ${value.latitude}');
        final coordinates = new Coordinates(value.latitude, value.longitude);
        var addresses =
            await Geocoder.local.findAddressesFromCoordinates(coordinates).then((value) {
          countrySplashCode = value.first.countryCode;
        });
        print(addresses + " " + countrySplashCode);
        // var first = addresses.first;
        // countrySplashCode = first.countryCode;
      });
    });
    animationController =
        AnimationController(duration: const Duration(milliseconds: 500), vsync: this, value: 0.1);
    animation = CurvedAnimation(parent: animationController, curve: Curves.elasticInOut);
    animationController.forward();
    getToken();
    Future.delayed(
      Duration(seconds: 3),
      () {
        checkForToken();
      },
    );
  }

  getToken() async {
    checkToken = await storage.read(key: "token");
  }

  checkForToken() {
    print("check ========>>>>>> $checkToken");
    if (checkToken == null) {
      // getCountryName().then((value) {
      // countrySplashCode = value;
      Get.off(() => LoginScreen());
      // });
    } else {
      Get.off(() => CheckIfApproved());
    }
  }

  @override
  dispose() {
    animationController.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showDialog<bool>(
        context: context,
        builder: (c) => CupertinoAlertDialog(
          title: Text('Prompt!'),
          content: Text('Do you really want to exit?'),
          actions: [
            ElevatedButton(
              child: Text('Yes'),
              onPressed: () => Navigator.pop(c, true),
            ),
            ElevatedButton(
              child: Text('No'),
              onPressed: () => Navigator.pop(c, false),
            ),
          ],
        ),
      ),
      child: new Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  child: new Image.asset(
                    // 'assets/img/T (3)/1.png',
                    'assets/img/myTcon.png',
                    fit: BoxFit.cover,
                  ),
                ),
                // SizedBox(width: 5),
                // Text(
                //   "couriers",
                //   style: GoogleFonts.montserrat(
                //     color: Colors.black,
                //     fontWeight: FontWeight.bold,
                //     fontSize: 20,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }
}
