import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:tcourier/core/services/user_service.dart';
import 'package:tcourier/utils/constants.dart';
import 'package:tcourier/utils/margin_utils.dart';

class IdMeans extends StatefulWidget {
  const IdMeans({Key key}) : super(key: key);

  @override
  _IdMeansState createState() => _IdMeansState();
}

class _IdMeansState extends State<IdMeans> {
  TextEditingController issueDateController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  File file;
  bool isLoading = false;
  var extension = "";
  // ignore: unused_field
  String _setIssueDate, _setExpiryDate;
  DateTime selectedIssueDate = DateTime.now();
  DateTime selectedExpiryDate = DateTime.now();

  pickFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        file = File(result.files.single.path);
      });
    } else {
      // User canceled the picker
    }
  }

  Future<Null> _selectIssueDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedIssueDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1800),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedIssueDate = picked;
        issueDateController.text = DateFormat.yMd().format(selectedIssueDate);
      });
  }

  Future<Null> _selectExpDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedExpiryDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1800),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedExpiryDate = picked;
        expiryDateController.text = DateFormat.yMd().format(selectedExpiryDate);
      });
  }

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
          "Means of Id",
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
              child: GestureDetector(
                onTap: () {
                  _selectIssueDate(context);
                },
                child: TextFormField(
                  textCapitalization: TextCapitalization.none,
                  textAlignVertical: TextAlignVertical.bottom,
                  controller: issueDateController,
                  onSaved: (String val) {
                    _setIssueDate = val;
                  },
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    enabled: false,
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
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    labelText: "Issue date",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),

                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                  ),
                ),
                //  IdDetailsCard(
                //   controller: issueDateController,
                //   labelText: "Issue Date",
                //   isEnabled: false,
                // ),
              ),
            ),
            YMargin(20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: GestureDetector(
                onTap: () {
                  _selectExpDate(context);
                },
                child: TextFormField(
                  textCapitalization: TextCapitalization.none,
                  textAlignVertical: TextAlignVertical.bottom,
                  controller: expiryDateController,
                  onSaved: (String val) {
                    _setExpiryDate = val;
                  },
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    enabled: false,
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
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    labelText: "Expiry date",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),

                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                  ),
                ),
                //  IdDetailsCard(
                //   controller: expiryDateController,
                //   labelText: "Expiry Date",
                //   isEnabled: false,
                // ),
              ),
            ),
            YMargin(20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: GestureDetector(
                onTap: () {
                  pickFile();
                },
                child: Column(
                  children: [
                    file == null
                        ? IdDetailsCard(
                            labelText: file == null ? "Upload ID" : file.path.trim().toString(),
                            isEnabled: false,
                          )
                        : Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: redColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.file,
                                  size: 23,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    p.basename(file.path),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    SizedBox(height: 5),
                    if (p.extension(extension) != ".jpg" ||
                        p.extension(extension) != ".jpeg" ||
                        p.extension(extension) != ".png" ||
                        p.extension(extension) != ".pdf")
                      Text("The id file must be a file of type: jpg, jpeg, png, pdf."),
                  ],
                ),
              ),
            ),
            YMargin(50),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: GestureDetector(
                onTap: () async {
                  setState(() {
                    extension = p.extension(file.path);
                  });
                  print(extension);
                  // if (p.extension(file.path) != ".pdf" ||
                  //     extension != ".jpg" ||
                  //     extension != ".jpeg" ||
                  //     extension != ".png") {
                  //   Get.snackbar("Error", "File extension not allowed");
                  // } else
                  if (issueDateController.text != "" &&
                      expiryDateController.text != "" &&
                      file != null) {
                    setState(() {
                      isLoading = true;
                    });
                    UserService()
                        .uploadIdMeans(
                      file,
                      issueDateController.text,
                      expiryDateController.text,
                    )
                        .then((value) {
                      setState(() {
                        isLoading = false;
                      });
                      if (value == true) {
                        Get.back();
                        Get.snackbar(
                          "Success",
                          "Details Uploaded",
                          colorText: Colors.white,
                          backgroundColor: Colors.green,
                        );
                      } else {
                        // Get.snackbar(
                        //   "Error",
                        //   "Failed to upload details, try again",
                        //   colorText: Colors.white,
                        //   backgroundColor: Colors.red,
                        // );
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
                              valueColor: AlwaysStoppedAnimation<Color>(redColor),
                            ),
                          ),
                        )
                      : Center(
                          child: Text(
                            "Upload".toUpperCase(),
                            style: TextStyle(color: Colors.red, fontFamily: "popbold"),
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

class IdDetailsCard extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isEnabled;
  const IdDetailsCard({Key key, this.controller, this.labelText, this.isEnabled}) : super(key: key);

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
            color: Colors.grey,
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
