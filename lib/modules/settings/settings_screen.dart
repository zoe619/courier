import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcourier/Model/get_courier_details_model.dart';
import 'package:tcourier/core/controllers/courier_orders_controller.dart';
import 'package:tcourier/core/services/auth_service.dart';
import 'package:tcourier/modules/landing_screen.dart';
import 'package:tcourier/modules/profile/user_profile.dart';
import 'package:tcourier/modules/settings/bank_details.dart';
import 'package:tcourier/utils/constants.dart';
import 'package:tcourier/utils/margin_utils.dart';
import 'package:tcourier/utils/shared_pref.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  _callNumber(String phoneNumber) async {
    String number = "+37282721169";
    // phoneNumber;
    print(number);
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 1,
        title: Text(
          "Settings",
          style: GoogleFonts.quicksand(
            color: redColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                Get.to(
                  () => UserProfile(),
                  transition: Transition.rightToLeft,
                  duration: Duration(milliseconds: 500),
                );
              },
              child: Icon(
                FontAwesomeIcons.userAlt,
                color: redColor,
                // size: 26,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: [
          YMargin(10),
          SettingsCard(
            title: "Bank Details",
            isHelpCenter: true,
            onTap: courierLoad.data.hasBank == 0
                ? () {
                    Get.to(() => BankDetails());
                  }
                : () {
                    Get.dialog(
                      AlertDialog(
                        title: Text("Bank Details Uploaded"),
                        content: Container(
                          height: 130,
                          child: Column(
                            children: [
                              YMargin(10),
                              Text(
                                "If you wish to change your details please contact our support.\nThank you.",
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("OK"),
                          ),
                        ],
                      ),
                    );
                  },
          ),
          YMargin(20),
          // SettingsCard(
          //   title: "Means of identification",
          //   isHelpCenter: true,
          //   onTap: () {
          //     Get.to(() => IdMeans());
          //   },
          // ),
          // YMargin(20),
          // SettingsCard(
          //   title: "Show Restaurants List",
          //   onTap: () {
          //     pushNewScreen(context,
          //         screen: RestaurantList(), withNavBar: false);
          //   },
          // ),
          SettingsCard(
            title: "Set Maximum Delivery Distance",
            onTap: () => setMaxKm(context),
          ),
          YMargin(20),
          SettingsCard(
            title: "Help Center",
            isHelpCenter: true,
            onTap: () => showHelpCenterModal(context),
          ),
          YMargin(20),
        ],
      ),
    );
  }

  List<String> text = ["Cash", "Credit Card"];
  Set<String> selectedMethod = {};

  selectPaymentMethod(BuildContext buildContext) => showDialog(
      context: buildContext,
      builder: (buildContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: StatefulBuilder(builder: (context, state) {
            return Container(
              width: MediaQuery.of(buildContext).size.width / 1.1,
              height: MediaQuery.of(buildContext).size.height / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  YMargin(10),
                  Center(
                    child: Text(
                      "Select Payment Method",
                      style: TextStyle(color: Colors.black, fontFamily: 'popbold', fontSize: 20),
                    ),
                  ),
                  YMargin(30),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        ...List.generate(text.length, (index) {
                          return ListTile(
                            title: Text(text[index]),
                            trailing: Checkbox(
                              value: selectedMethod.contains(text[index]),
                              onChanged: (bool value) {
                                if (value) {
                                  selectedMethod.add(text[index]);
                                  print("selected===${selectedMethod.toString()}");
                                } else {
                                  selectedMethod.remove(text[index]);
                                }
                                state(() {});
                              },
                            ),
                          );
                        }),
                        YMargin(15),
                        ElevatedButton(
                          onPressed: () {
                            // popView(context);
                          },
                          child: Center(
                            child: Text(
                              "Set Distance",
                              style: TextStyle(fontSize: 16, fontFamily: "popbold"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      });

  setMaxKm(BuildContext buildContext, {previousDistance}) => showDialog(
      context: buildContext,
      builder: (buildContext) {
        RangeValues values = RangeValues(1.0, 10.0);
        RangeLabels labels = RangeLabels('1km', "10km");

        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          child: StatefulBuilder(builder: (context, state) {
            return Container(
              width: MediaQuery.of(buildContext).size.width / 1.1,
              height: MediaQuery.of(buildContext).size.height / 2.5,
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisSize: MainAxisSize.mi,
                children: [
                  YMargin(10),
                  Center(
                    child: Text(
                      "Distance",
                      style: TextStyle(color: Colors.black, fontFamily: 'popbold', fontSize: 20),
                    ),
                  ),
                  Text("Current delivery distance is "),
                  Text(
                    "${courierLoad.data.maxDeliveryKm == null ? "0" : courierLoad.data.maxDeliveryKm} km",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  YMargin(30),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        RangeSlider(
                          divisions: 5,
                          activeColor: Colors.red[700],
                          inactiveColor: Colors.grey,
                          min: 1.0,
                          max: 10.0,
                          values: values,
                          labels: labels,
                          onChanged: (value) {
                            state(
                              () {
                                values = value;
                                labels = RangeLabels(
                                  "${value.start.toInt().toString()}km",
                                  "${value.end.toInt().toString()}km",
                                );
                              },
                            );
                          },
                        ),
                        YMargin(15),
                        TextButton(
                          onPressed: () {
                            CourierOrderService().setMaxDistance(values.end.toInt()).then((value) {
                              AuthService().getCourierData().then((value) {
                                fetchStorageValues();
                              });
                              if (value == 200) {
                                Navigator.pop(context);
                                // popView(context);
                                Get.snackbar(
                                  "Success",
                                  "Maximum distance set",
                                  colorText: Colors.white,
                                  backgroundColor: Colors.green,
                                );
                              } else {
                                Get.back();
                                Get.snackbar(
                                  "Error",
                                  "Failed to set max distance",
                                  colorText: Colors.white,
                                  backgroundColor: Colors.red,
                                );
                              }
                            });
                          },
                          child: Center(
                            child: Text(
                              "Set Distance",
                              style: TextStyle(fontSize: 16, fontFamily: "popbold"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      });

  showHelpCenterModal(context) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  YMargin(40),
                  Text(
                    "Need Help?",
                    style: TextStyle(color: Colors.black, fontSize: 24, fontFamily: "popbold"),
                  ),
                  YMargin(20),
                  Container(
                    height: 60,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: new ListTile(
                      onTap: () {
                        _callNumber("+372 58493531");
                      },
                      leading: RotatedBox(
                        quarterTurns: 1,
                        child: new Icon(
                          FontAwesomeIcons.phone,
                          color: Colors.red,
                        ),
                      ),
                      title: new Text('Call Us'),
                    ),
                  ),
                  YMargin(20),
                  Container(
                    height: 60,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: new ListTile(
                      onTap: () {
                        _sendMail();
                      },
                      leading: new Icon(
                        FontAwesomeIcons.at,
                        color: Colors.red,
                      ),
                      title: new Text('Send an email'),
                    ),
                  ),
                  YMargin(20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _sendMail() async {
    // Android and iOS
    const uri = 'mailto:support@travtubes.com';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
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

class SettingsCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isHelpCenter;
  const SettingsCard({
    Key key,
    this.title,
    this.onTap,
    this.isHelpCenter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            trailing: isHelpCenter == true
                ? SizedBox()
                : RotatedBox(
                    quarterTurns: 2,
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
