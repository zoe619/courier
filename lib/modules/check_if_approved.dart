import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcourier/core/services/auth_service.dart';
import 'package:tcourier/modules/landing_screen.dart';
import 'package:tcourier/modules/not_approved_ui.dart';

class CheckIfApproved extends StatefulWidget {
  @override
  _CheckIfApprovedState createState() => _CheckIfApprovedState();
}

class _CheckIfApprovedState extends State<CheckIfApproved> {
  // Future<GetCourierDetailsModel> _future;

  @override
  void initState() {
    super.initState();
    AuthService().getCourierData().then((value) {
      log(value.data.toString());
      if (value.data.isApproved == 1) {
        Get.offAll(() => LandingScreen());
      } else {
        Get.offAll(
          () => NotApprovedUi(
            data: value.data,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
