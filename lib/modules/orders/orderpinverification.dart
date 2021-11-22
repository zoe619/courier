import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:tcourier/core/controllers/courier_orders_controller.dart';
import 'package:tcourier/utils/constants.dart';
import 'package:tcourier/utils/margin_utils.dart';

const _kDefaultHint = '****';

class DeliveryVerificationScreen extends StatefulWidget {
  final String clientName;
  DeliveryVerificationScreen({
    Key key,
    this.clientName,
  }) : super(key: key);
  @override
  createState() => _DeliveryVerificationScreenState();
}

class _DeliveryVerificationScreenState extends State<DeliveryVerificationScreen> {
  static final int _pinLength = 4;
  bool _obscureEnable = false;
  bool isLoading = false;
  PinDecoration _pinDecoration;
  TextEditingController _pinEditingController = TextEditingController(text: '');
  CourierOrderService courierOrderService = Get.put(CourierOrderService());
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
            {
              makePinRequest();
            }
          }
        },
      ),
    );
  }

  @override
  void initState() {
    // AuthViewModel().generateAndSendOTP(widget.identity);
    _pinEditingController.addListener(() {
      debugPrint('controller execute. pin:${_pinEditingController.text}');
    });
    super.initState();
    _selectedMenu(PinEntryType.underline);
  }

  // ignore: unused_field
  PinEntryType _pinEntryType = PinEntryType.underline;
  ColorBuilder _solidColor = PinListenColorBuilder(Color(0xff333333), Color(0xff219653));
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
            strokeColorBuilder: PinListenColorBuilder(Colors.cyan, Colors.green),
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
            strokeColorBuilder: PinListenColorBuilder(Colors.cyan, Colors.green),
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
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back,
                color: redColor,
              ),
            ),
          ],
        ),
        YMargin(10),
        Container(
          alignment: Alignment.center,
          child: Text(
            'Confirm Order Delivery',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget _subtitle() {
    return Container(
      alignment: Alignment.center,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Enter 4-digit code we have provided to the Client \n \n',
          style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.normal,
              color: Colors.black,
              fontWeight: FontWeight.bold),
          children: (<TextSpan>[
            TextSpan(
              text: "${widget.clientName}",
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
    return GestureDetector(
      onTap: () {
        Get.dialog(
          AlertDialog(
            title: Text(
              "Attention",
              style: GoogleFonts.montserrat(
                color: redColor,
              ),
            ),
            content: Container(
              height: 100,
              child: Column(
                children: [
                  Text("Please note that with this action, you would be held accountable, "
                      "prior to customer stating that they had an issue with this order.")
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "Close",
                  style: GoogleFonts.montserrat(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                  Future.delayed(Duration(seconds: 1), () {
                    Get.back();

                    Get.snackbar(
                      "Success",
                      "Order delivery confirmed",
                      colorText: Colors.white,
                      backgroundColor: Colors.green,
                    );
                  });
                },
                child: Text(
                  "Accept",
                  style: GoogleFonts.montserrat(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: "Didn't receive the code?\n",
            style: TextStyle(fontSize: 12, color: Color(0xff828282), fontWeight: FontWeight.w500),
            children: [
              TextSpan(
                text: "Force delivery confirmation",
                style: GoogleFonts.montserrat(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ]),
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
              YMargin(20),
              _title(),
              const YMargin(10),
              _subtitle(),
              const YMargin(100),
              _pincode2(),
              const YMargin(50),
              _didnt(),
              const YMargin(20),
              YMargin(100),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: isLoading == true
                        ? () {}
                        : () {
                            if (_pinEditingController.text != "") {
                              makePinRequest();
                            } else {
                              Get.snackbar(
                                "Error",
                                "Please input pin",
                                colorText: Colors.white,
                                backgroundColor: Colors.red,
                              );
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
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              ),
                            )
                          : Center(
                              child: Text(
                                "Verify OTP",
                                style: TextStyle(fontSize: 22, color: Colors.white),
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

  makePinRequest() {
    setState(() {
      isLoading = true;
    });
    courierOrderService.confirmOrderDelivery(_pinEditingController.text).then((value) {
      if (value == 200) {
        setState(() {
          isLoading = false;
        });
        Get.snackbar("Success", "Delivery Confirmed",
            backgroundColor: Colors.green, colorText: Colors.white, duration: Duration(seconds: 3));
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
  }
}
