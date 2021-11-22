import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:tcourier/core/services/auth_service.dart';
import 'package:tcourier/utils/margin_utils.dart';

class ResetPassword extends StatefulWidget {
  final String phone;

  const ResetPassword({Key key, this.phone}) : super(key: key);
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

const _kDefaultHint = '****';

class _ResetPasswordState extends State<ResetPassword> {
  static final int _pinLength = 4;
  bool _obscureEnable = false;
  PinDecoration _pinDecoration;
  bool isLoading = false;
  TextEditingController _pinEditingController = TextEditingController(text: '');
  TextEditingController _passwordController = TextEditingController(text: '');
  TextEditingController _confirmPasswordController =
      TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();
  bool isResetting = false;
  bool isOtpValid = false;

  AuthService authService = Get.put(AuthService());
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
              authService
                  .verifyOtp(widget.phone, _pinEditingController.text)
                  .then((value) {
                if (value == 200) {
                  // Get.offAll(() => RestaurantBottomNavigation());
                  Get.snackbar("Success", "Login Successful",
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                      duration: Duration(seconds: 3));
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
  bool obscure1 = true;
  bool obscure2 = true;

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
        'Password Reset',
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
        setState(() {
          isLoading = true;
        });
        authService
            .verifyOtp(widget.phone, _pinEditingController.text)
            .then((value) {
          if (value == 200) {
            Get.snackbar("Success", "Login Successful",
                backgroundColor: Colors.green,
                colorText: Colors.white,
                duration: Duration(seconds: 3));
          } else {
            Get.snackbar(
              "Error",
              "Verification failed!, try again",
              colorText: Colors.white,
              backgroundColor: Colors.red,
            );
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

  ProgressDialog pr;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       isOtpValid = !isOtpValid;
      //     });
      //   },
      // ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Container(
          height: height,

          ///NOTE: THE BOOL isOtpValid is used to switch between the UI of otp input and new password input
          ///once the user puts in the otp and it is validated successfully, isOtpValid is set to true and the Builder widget displays the UI for new password input
          child: Builder(
            builder: (context) {
              if (isOtpValid == false) {
                //OTP INPUT UI
                return ListView(
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
                          onTap: () {
                            if (_pinEditingController.text == "") {
                            } else {
                              setState(() {
                                isLoading = true;
                              });
                              authService
                                  .verifyOtp(
                                      widget.phone, _pinEditingController.text)
                                  .then((value) {
                                if (value == 200) {
                                  Get.snackbar("Success", "OTP verified",
                                      backgroundColor: Colors.green,
                                      colorText: Colors.white,
                                      duration: Duration(seconds: 3));
                                  setState(() {
                                    isOtpValid = !isOtpValid;
                                  });
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
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
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
                );
              } else {
                //NEW PASSWORD INPUT UI
                return Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      YMargin(30),
                      Text(
                        "Create new password",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 30,
                        ),
                      ),
                      YMargin(30),
                      Text(
                        "Password",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: obscure1,
                        validator: MinLengthValidator(4,
                            errorText:
                                "Password must be at least 4 characters long"),
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                obscure1 = !obscure1;
                              });
                            },
                            child: obscure1 == true
                                ? Icon(Icons.lock)
                                : Icon(Icons.lock_open),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      YMargin(15),
                      Text(
                        "Confirm Password",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: obscure2,
                        validator: (val) =>
                            MatchValidator(errorText: 'passwords do not match')
                                .validateMatch(val, _passwordController.text),
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                obscure2 = !obscure2;
                              });
                            },
                            child: obscure2 == true
                                ? Icon(Icons.lock)
                                : Icon(Icons.lock_open),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      YMargin(100),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                              } else {}
                            },
                            child: Container(
                              width: 300,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.red.shade600,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: isResetting == true
                                  ? Center(
                                      child: SizedBox(
                                        height: 15,
                                        width: 15,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        "Reset Password",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
