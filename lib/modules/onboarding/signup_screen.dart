import 'dart:convert';

import 'package:advanced_search/advanced_search.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:tcourier/Model/citiesModel.dart';
import 'package:tcourier/core/services/auth_service.dart';
import 'package:tcourier/core/services/city_service.dart';
import 'package:tcourier/core/services/destination_service.dart';
import 'package:tcourier/modules/onboarding/login_screen.dart';
import 'package:tcourier/modules/onboarding/widgets/sign_up_form_widget.dart';
import 'package:tcourier/modules/onboarding/widgets/update_form_widget.dart';
import 'package:tcourier/utils/drop_down_values.dart';
import 'package:tcourier/utils/margin_utils.dart';
import 'package:textfield_search/textfield_search.dart';

class SignUpScreen extends StatefulWidget {
  final String code;
  const SignUpScreen({this.code});
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  var genderDropDownValue;
  String country;
  String city;
  int selectedCountryId;
  int selectedCityId;

  // Future<List<String>> _countryFuture;
  Future _countryFuture;
  Future _cityFuture;

  // Future<List> _cityFuture;
  String selectedCountry;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  AuthService authService = Get.put(AuthService());

  @override
  void initState() {
    super.initState();
    DestinationService().getAllCountries();
    _countryFuture = DestinationService().getAllCountries();

    cityController.addListener(() {
      print("Textfield value: ${cityController.text}");
      var index = cityName.indexWhere((element) => element == cityController.text);
      if (index >= 0) {
        print("============>>>>>>>>> $index");
        setState(() {
          selectedCityId = cityId[index];
        });
        print("============>>>>>>>>> $index   ===  $selectedCityId");
      }
    });
  }

