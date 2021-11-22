import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:tcourier/core/services/auth_service.dart';
import 'package:tcourier/modules/onboarding/forgot_password_screen.dart';
import 'package:tcourier/modules/onboarding/widgets/login_form_widget.dart';
import 'package:tcourier/utils/constants.dart';
import 'package:tcourier/utils/margin_utils.dart';

import '../check_if_approved.dart';
import 'login_flow/phone_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  TextEditingController phoneController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  AuthService authService = Get.put(AuthService());
  Future<String> getCountryName() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    debugPrint('location: ${position.latitude}');
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    return first.countryCode; // this will return country name
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "Glad to Have You Back",
                  style: TextStyle(color: Colors.black, fontSize: 22, fontFamily: "popbold"),
                ),
              ),
              YMargin(5),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "Please Login",
                  style: TextStyle(color: Colors.grey, fontSize: 18, fontFamily: "popbold"),
                ),
              ),
              YMargin(50),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: LoginFormWidget(
                  type: TextInputType.phone,
                  controller: phoneController,
                  iconData: Icons.mail,
                  labelText: "Phone number e.g 123 903 633 3223",
                  hintText: "123 903 633 3223",
                  isPassword: false,
                ),
              ),
              YMargin(20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: LoginFormWidget(
                  type: TextInputType.emailAddress,
                  controller: passWordController,
                  iconData: Icons.vpn_key,
                  labelText: "Password",
                  hintText: "*********",
                  isPassword: true,
                ),
              ),
              YMargin(50),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isLoading = true;
                  });
                  authService.login(phoneController.text, passWordController.text).then(
                    (value) async {
                      setState(() {
                        _isLoading = false;
                      });
                      if (value.statusCode == 200) {
                        Get.offAll(() => CheckIfApproved()
                            // LandingScreen()
                            );
                        Get.snackbar("Success", "Login Successful",
                            colorText: Colors.white, backgroundColor: Colors.green);
                      } else {
                        Get.snackbar(
                          "Error",
                          "Incorrect phone number or password",
                          colorText: Colors.white,
                          backgroundColor: Colors.red,
                        );
                      }
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    height: 50,
                    width: double.maxFinite,
                    child: _isLoading == true
                        ? Center(
                            child: SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                          )
                        : Center(
                            child: Text(
                              "Login".toUpperCase(),
                              style: TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              YMargin(20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.off(() => ForgotPasswordScreen());
                      },
                      child: Text(
                        "Forgot Password?",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "popmedium",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              YMargin(50),
              GestureDetector(
                onTap: () {
                  Get.off(() => PhoneNumberScreen(code: countrySplashCode));
                },
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("New User? "),
                      XMargin(2),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.blue,
                          fontFamily: "popbold",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              YMargin(30),
            ],
          ),
        ),
      ),
    );
  }
}
