import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tcourier/Model/get_courier_details_model.dart';
import 'package:tcourier/core/services/auth_service.dart';
import 'package:tcourier/core/services/user_service.dart';
import 'package:tcourier/modules/landing_screen.dart';
import 'package:tcourier/modules/onboarding/splash_screen.dart';
import 'package:tcourier/modules/profile/profile_pic_upload.dart';
import 'package:tcourier/utils/constants.dart';
import 'package:tcourier/utils/margin_utils.dart';
import 'package:tcourier/utils/shared_pref.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

File profilePicture;

class _UserProfileState extends State<UserProfile> {
  TextEditingController _firstNameController = TextEditingController(
      text: courierLoad.data.firstName == null || courierLoad.data.firstName == ""
          ? ""
          : courierLoad.data.firstName);

  TextEditingController _lastNameController = TextEditingController(
      text: courierLoad.data.lastName == null || courierLoad.data.lastName == ""
          ? ""
          : courierLoad.data.lastName);

  TextEditingController _emailController = TextEditingController(
      text: courierLoad.data.email == null || courierLoad.data.email == ""
          ? ""
          : courierLoad.data.email);

  TextEditingController _addressController = TextEditingController(
      text: courierLoad.data.address == null || courierLoad.data.address == ""
          ? ""
          : courierLoad.data.address);

  TextEditingController _phoneController = TextEditingController(
      text: courierLoad.data.phone == null || courierLoad.data.phone == ""
          ? ""
          : courierLoad.data.phone);

  AuthService authService = Get.put(AuthService());

  final picker = ImagePicker();
  Future profileImage() async {
    var pickedImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      profilePicture = File(pickedImage.path);
    });
    Get.to(
      () => ProfilePicUpload(
        imageLink: profilePicture,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    AuthService().getCourierData().then((value) {
      fetchStorageValues();
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            FontAwesomeIcons.arrowAltCircleLeft,
            color: redColor,
          ),
        ),
        elevation: 0,
        title: Text(
          "Profile",
          style: GoogleFonts.quicksand(
            color: redColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: [
          YMargin(20),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                YMargin(20),
                GestureDetector(
                  onTap: () {
                    profileImage();
                  },
                  child: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: profilePicture != null
                            ? FileImage(
                                profilePicture,
                              )
                            //   : courierLoad.data.image != null
                            //   ? CachedNetworkImageProvider(
                            // "${courierLoad.data.image}",
                            // )
                            : ExactAssetImage(
                                "assets/img/Rectangle 1.png",
                              ),
                      ),
                    ),
                  ),
                ),
                XMargin(10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${courierLoad.data.firstName} ${courierLoad.data.lastName}",
                      style: TextStyle(
                          fontFamily: 'ProductSans', fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    YMargin(5),
                    Text(
                      "${courierLoad.data.email}",
                      style: TextStyle(
                          fontFamily: 'ProductSans',
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          YMargin(30),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                    fit: FlexFit.loose,
                    child: UserProfileDetailsWidget(
                      controller: _firstNameController,
                      labelText: "First Name",
                      isEnabled: false,
                    )),
                XMargin(20),
                Flexible(
                  fit: FlexFit.loose,
                  child: UserProfileDetailsWidget(
                    controller: _lastNameController,
                    labelText: "Last Name",
                    isEnabled: false,
                  ),
                ),
              ],
            ),
          ),
          YMargin(20),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: UserProfileDetailsWidget(
              controller: _emailController,
              labelText: "E-Mail",
              isEnabled: false,
            ),
          ),
          YMargin(20),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: UserProfileDetailsWidget(
              controller: _phoneController,
              labelText: "Phone",
              isEnabled: false,
            ),
          ),
          YMargin(20),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: UserProfileDetailsWidget(
              controller: _addressController,
              labelText: "Address",
              isEnabled: false,
            ),
          ),
          YMargin(50),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: GestureDetector(
              onTap: () async {
                UserService().logOut().then((value) {
                  Get.offAll(
                    () => SplashScreen(),
                  );
                });
              },
              child: Container(
                height: 50,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    "logout".toUpperCase(),
                    style: TextStyle(color: Colors.red, fontFamily: "popbold"),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class UserProfileDetailsWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isEnabled;

  const UserProfileDetailsWidget({Key key, this.controller, this.labelText, this.isEnabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.none,
      textAlignVertical: TextAlignVertical.bottom,
      controller: controller,
      style: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        counterText: '',
        enabled: isEnabled,
        filled: true,
        // fillColor: HexColor(fillColorCode),
        contentPadding: EdgeInsets.all(18.0),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(14.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.5,
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(14.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(14.0),
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.red,
          fontSize: 15,
        ),
        suffixIcon: isEnabled == false
            ? SizedBox()
            : Icon(
                Icons.edit,
                color: Colors.red,
                size: 22,
              ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }
}
