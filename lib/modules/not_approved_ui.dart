import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdi/mdi.dart';
import 'package:tcourier/Model/get_courier_details_model.dart';
import 'package:tcourier/core/services/user_service.dart';
import 'package:tcourier/modules/settings/id_means.dart';
import 'package:tcourier/utils/constants.dart';
import 'package:tcourier/utils/margin_utils.dart';

import 'onboarding/splash_screen.dart';

class NotApprovedUi extends StatefulWidget {
  final Data data;

  const NotApprovedUi({this.data});
  @override
  _NotApprovedUiState createState() => _NotApprovedUiState();
}

class _NotApprovedUiState extends State<NotApprovedUi> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () async {
                UserService().logOut().then((value) {
                  Get.offAll(
                    () => SplashScreen(),
                  );
                });
              },
              icon: Icon(
                Icons.logout,
                color: redColor,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                Text(
                  "Hi ${widget.data.firstName},",
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Center(
                    child: Icon(
                      Mdi.accountClockOutline,
                      size: 150,
                    ),
                  ),
                ),
                Text(
                  "Your account is still under review.",
                  // style: GoogleFonts.roboto(
                  //   fontSize: 18,
                  //   color: Colors.black,
                  // ),
                ),
                YMargin(30),
                Text("Not yet uploaded your means of identification?"),
                Text("Click the button below to upload it"),
                YMargin(20),
                Container(
                  height: 50,
                  width: 344,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => IdMeans());
                    },
                    child: Text("Click to upload"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
