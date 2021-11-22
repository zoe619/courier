import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:tcourier/core/services/auth_service.dart';
import 'package:tcourier/modules/landing_screen.dart';
import 'package:tcourier/modules/onboarding/signup_screen.dart';
import 'package:tcourier/utils/margin_utils.dart';

const _kDefaultHint = '****';

class OtpScreen extends StatefulWidget {
  final String phone;

  const OtpScreen({Key key, this.phone}) : super(key: key);
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  static final int _pinLength = 4;
  bool _obscureEnable = false;
  PinDecoration _pinDecoration;
  bool isLoading = false;
  TextEditingController _pinEditingController = TextEditingController(text: '');
  AuthService authController = Get.put(AuthService());
  // LocationController locationController = Get.put(LocationController());

  Widget _pincode2() {
    return Container(
      child: PinInputTextField(
        pinLength: _pinLength,
        decoration: _pinDecoration,
        controller: _pinEditingController,
        autoFocus: false,
        textInputAction: TextInputAction.go,
        onSubmit: (pin) {
          print('submit pin:$pin');
        },
        onChanged: (value) {
          if (value.length == 4) {
            FocusScope.of(context).unfocus();
            {
              setState(() {
                isLoading = true;
              });
              authController
                  .verifyOtp(widget.phone, _pinEditingController.text)
                  .then((value) {
                if (value == 200) {
                  // Get.offAll(() => RestaurantBottomNavigation());
                  Get.snackbar("Success", "Verification Successful",
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                      duration: Duration(seconds: 3));

                  Get.off(() => SignUpScreen());
                  // locationController.getCurrentLocation().then((value) {
                  //   print(value);

                  // });
                } else {
                  setState(() {
                    isLoading = false;
                  });
                  Get.snackbar(
                    "Error",
                    "Verification failed!, try again",
                    colorText: Colors.white,
                    backgroundColor: Colors.red,
                  );
                }
              });
            }
          }
        },
      ),
    );
  }

  @override
  void initState() {
    _pinEditingController.addListener(() {
      debugPrint('controller execute. pin:${_pinEditingController.text}');
    });
    super.initState();
    _selectedMenu(PinEntryType.underline);
  }

  // ignore: unused_field
  PinEntryType _pinEntryType = PinEntryType.underline;
  ColorBuilder _solidColor =
      PinListenColorBuilder(Color(0xff333333), Color(0xff219653));
  bool _solidEnable = false;

  /// Control whether textField is enable.

  @override
  void dispose() {
    _pinEditingController.dispose();
    super.dispose();
  }

  void _selectedMenu(PinEntryType type) {
    _pinEntryType = type;
    switch (type) {
      case PinEntryType.underline:
        setState(() {
          _pinDecoration = UnderlineDecoration(
              colorBuilder: PinListenColorBuilder(
                Color(0xff219653),
                Color(0xff333333),
              ),
              bgColorBuilder: _solidEnable ? _solidColor : null,
              obscureStyle: ObscureStyle(
                isTextObscure: _obscureEnable,
                obscureText: '😂',
              ),
              hintText: _kDefaultHint,
              textStyle: TextStyle(color: Colors.green, fontSize: 18)
              // textStyle: TextStyle(color: _solidEnable ? )
              );
        });
        break;
      case PinEntryType.boxTight:
        setState(() {
          _pinDecoration = BoxTightDecoration(
            bgColorBuilder: _solidEnable ? _solidColor : null,
            obscureStyle: ObscureStyle(
              isTextObscure: _obscureEnable,
              obscureText: '👿',
            ),
            hintText: _kDefaultHint,
          );
        });
        break;
      case PinEntryType.boxLoose:
        setState(() {
          _pinDecoration = BoxLooseDecoration(
            strokeColorBuilder:
                PinListenColorBuilder(Colors.cyan, Colors.green),
            bgColorBuilder: _solidEnable ? _solidColor : null,
            obscureStyle: ObscureStyle(
              isTextObscure: _obscureEnable,
              obscureText: '☺️',
            ),
            hintText: _kDefaultHint,
          );
        });
        break;
      case PinEntryType.circle:
        setState(() {
          _pinDecoration = CirclePinDecoration(
            bgColorBuilder: _solidEnable ? _solidColor : null,
            strokeColorBuilder:
                PinListenColorBuilder(Colors.cyan, Colors.green),
            obscureStyle: ObscureStyle(
              isTextObscure: _obscureEnable,
              obscureText: '🤪',
            ),
            hintText: _kDefaultHint,
          );
        });
        break;
      case PinEntryType.customized:
        // setState(() {
        //   _pinDecoration = ExampleDecoration();
        // });
        break;
    }
  }

  Widget _title() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Verify Account!',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
      ),
    );
  }

  Widget _subtitle() {
    return Container(
      alignment: Alignment.center,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Enter 4-digit code we have sent to at\n \n',
          style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.normal,
              color: Colors.black,
              fontWeight: FontWeight.bold),
          children: (<TextSpan>[
            TextSpan(
              text: widget.phone,
              style: TextStyle(
                  color: Colors.green,
                  fontFamily: 'popbold',
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            )
          ]),
        ),
      ),
    );
  }

  Widget _didnt() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Didn’t receive the code?',
        style: TextStyle(
            fontSize: 12,
            color: Color(0xff828282),
            fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _resend() {
    return GestureDetector(
      onTap: () {
        authController.requestOtp(widget.phone).then((value) {
          if (value == 200) {
            Get.snackbar("Success", "OTP sent successfully",
                backgroundColor: Colors.green, colorText: Colors.white);
          } else {
            Get.snackbar("Error", "Failed to send OTP, try again ",
                backgroundColor: Colors.red, colorText: Colors.white);
          }
        });
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Resend Code',
          style: TextStyle(
              // decoration: TextDecoration.underline,
              fontSize: 14,
              color: Colors.blue,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Container(
          height: height,
          child: ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: [
              YMargin(100),
              _title(),
              const YMargin(30),
              _subtitle(),
              const YMargin(100),
              _pincode2(),
              const YMargin(50),
              _didnt(),
              const YMargin(20),
              _resend(),
              YMargin(100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: isLoading == true
                        ? () {}
                        : () {
                            setState(() {
                              isLoading = true;
                            });
                            authController
                                .verifyOtp(
                                    widget.phone, _pinEditingController.text)
                                .then((value) {
                              if (value == 200) {
                                setState(() {
                                  isLoading = false;
                                });
                                Get.snackbar("Success", "Login Successful",
                                    backgroundColor: Colors.green,
                                    colorText: Colors.white,
                                    duration: Duration(seconds: 3));
                                Get.offAll(() => LandingScreen());

                                // locationController.getCurrentLocation().then((value) {
                                //   print(value);

                                // });
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                Get.snackbar(
                                  "Error",
                                  "Verification failed!, try again",
                                  colorText: Colors.white,
                                  backgroundColor: Colors.red,
                                );
                                _pinEditingController.clear();
                              }
                            });
                          },
                    child: Container(
                      width: 300,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.red.shade600,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: isLoading == true
                          ? Center(
                              child: SizedBox(
                                height: 15,
                                width: 15,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ),
                            )
                          : Center(
                              child: Text(
                                "Verify OTP",
                                style: TextStyle(
                                    fontSize: 22, color: Colors.white),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
