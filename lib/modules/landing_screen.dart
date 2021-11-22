import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// import 'package:system_alert_window/system_alert_window.dart' as sys;
import 'package:tcourier/Model/get_courier_details_model.dart';
import 'package:tcourier/core/controllers/courier_orders_controller.dart';
import 'package:tcourier/core/services/auth_service.dart';
import 'package:tcourier/modules/dashboard/n_dash_screen.dart';
import 'package:tcourier/modules/orders/view_new_order.dart';
import 'package:tcourier/modules/reports/reports_screen.dart';
import 'package:tcourier/modules/settings/settings_screen.dart';
import 'package:tcourier/utils/constants.dart';
import 'package:tcourier/utils/shared_pref.dart';

import 'orders/n_order_screen.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

GetCourierDetailsModel courierLoad = GetCourierDetailsModel();

class _LandingScreenState extends State<LandingScreen> with SingleTickerProviderStateMixin {
  // var _androidAppRetain = MethodChannel("android_app_retain");
  PersistentTabController _pageController;
  CourierOrderService courierOrderService = Get.put(CourierOrderService());

  List<Widget> children() {
    return [
      NDashScreen(onNotificationsTap: () {
        _pageController.jumpToTab(2);
      }),
      NOrdersScreen(),
      ReportScreen(),
      SettingScreen(),
    ];
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   switch (state) {
  //     case AppLifecycleState.resumed:
  //       print("app in resumed");
  //       // sys.SystemAlertWindow.closeSystemWindow();
  //       break;
  //     case AppLifecycleState.inactive:
  //       print("app in inactive");
  //       break;
  //     case AppLifecycleState.paused:
  //       print("app in paused");
  //       // if (isUserOnline == false) {
  //       //   sys.SystemAlertWindow.registerOnClickListener(callBack);
  //       //   sys.SystemAlertWindow.showSystemWindow(
  //       //       height: 200,
  //       //       width: 200,
  //       //       header: onlineHeader,
  //       //       body: onlineBody,
  //       //       margin: sys.SystemWindowMargin(left: 8, right: 8, top: 200, bottom: 0),
  //       //       gravity: sys.SystemWindowGravity.TOP,
  //       //       notificationTitle: "Currently Online",
  //       //       notificationBody: "Go offline to stop this notification",
  //       //       prefMode: sys.SystemWindowPrefMode.DEFAULT);
  //       // } else {
  //       //   print("not online");
  //       // }
  //       break;
  //     case AppLifecycleState.detached:
  //       print("app in detached");
  //       // if (isUserOnline == false) {
  //       //   sys.SystemAlertWindow.registerOnClickListener(callBack);
  //       //   sys.SystemAlertWindow.showSystemWindow(
  //       //       height: 200,
  //       //       width: 200,
  //       //       header: onlineHeader,
  //       //       body: onlineBody,
  //       //       margin: sys.SystemWindowMargin(left: 8, right: 8, top: 200, bottom: 0),
  //       //       gravity: sys.SystemWindowGravity.TOP,
  //       //       notificationTitle: "Currently Online",
  //       //       notificationBody: "Go offline to stop this notification",
  //       //       prefMode: sys.SystemWindowPrefMode.DEFAULT);
  //       // } else {
  //       //   print("not online");
  //       // }
  //       break;
  //   }
  // }

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addObserver(this);
    FirebaseMessaging.onMessage.listen(
      (event) {
        if (isUserOnline == true || isUserOnline == false) {
          Get.to(() => ViewNewOrder());
        }
      },
    );
    _pageController = PersistentTabController(initialIndex: 0);
    AuthService().getCourierData().then((value) {
      fetchStorageValues();
    });
  }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        controller: _pageController,
        screens: children(),
        items: navItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: false,
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears.
        stateManagement: false,
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument.
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        navBarHeight: 50,
        navBarStyle: NavBarStyle.style6, // Choose the nav bar style with this property.
      ),
    );
  }

  List<PersistentBottomNavBarItem> navItems() {
    return [
      PersistentBottomNavBarItem(
        title: "Home",
        titleFontSize: 10,
        icon: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Icon(
            FontAwesomeIcons.home,
            size: 16,
          ),
        ),
        activeColor: redColor,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        title: "Orders",
        titleFontSize: 10,
        icon: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Icon(
            FontAwesomeIcons.cartArrowDown,
            size: 16,
          ),
        ),
        activeColor: redColor,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        title: "Reports",
        titleFontSize: 10,
        icon: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Icon(
            FontAwesomeIcons.dollarSign,
            size: 16,
          ),
        ),
        activeColor: redColor,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        title: "Settings",
        titleFontSize: 10,
        icon: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Icon(
            FontAwesomeIcons.cog,
            size: 16,
          ),
        ),
        activeColor: redColor,
        inactiveColor: Colors.grey,
      ),
    ];
  }

  fetchStorageValues() async {
    try {
      await storage.readAll();
      GetCourierDetailsModel user =
          GetCourierDetailsModel.fromJson(await SharedPref().read("courierData"));
      setState(() {
        courierLoad = user;
      });
      print("==>>> tag ${courierLoad.data.firstName}  id ${courierLoad.data.email}");
    } catch (e) {
      print(e);
    }
  }
}
