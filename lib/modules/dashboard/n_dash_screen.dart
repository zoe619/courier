import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slider_button/slider_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tcourier/core/api/appConstant.dart';
import 'package:tcourier/core/api/appperferance.dart';
import 'package:tcourier/core/services/auth_service.dart';
// import 'package:tcourier/core/services/courier_order_service.dart';
import 'package:tcourier/core/services/courier_visibility_service.dart';
import 'package:tcourier/utils/constants.dart';
import 'package:tcourier/utils/margin_utils.dart';

class NDashScreen extends StatefulWidget {
  final VoidCallback onNotificationsTap;
  const NDashScreen({this.onNotificationsTap});
  @override
  _NDashScreenState createState() => _NDashScreenState();
}

bool isUserOnline = false;

class _NDashScreenState extends State<NDashScreen> with SingleTickerProviderStateMixin {
  AnimationController controller;
  int selectedId;

  // Future<List<C2Choice<String>>> _transportFuture;
  ColorTween colorTween;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  Animation colorTweenAnimation;
  AuthService authService = Get.put(AuthService());
  CourierVisibilityService courierVisibilityService = Get.put(CourierVisibilityService());
  GoogleMapController mapController;
  double latitude;
  double longitude;
  int currentIndex = 0;
  var totalItems = 0;
  String fcmToken = "";
  bool hasNewRideRequest = false;
// For storing the current position
  Future<Position> _currentLocation;
  Position _currentPosition;
  String mapID;
  List startPlaceMark;
//creating a list of markers
//   String _currentAddress = "", _startAddress = "";
  Position startCoordinates;
  // Set<Marker> _markers = {};
  @override
  void initState() {
    super.initState();
    _currentLocation = Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // _transportFuture = CourierOrderService().getTransportTypes();

    AppPreferences.getBool(AppConstants.GoOnline).then((value) {
      setState(() {
        isUserOnline = value;
      });
    });
    _getCurrentLocation();
    _getFirebaseMessageData();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    colorTween = ColorTween(begin: Colors.lightGreen, end: Colors.green);
    colorTweenAnimation = colorTween.animate(controller);
    if (controller.status == AnimationStatus.completed) {
      controller.reverse();
    } else {
      controller.forward();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isUserOnline == true) {
      Future.delayed(const Duration(seconds: 1), () {
        print("locate");
        _getCurrentLocation();
      });
      Future.delayed(const Duration(seconds: 5), () {
        sendCoordinatesToServer();
      });
    }
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Get.to(() => ViewNewOrder());
      //   },
      // ),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            isUserOnline == false
                ? SizedBox.shrink()
                : Material(
                    color: Colors.blueGrey.shade700,
                    child: Container(
                      width: double.maxFinite,
                      height: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          YMargin(10),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              XMargin(20),
                              SliderButton(
                                action: () {
                                  showCircularLoaderDialog();
                                  Future.delayed(Duration(seconds: 3), () {
                                    courierVisibilityService.goOffline().then((value) {
                                      Get.back();
                                      if (value == 200) {
                                        print(value);
                                        showNotification("Offline");
                                        setState(() {
                                          AppPreferences.setBool(AppConstants.GoOnline, false);
                                          isUserOnline = false;
                                        });
                                      } else {
                                        Get.snackbar(
                                          "Error",
                                          "An error occurred, please try again",
                                        );
                                      }
                                    });
                                  });
                                },

                                ///Put label over here
                                label: Text(
                                  "go offline".toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                icon: Center(
                                  child: Icon(
                                    FontAwesomeIcons.angleDoubleRight,
                                    size: 28,
                                    color: Colors.white,
                                  ),
                                ),
                                boxShadow: BoxShadow(),
                                shimmer: false,
                                // vibrationFlag: true,
                                width: 200,
                                height: 60,
                                radius: 45,
                                buttonColor: Colors.amber.shade300,
                                backgroundColor: Colors.amber.shade300,
                                highlightedColor: Colors.white,
                                baseColor: Colors.amber.shade300,
                              ),
                            ],
                          ),
                          YMargin(10),
                          LinearProgressIndicator(
                            color: redColor,
                          ),
                        ],
                      ),
                    ),
                  ),
            Expanded(
              child: Stack(
                children: [
                  SlidingUpPanel(
                    minHeight: 150,
                    maxHeight: 250,
                    panel: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          isUserOnline != false
                              ? SizedBox.shrink()
                              : Container(
                                  height: 50,
                                  child: SliderButton(
                                    action: () {
                                      Get.bottomSheet(
                                        Container(
                                          height: 250,
                                          color: Colors.white,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              ...List.generate(3, (index) {
                                                List transportNames = ["Bike", "Bicycle", "Car"];
                                                List<Icon> transportIcons = [
                                                  Icon(Icons.bike_scooter),
                                                  Icon(Icons.pedal_bike),
                                                  Icon(FontAwesomeIcons.car),
                                                ];
                                                List transportId = [1, 2, 3];
                                                int selectedIndex;
                                                return Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: ListTile(
                                                    leading: transportIcons[index],
                                                    dense: true,
                                                    onTap: () {
                                                      print(transportId[index]);
                                                      setState(() {
                                                        selectedIndex = index;
                                                        selectedId = transportId[index];
                                                      });
                                                      // Get.back();
                                                      showCircularLoaderDialog();
                                                      Future.delayed(Duration(seconds: 3), () {
                                                        courierVisibilityService
                                                            .goOnline(selectedId)
                                                            .then((value) {
                                                          Get.back();
                                                          Get.back();
                                                          Get.back();
                                                          if (value == 200) {
                                                            print(value);
                                                            showNotification("Online");
                                                            setState(() {
                                                              AppPreferences.setBool(
                                                                  AppConstants.GoOnline, true);
                                                              isUserOnline = true;
                                                            });
                                                          } else {
                                                            Get.snackbar(
                                                              "Error",
                                                              "An error occurred, please try again",
                                                            );
                                                          }
                                                        });
                                                      });
                                                    },
                                                    title: Text(
                                                      transportNames[index],
                                                      style: TextStyle(
                                                        color: selectedIndex == index
                                                            ? Colors.green
                                                            : Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    dismissible: false,
                                    boxShadow: BoxShadow(
                                      color: redColor,
                                      blurRadius: 0,
                                    ),

                                    ///Put label over here
                                    label: Text(
                                      "Go Online",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 26,
                                      ),
                                    ),
                                    icon: Center(
                                      child: Icon(
                                        FontAwesomeIcons.angleDoubleRight,
                                        color: Colors.white,
                                        size: 28,
                                        semanticLabel: 'Text to announce in accessibility modes',
                                      ),
                                    ),
                                    shimmer: false,
                                    // vibrationFlag: true,
                                    width: MediaQuery.of(context).size.width,
                                    radius: 0,
                                    buttonColor: redColor,
                                    backgroundColor: redColor,
                                    highlightedColor: Colors.white,
                                  ),
                                ),
                          YMargin(20),
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Text(
                              "Today's Earnings".toUpperCase(),
                              style: TextStyle(color: Colors.grey.shade500),
                            ),
                          ),
                          YMargin(10),
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "$euro 0.00".toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.green.shade500,
                                      fontSize: 36,
                                      fontFamily: "popbold"),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: widget.onNotificationsTap,
                                  child: Row(
                                    children: [
                                      Text(
                                        "earnings".toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Icon(
                                        FontAwesomeIcons.arrowRight,
                                        size: 12,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          YMargin(10),
                        ],
                      ),
                    ),
                    body: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Stack(
                        children: [
                          FutureBuilder(
                              future: _currentLocation,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.done) {
                                  if (snapshot.hasData) {
                                    // The user location returned from the snapshot
                                    Position snapshotData = snapshot.data;
                                    LatLng _userLocation =
                                        LatLng(snapshotData.latitude, snapshotData.longitude);
                                    return GoogleMap(
                                      onMapCreated: (GoogleMapController controller) {
                                        mapController = controller;
                                      },
                                      mapType: MapType.normal,
                                      // onCameraMove: (position) {
                                      //   print("ahhhhhhhhhh  ====>>> $position");
                                      // },
                                      buildingsEnabled: true,
                                      myLocationButtonEnabled: true,
                                      myLocationEnabled: true,
                                      initialCameraPosition: CameraPosition(
                                        target: _userLocation,
                                        zoom: 12,
                                      ),
                                      // markers: _markers
                                      //   ..add(
                                      //     Marker(
                                      //         markerId: MarkerId("Your Location"),
                                      //         infoWindow: InfoWindow(title: "Your Location"),
                                      //         position: _userLocation),
                                      //   ),
                                    );
                                  } else {
                                    return Center(child: Text("Failed to get user location."));
                                  }
                                }
                                // While the connection is not in the done state yet
                                return Center(child: CircularProgressIndicator());
                              }),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ClipOval(
                                  child: Material(
                                    color: Colors.blue[100], // button color
                                    child: InkWell(
                                      splashColor: Colors.blue, // inkwell color
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: Icon(Icons.add),
                                      ),
                                      onTap: () {
                                        mapController.animateCamera(
                                          CameraUpdate.zoomIn(),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                YMargin(20),
                                ClipOval(
                                  child: Material(
                                    color: Colors.blue[100], // button color
                                    child: InkWell(
                                      splashColor: Colors.blue, // inkwell color
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: Icon(Icons.remove),
                                      ),
                                      onTap: () {
                                        mapController.animateCamera(
                                          CameraUpdate.zoomOut(),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                isUserOnline == true ? YMargin(150) : SizedBox.shrink()
                              ],
                            ),
                          ),
                          Positioned(
                            top: 70,
                            right: 10,
                            child: ClipOval(
                              child: Material(
                                color: Colors.orange[100], // button color
                                child: InkWell(
                                  splashColor: Colors.orange, // inkwell color
                                  child: SizedBox(
                                    width: 56,
                                    height: 56,
                                    child: Icon(Icons.my_location),
                                  ),
                                  onTap: () {
                                    mapController.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                          target: LatLng(
                                            // Will be fetching in the next step
                                            _currentPosition.latitude,
                                            _currentPosition.longitude,
                                          ),
                                          zoom: 18.0,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendCoordinatesToServer() async {
    courierVisibilityService.sendCurrentLocation("${_currentPosition.latitude}",
        "${_currentPosition.longitude}", "${_currentPosition.speed}");
  }

// Method for retrieving the current location
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        // Store the position in the variable
        _currentPosition = position;
        latitude = position.latitude;
        longitude = position.longitude;

        print('CURRENT POS: $_currentPosition');
        print("speed ===========>>>>>>>>>>>>>>>> ${_currentPosition.speed}");
        print(mapController.mapId);
        mapID = mapController.mapId.toString();
        // For moving the camera to current location
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
      // _getAddress();
    }).catchError((e) {
      print(e);
    });
  }

  _getFirebaseMessageData() {
    // ignore: missing_return
    _firebaseMessaging.getToken().then(
      (value) {
        setState(
          () {
            fcmToken = value;
            print(fcmToken);
          },
        );
      },
    );

    // ignore: missing_return
    FirebaseMessaging.onBackgroundMessage(
      // ignore: missing_return
      (message) {
        RemoteNotification notification = message.notification;
        AndroidNotification android = message.notification?.android;
        if (notification != null && android != null) {
          Get.dialog(
            AlertDialog(
              title: Text(notification.title),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notification.body),
                  ],
                ),
              ),
            ),
          );
        }
        if (notification != null && android != null) {
          // flutterLocalNotificationsPlugin.show(
          //   notification.hashCode,
          //   notification.title,
          //   notification.body,
          //   NotificationDetails(
          //     android: AndroidNotificationDetails(
          //       channel.id,
          //       channel.name,
          //       channel.description,
          //       color: Colors.white,
          //       playSound: true,
          //       icon: '@mipmap/launcher_icon.png',
          //     ),
          //   ),
          // );
        }
      },
    );
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        // ignore: unnecessary_statements
        hasNewRideRequest == true;
        RemoteNotification notification = message.notification;
        AndroidNotification android = message.notification?.android;
        if (notification != null && android != null) {
          AwesomeNotifications()
              .createNotification(
                  content: NotificationContent(
            id: 10,
            channelKey: 'high_intensity',
            title: "${message.notification.title}",
            body: "${message.notification.body}",
          ))
              .then((value) {
            setState(() {
              // ignore: unnecessary_statements
              hasNewRideRequest == true;
            });
          });
          //   flutterLocalNotificationsPlugin.show(
          //     notification.hashCode,
          //     notification.title,
          //     notification.body,
          //     NotificationDetails(
          //       android: AndroidNotificationDetails(
          //         channel.id,
          //         channel.name,
          //         channel.description,
          //         color: Colors.white,
          //         playSound: true,
          //         icon: '@mipmap/launcher_icon.png',
          //       ),
          //     ),
          //   );
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        print('A new onMessageOpenedApp event was published!');
        RemoteNotification notification = message.notification;
        AndroidNotification android = message.notification?.android;
        if (notification != null && android != null) {
          Get.dialog(
            AlertDialog(
              title: Text(notification.title),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notification.body),
                    Text(notification.body),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  void showCircularLoaderDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width / 1.1,
          height: MediaQuery.of(context).size.height / 3.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [CircularProgressIndicator()],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  // ignore: missing_return
  Future onSelectNotification(String payload) {
    debugPrint("payload : $payload");
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text('Notification'),
        content: new Text('$payload'),
      ),
    );
  }

  void showNotification(String msg) {
    AwesomeNotifications()
        .createNotification(
            content: NotificationContent(
      id: 10,
      channelKey: 'high_intensity',
      title: "$msg",
      body: "$msg",
    ))
        .then((value) {
      setState(() {
        // ignore: unnecessary_statements
        hasNewRideRequest == true;
      });
    });
    // flutterLocalNotificationsPlugin.show(
    //   0,
    //   "Success $msg",
    //   "Currently $msg",
    //   NotificationDetails(
    //     android: AndroidNotificationDetails(
    //       channel.id,
    //       channel.name,
    //       channel.description,
    //       importance: Importance.max,
    //       priority: Priority.max,
    //       color: Colors.white,
    //       autoCancel: true,
    //       playSound: true,
    //       channelShowBadge: true,
    //       enableVibration: true,
    //       fullScreenIntent: true,
    //       icon: '@mipmap/launcher_icon.png',
    //     ),
    //   ),
    // )
    //     .then((value) {
    //     setState(() {
    //       // ignore: unnecessary_statements
    //       hasNewRideRequest == true;
    //     });
    //     })
    //     ;
  }
}
