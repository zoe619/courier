import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:tcourier/core/services/auth_service.dart';
import 'package:tcourier/modules/onboarding/login_screen.dart';
import 'package:tcourier/utils/constants.dart';
import 'package:tcourier/utils/margin_utils.dart';

import 'otp_screen.dart';

class PhoneNumberScreen extends StatefulWidget {
  final String code;
  const PhoneNumberScreen({this.code});
  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  AuthService authService = Get.put(AuthService());
  final _phoneController = TextEditingController();
  String phoneNumber = "";
  PhoneNumber number;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    number = PhoneNumber(isoCode: widget.code);
  }

  @override
  void dispose() {
    _phoneController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              YMargin(50),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      child: new Image.asset(
                        'assets/img/myTcon.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "couriers",
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              YMargin(20),

              // Container(
              //   // color: Colors.blue,
              //   height: 150,
              //   width: 150,
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       image: ExactAssetImage(
              //         "assets/img/Tcouriers.png",
              //       ),
              //     ),
              //   ),
              //   // child: Image.asset(
              //   //   "assets/img/T (5).png",
              //   // ),
              // ),
              // YMargin(100),
              Text(
                "Welcome!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Text(
                "Enter your phone number",
                style: TextStyle(fontSize: 20),
              ),
              YMargin(50),
              // TextField(
              //   controller: _phoneController,
              //   keyboardType: TextInputType.phone,
              //   decoration: InputDecoration(
              // hintText: "Please enter your phone number",
              // hintStyle: TextStyle(
              //   color: Colors.grey,
              // ),
              //   ),
              // ),
              InternationalPhoneNumberInput(
                hintText: "Please enter your phone number",
                onInputChanged: (PhoneNumber number) {
                  print(number.phoneNumber);
                  setState(() {
                    phoneNumber = number.phoneNumber;
                  });
                },
                onInputValidated: (bool value) {
                  print(value);
                },
                selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                inputDecoration: InputDecoration(),
                // keyboardType: TextInputType.number,
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                selectorTextStyle: TextStyle(color: Colors.black),
                initialValue: number,
                textFieldController: _phoneController,
                formatInput: true,
                inputBorder: OutlineInputBorder(),
              ),
              YMargin(screenHeight(context, percent: 0.2)),

              Padding(
                padding: EdgeInsets.only(left: 0, right: 0),
                child: Container(
                  height: 60,
                  width: 344,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: redColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      print(phoneNumber);
                      print("phone  $phoneNumber");
                      if (phoneNumber.isEmpty) {
                        Get.snackbar(
                          "Error",
                          "Field must not be empty",
                          colorText: Colors.white,
                          backgroundColor: Colors.red,
                        );
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        authService.requestOtp(phoneNumber).then((value) {
                          setState(() {
                            isLoading = false;
                          });
                          if (value == 200) {
                            Get.to(() => OtpScreen(
                                  phone: phoneNumber,
                                ));
                          } else {
                            Get.snackbar(
                              "Error",
                              "Failed to send OTP, try again",
                              colorText: Colors.white,
                              backgroundColor: Colors.red,
                            );
                          }
                        }).catchError((e) {
                          setState(() {
                            isLoading = false;
                          });
                          print("e $e");
                        });
                      }
                    },
                    child: isLoading == true
                        ? Center(
                            child: SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                          )
                        : Text(
                            "Send OTP",
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                  ),
                ),
              ),
              YMargin(20),
              GestureDetector(
                onTap: () {
                  Get.off(() => LoginScreen());
                },
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Existing User? "),
                      XMargin(2),
                      Text(
                        "Log in",
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