  @override
  void dispose() {
    allCountries.clear();
    allCities.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Container(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YMargin(70),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    "Update Details",
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 23,
                      // fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                YMargin(8),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    "Tell us more about you",
                    style: GoogleFonts.montserrat(
                      color: Colors.grey,
                      fontSize: 17,
                    ),
                  ),
                ),
                YMargin(30),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SignUpFormWidget(
                    validator: MinLengthValidator(1, errorText: "Field is required"),
                    controller: firstNameController,
                    iconData: Icons.person,
                    labelText: "First Name",
                    hintText: "John",
                    isPassword: false,
                  ),
                ),
                YMargin(10),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SignUpFormWidget(
                    validator: MinLengthValidator(1, errorText: "Field is required"),
                    controller: lastNameController,
                    iconData: Icons.person,
                    labelText: "Last Name",
                    hintText: " Doe",
                    isPassword: false,
                  ),
                ),
                YMargin(10),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SignUpFormWidget(
                    type: TextInputType.emailAddress,
                    validator: EmailValidator(errorText: "Email format is not correct"),
                    controller: emailController,
                    iconData: Icons.mail,
                    labelText: "Email",
                    hintText: "john@doe.com",
                    isPassword: false,
                  ),
                ),
                YMargin(10),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SignUpFormWidget(
                    controller: passWordController,
                    iconData: Icons.vpn_key,
                    validator: MinLengthValidator(4,
                        errorText: "Field is required, password must be greater than 4 letters"),
                    labelText: "Password",
                    hintText: "*********",
                    isPassword: true,
                  ),
                ),
                YMargin(10),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: UpdateFormWidget(
                    type: TextInputType.streetAddress,
                    validator: MinLengthValidator(1, errorText: "Field is required"),
                    controller: addressController,
                    iconData: Icons.location_pin,
                    labelText: "Address",
                    hintText: "12 Sauce street",
                    isPassword: false,
                  ),
                ),
                YMargin(10),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: UpdateFormWidget(
                    validator: MinLengthValidator(4, errorText: "Field is required"),
                    controller: dobController,
                    iconData: Icons.calendar_today_sharp,
                    labelText: "Date of Birth",
                    hintText: " 12/03/1999",
                    isPassword: false,
                  ),
                ),
                YMargin(10),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: _genderDropDown(),
                ),
                YMargin(10),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      // FutureBuilder<List<String>>(
                      //     future: _countryFuture,
                      //     builder: (context, snapshot) {
                      //       if (snapshot.connectionState == ConnectionState.done &&
                      //           snapshot.data != null) {
                      //         return Center(
                      //           child: AdvancedSearch(
                      //             data: countryName,
                      //             itemsShownAtStart: 0,
                      //             maxElementsToDisplay: 10,
                      //             hideHintOnTextInputFocus: true,
                      //             hintText: "Search country",
                      //             fontSize: 16,
                      //             hintTextColor: Colors.black,
                      //             inputTextFieldBgColor: Colors.white,
                      //             onItemTap: (index, value) async {
                      //               FocusScope.of(context).unfocus();
                      //               setState(() {
                      //                 country = value;
                      //                 selectedCountry = countryCode[index];
                      //                 selectedCountryId = countryId[index];
                      //                 _cityFuture =
                      //                     fetchNameCities(cityController.text, selectedCountry);
                      //               });
                      //               print("county: $selectedCountry");
                      //             },
                      //             onSearchClear: () {
                      //               print("Cleared Search");
                      //             },
                      //             onSubmitted: (searchText, listOfResults) {
                      //               print("Submitted: " + searchText);
                      //             },
                      //             onEditingProgress: (searchText, listOfResults) {
                      //               print("TextEdited: " + searchText);
                      //               print("LENGTH: " + listOfResults.length.toString());
                      //             },
                      //           ),
                      //         );
                      //       } else {
                      //         return Container(
                      //           width: double.infinity,
                      //           height: 60,
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(4),
                      //             color: Color(0x1e000000),
                      //           ),
                      //           padding: const EdgeInsets.only(
                      //             left: 25,
                      //             right: 25,
                      //           ),
                      //           child: Center(
                      //             child: TextField(
                      //               enabled: false,
                      //               decoration: InputDecoration(
                      //                 border: InputBorder.none,
                      //                 hintText: ".....",
                      //               ),
                      //             ),
                      //           ),
                      //         );
                      //       }
                      //     }),
                      FutureBuilder(
                          future: _countryFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              return Center(
                                child: AdvancedSearch(
                                  data: countryName,
                                  itemsShownAtStart: 0,
                                  maxElementsToDisplay: 10,
                                  hideHintOnTextInputFocus: true,
                                  hintText: "Search country",
                                  fontSize: 16,
                                  // showListOfResults: false,
                                  hintTextColor: Colors.black,
                                  inputTextFieldBgColor: Color(0x1e000000),
                                  onItemTap: (index, value) async {
                                    FocusScope.of(context).unfocus();

                                    setState(() {
                                      country = value;
                                      selectedCountry = countryCode[index];
                                      selectedCountryId = countryId[index];
                                      _cityFuture = CityService().fetchCities(selectedCountry);
                                    });
                                    print("county: $selectedCountry");
                                  },
                                  onSearchClear: () {
                                    print("Cleared Search");
                                  },
                                  onSubmitted: (searchText, listOfResults) {
                                    print("Submitted: " + searchText);
                                  },
                                  onEditingProgress: (searchText, listOfResults) {
                                    print("TextEdited: " + searchText);
                                    print("LENGTH: " + listOfResults.length.toString());
                                  },
                                ),
                              );
                            } else {
                              return Container(
                                width: double.infinity,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Color(0x1e000000),
                                ),
                                padding: const EdgeInsets.only(
                                  left: 25,
                                  right: 25,
                                ),
                                child: Center(
                                  child: TextField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: ".....",
                                    ),
                                  ),
                                ),
                              );
                            }
                          }),
                      YMargin(30),
                      TextFieldSearch(
                        label: 'Cities',
                        controller: cityController,
                        future: () {
                          return fetchNameCities(cityController.text, selectedCountry);
                        },
                        // getSelectedValue: (index) {
                        //   print(index);
                        // },
                        minStringLength: 1,
                        textStyle: GoogleFonts.montserrat(color: Colors.black),
                        decoration: InputDecoration(hintText: 'Search City'),
                      ),
                      // FutureBuilder<List>(
                      //     future: _cityFuture,
                      //     builder: (context, snapshot) {
                      //       if (snapshot.connectionState == ConnectionState.done &&
                      //           snapshot.data != null) {
                      //         return Center(
                      //           child: AdvancedSearch(
                      //             data: cityName,
                      //             itemsShownAtStart: 0,
                      //             maxElementsToDisplay: 10,
                      //             hideHintOnTextInputFocus: true,
                      //             hintText: "Search city",
                      //             fontSize: 16,
                      //             hintTextColor: Colors.black,
                      //             inputTextFieldBgColor: Colors.white,
                      //             onSearchClear: () {},
                      //             onItemTap: (index, value) async {
                      //               FocusScope.of(context).unfocus();

                      //               setState(() {
                      //                 city = value;
                      //                 selectedCityId = cityId[index];
                      //               });
                      //               print("city: $city");
                      //             },
                      //             onSubmitted: (searchText, listOfResults) {
                      //               print("Submitted: " + searchText);
                      //             },
                      //             onEditingProgress: (searchText, listOfResults) {
                      //               print("TextEdited: " + searchText);
                      //             },
                      //           ),
                      //         );
                      //       } else {
                      //         return Container(
                      //           width: double.infinity,
                      //           height: 60,
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(4),
                      //             color: Color(0x1e000000),
                      //           ),
                      //           padding: const EdgeInsets.only(
                      //             left: 25,
                      //             right: 25,
                      //           ),
                      //           child: Center(
                      //             child: TextField(
                      //               enabled: false,
                      //               decoration: InputDecoration(
                      //                 border: InputBorder.none,
                      //                 hintText: ".....",
                      //               ),
                      //             ),
                      //           ),
                      //         );
                      //       }
                      //     }),
                    ],
                  ),
                ),
                YMargin(50),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: GestureDetector(
                    onTap: () {
                      //_formKey.currentState.validate() &&
                      print(
                          "===> $selectedCityId} ===> $selectedCountryId ====>> $genderDropDownValue");
                      if (!_formKey.currentState.validate() ||
                          selectedCityId == null ||
                          selectedCountryId == null ||
                          genderDropDownValue == null) {
                        Get.snackbar(
                          "Error",
                          "Fill all fields and add a location and city",
                          duration: Duration(seconds: 3),
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        authService
                            .createAccount(
                          firstNameController.text,
                          lastNameController.text,
                          genderDropDownValue,
                          emailController.text,
                          passWordController.text,
                          addressController.text,
                          dobController.text,
                          selectedCountryId,
                          selectedCityId,
                        )
                            .then(
                          (value) {
                            setState(() {
                              isLoading = false;
                            });
                            print(value);
                            if (value == 200) {
                              Get.off(
                                () => LoginScreen(),
                              );
                            } else if (value == 422) {
                              Get.snackbar(
                                "Error",
                                "One or more fiels are missing or invalid",
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            } else {
                              Get.snackbar("Error", "Invalid details");
                            }
                          },
                        );
                      }
                    },
                    child: Container(
                      height: 50,
                      width: double.maxFinite,
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
                                "Sign Up".toUpperCase(),
                                style: TextStyle(fontSize: 14, color: Colors.white),
                              ),
                            ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                YMargin(20),
                GestureDetector(
                  onTap: () {
                    Get.off(() => LoginScreen());
                  },
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Existing User? "),
                        XMargin(2),
                        Text(
                          "Login Here",
                          style: TextStyle(
                            color: Colors.blue,
                            fontFamily: "popbold",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                YMargin(30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Map> _myGender = gender;
  _genderDropDown() {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        dropdownColor: Colors.white,
        value: genderDropDownValue,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 20,
        hint: new Text(
          "Gender",
          style: TextStyle(color: Colors.black),
        ),
        style: TextStyle(color: Colors.black),
        elevation: 16,
        onChanged: (String newGenderValue) {
          setState(() {
            genderDropDownValue = newGenderValue;
          });
          print(genderDropDownValue);
        },
        items: _myGender.map((Map map) {
          return new DropdownMenuItem<String>(
            value: map["gender"],
            child: new Text(
              map["gender"],
            ),
          );
        }).toList(),
      ),
    );
  }

  // ignore: missing_return
  Future<List> fetchNameCities(searchValue, countryCode) async {
    // print("city name: $cityName");
    var uri =
        // "https://demoapi.travtubes.com/api/v1/get_country_cities?country_code=$countryCode";
        "https://demoapi.travtubes.com/api/v1/get_country_cities2?search=$searchValue&country_code=$countryCode";
    print(uri);
    try {
      final response = await http.get(
        Uri.parse(uri),
        headers: {
          "Accept": "application/json",
        },
      );
      int status = response.statusCode;
      print("statusssssssss    ===>>> $status");
      if (status == 200) {
        allCities.clear();
        cityName.clear();

        var data = json.decode(response.body);
        var d = data['data'];
        for (var u in d) {
          Data c = Data.fromJson(u);
          allCities.add(c);
        }
        //   print("==============>>>>>>>>>>>. $d ");
      }
      setState(() {
        cityName = allCities.map((e) => e.city).toList();
        cityId = allCities.map((e) => e.id).toList();
      });
      print(cityName);
      print(cityId);
      return cityName;
    } catch (e) {
      print(e);
    }
  }
}

class TestItem {
  String label;
  dynamic value;
  TestItem({this.label, this.value});

  factory TestItem.fromJson(Map<String, dynamic> json) {
    return TestItem(label: json['label'], value: json['value']);
  }
}
