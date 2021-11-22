import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcourier/core/services/user_service.dart';
import 'package:tcourier/modules/profile/user_profile.dart';
import 'package:tcourier/utils/margin_utils.dart';

class ProfilePicUpload extends StatefulWidget {
  final File imageLink;
  const ProfilePicUpload({Key key, this.imageLink}) : super(key: key);

  @override
  _ProfilePicUploadState createState() => _ProfilePicUploadState();
}

class _ProfilePicUploadState extends State<ProfilePicUpload> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Cancel image upload?',
            style: GoogleFonts.montserrat(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ),
            XMargin(20),
            IconButton(
              onPressed: () async {
                setState(() {
                  profilePicture = null;
                });
                Get.back();
                Get.back();
              },
              icon: Icon(
                Icons.check,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: Center(
                    child: Image.file(widget.imageLink),
                  ),
                ),
                YMargin(20),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        width: 310,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(255, 4, 28, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });
                            UserService()
                                .uploadUserImage(widget.imageLink)
                                .then((value) {
                              if (value == true) {
                                setState(() {
                                  isLoading = false;
                                });
                                Get.back();

                                Get.snackbar(
                                  "Success",
                                  "Image Uploaded",
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                );
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                Get.snackbar(
                                  "Error",
                                  "Failed to upload image",
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                              }
                            });
                          },
                          child: isLoading == true
                              ? Container(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  ),
                                )
                              : Text(
                                  'Upload',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
