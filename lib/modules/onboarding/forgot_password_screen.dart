import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:tcourier/core/services/auth_service.dart';
import 'package:tcourier/modules/onboarding/reset_password_screen.dart';
import 'package:tcourier/utils/constants.dart';
import 'package:tcourier/utils/margin_utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String code;
  const ForgotPasswordScreen({this.code});
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _phoneController = TextEditingController();
  bool isLoading = false;
  String phoneNumber = "";
  PhoneNumber number;
  ProgressDialog pr;
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

  AuthService authService = Get.put(AuthService());
  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.style(
        message: 'Loading ...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        // textDirection: TextDirection.rtl,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            YMargin(100),
            Text(
              "Forgot Your Password?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Text(
              "Enter your phone number",
              style: TextStyle(fontSize: 15),
            ),
            YMargin(50),
            InternationalPhoneNumberInput(
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
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              selectorTextStyle: TextStyle(color: Colors.black),
              initialValue: number,
              textFieldController: _phoneController,
              formatInput: true,
              // keyboardType:
              //     TextInputType.numberWithOptions(signed: true, decimal: true),
              inputBorder: OutlineInputBorder(),
              // onSaved: (PhoneNumber number) {
              //   print('On Saved: $number');
              // },
            ),
            Spacer(),
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
                    authService.requestOtp(phoneNumber).then((value) {
                      if (value == 200) {
                        setState(() {
                          isLoading = false;
                        });

                        Get.off(() => ResetPassword(
                              phone: phoneNumber,
                            ));
                        Get.snackbar("Success", "OTP sent successfully",
                            backgroundColor: Colors.green,
                            colorText: Colors.white);
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                        Get.snackbar("Error", "Failed to send OTP, try again ",
                            backgroundColor: Colors.red,
                            colorText: Colors.white);
                      }
                    });
                  },
                  child: isLoading == true
                      ? Center(
                          child: SizedBox(
                            height: 15,
                            width: 15,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        )
                      : Text(
                          "Send OTP",
                          // style: GoogleFonts.roboto(
                          //   fontWeight: FontWeight.w700,
                          //   color: Colors.white,
                          //   fontSize: 14,
                          // ),
                        ),
                ),
              ),
            ),
            YMargin(50),
          ],
        ),
      ),
    );
  }
}
