import 'dart:convert';

import 'package:advanced_search/advanced_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:tcourier/Model/citiesModel.dart';
import 'package:tcourier/core/services/auth_service.dart';
import 'package:tcourier/core/services/city_service.dart';
import 'package:tcourier/core/services/destination_service.dart';
import 'package:tcourier/modules/onboarding/widgets/update_form_widget.dart';
import 'package:tcourier/utils/drop_down_values.dart';
import 'package:tcourier/utils/margin_utils.dart';
import 'package:textfield_search/textfield_search.dart';

class EditUserDetails extends StatefulWidget {
  @override
  _EditUserDetailsState createState() => _EditUserDetailsState();
}

class _EditUserDetailsState extends State<EditUserDetails> {
  TextEditingController addressController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  var genderDropDownValue;
  String country;
  String city;
  int selectedCountryId;
  Future _countryFuture;
  Future _cityFuture;
  String selectedCountry;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  AuthService authService = Get.put(AuthService());

  @override
  void initState() {
    super.initState();
    _countryFuture = DestinationService().getAllCountries();
    cityController.addListener(() {
      print("Textfield value: ${cityController.text}");
    });
  }

  @override
  void dispose() {
    allCountries.clear();
    allCities.clear();
    // cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   centerTitle: true,
      //   title: Text(
      //     "Update Details",
      //     style: GoogleFonts.quicksand(
      //       fontWeight: FontWeight.bold,
      //       color: redColor,
      //       fontSize: 15,
      //     ),
      //   ),
      // ),
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
                    ),
                  ),
                ),
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
                  child: UpdateFormWidget(
                    controller: addressController,
                    iconData: Icons.location_pin,
                    labelText: "Address",
                    hintText: "12 Sauce street",
                    isPassword: false,
                  ),
                ),
                YMargin(15),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: UpdateFormWidget(
                    controller: dobController,
                    iconData: Icons.calendar_today_sharp,
                    labelText: "Date of Birth",
                    hintText: " 12th April 1999",
                    isPassword: false,
                  ),
                ),
                YMargin(15),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: _genderDropDown(),
                ),
                YMargin(15),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      FutureBuilder(
                          future: _countryFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.data != null) {
                              return Center(
                                child: AdvancedSearch(
                                  data: countryName,
                                  itemsShownAtStart: 0,
                                  maxElementsToDisplay: 10,
                                  hideHintOnTextInputFocus: true,
                                  hintText: "Search country",
                                  fontSize: 16,
                                  hintTextColor: Colors.black,
                                  inputTextFieldBgColor: Colors.white,
                                  onItemTap: (index, value) async {
                                    FocusScope.of(context).unfocus();
                                    setState(() {
                                      country = value;
                                      selectedCountry = countryCode[index];
                                      selectedCountryId = countryId[index];
                                      _cityFuture = CityService()
                                          .fetchCities(selectedCountry);
                                    });
                                    print("county: $selectedCountry");
                                  },
                                  onSearchClear: () {
                                    print("Cleared Search");
                                  },
                                  onSubmitted: (searchText, listOfResults) {
                                    print("Submitted: " + searchText);
                                  },
                                  onEditingProgress:
                                      (searchText, listOfResults) {
                                    print("TextEdited: " + searchText);
                                    print("LENGTH: " +
                                        listOfResults.length.toString());
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
                      YMargin(15),
                      TextFieldSearch(
                        label: 'Cities',
                        controller: cityController,
                        future: () {
                          return fetchNameCities(
                              cityController.text, selectedCountry);
                        },
                        minStringLength: 1,
                        textStyle: GoogleFonts.montserrat(color: Colors.black),
                        decoration: InputDecoration(hintText: 'Search City'),
                      ),
                    ],
                  ),
                ),
                YMargin(65),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: GestureDetector(
                    onTap: () {
                      // authService.kycupdate(addressController.text,dobController.text,genderdropdownvalue.toString(),CountryController.text,CityController.text).then((value) {
                      //   Map response = jsonDecode(value.body);
                      //   print(response['data']);
                      //   //   print(response);
                      //   if (value.statusCode == 200) {
                      //     Get.snackbar("Success", "Data Updated");
                      //     AppPreferences.setString(AppConstants.Auth_Token, response['data'])
                      //         .then((authkey) {});
                      //     AppPreferences.setBool(AppConstants.Token, true).then((authkey) {});
                      //     Get.offAll(() => SettingScreen(),
                      //     );
                      //   } else {
                      //     Get.snackbar("Error", "Data Not Updated");
                      //   }
                      // });
                    },
                    child: Container(
                      height: 50,
                      width: double.maxFinite,
                      child: Center(
                        child: Text(
                          "Update".toUpperCase(),
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
                YMargin(80),
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
    print("city name: $cityName");
    var uri =
        "https://demoapi.travtubes.com/api/v1/get_country_cities2?search=$searchValue&country_code=$countryCode";
    print(uri);
    try {
      final response = await http.get(Uri.parse(uri));
      int status = response.statusCode;
      print(response.body);
      if (status == 200) {
        cityName.clear();

        var data = json.decode(response.body);
        var d = data['data'];
        for (var u in d) {
          Data c = Data.fromJson(u);
          allCities.add(c);
        }
        print("==============>>>>>>>>>>>. $d ");
      }
      setState(() {
        cityName = allCities.map((e) => e.city).toList();
      });
      print(cityName);
      return cityName;
    } catch (e) {
      print(e);
    }
  }
}
