import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcourier/core/services/user_service.dart';
import 'package:tcourier/utils/constants.dart';
import 'package:tcourier/utils/margin_utils.dart';

class BankDetails extends StatefulWidget {
  const BankDetails({Key key}) : super(key: key);

  @override
  _BankDetailsState createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  bool isLoading = false;
  TextEditingController recipientName = TextEditingController();
  TextEditingController recipientAccountNumber = TextEditingController();
  TextEditingController recipientBankSwiftCode = TextEditingController();
  TextEditingController recipientBankName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 1,
        title: Text(
          "Bank Details",
          style: GoogleFonts.quicksand(
            color: redColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            YMargin(50),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: BankDetailsCard(
                controller: recipientName,
                labelText: "Account Name",
                isEnabled: true,
              ),
            ),
            YMargin(20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: BankDetailsCard(
                controller: recipientBankName,
                labelText: "Bank Name",
                isEnabled: true,
              ),
            ),
            YMargin(20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: BankDetailsCard(
                controller: recipientAccountNumber,
                labelText: "Account Number",
                isEnabled: true,
              ),
            ),
            YMargin(20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: BankDetailsCard(
                controller: recipientBankSwiftCode,
                labelText: "Bank Swift Code",
                isEnabled: true,
              ),
            ),
            YMargin(50),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: GestureDetector(
                onTap: () async {
                  if (recipientName.text != "" ||
                      recipientAccountNumber.text != "" ||
                      recipientBankSwiftCode.text != "" ||
                      recipientBankName.text != "") {
                    setState(() {
                      isLoading = true;
                    });
                    UserService()
                        .bankDetUpload(
                      recipientName.text,
                      recipientAccountNumber.text,
                      recipientBankSwiftCode.text,
                      recipientBankName.text,
                    )
                        .then((value) {
                      setState(() {
                        isLoading = false;
                      });
                      if (value == 200) {
                        Get.snackbar(
                          "Success",
                          "Bank Details Uploaded",
                          colorText: Colors.white,
                          backgroundColor: Colors.green,
                        );
                      } else {
                        Get.snackbar(
                          "Error",
                          "Failed to upload details, try again",
                          colorText: Colors.white,
                          backgroundColor: Colors.red,
                        );
                      }
                    });
                  } else {
                    Get.snackbar(
                      "Error",
                      "Fill all fields",
                      colorText: Colors.white,
                      backgroundColor: Colors.red,
                    );
                  }
                },
                child: Container(
                  height: 50,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    border: Border.all(color: redColor),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: isLoading == true
                      ? Center(
                          child: SizedBox(
                            height: 15,
                            width: 15,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(redColor),
                            ),
                          ),
                        )
                      : Center(
                          child: Text(
                            "Upload".toUpperCase(),
                            style: TextStyle(
                                color: Colors.red, fontFamily: "popbold"),
                          ),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BankDetailsCard extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isEnabled;
  const BankDetailsCard(
      {Key key, this.controller, this.labelText, this.isEnabled})
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
          color: Colors.grey,
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
