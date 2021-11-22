import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tcourier/Model/countries_model.dart';

List<Data> allCountries = [];
List<String> countryName = [], countryCode = [];
List<int> countryId = [];

class DestinationService {
  // ignore: missing_return
  Future<void> getAllCountries() async {
    var uri = "https://demoapi.travtubes.com/api/v1/get_countries_for_video";

    try {
      final response = await http.get(
        Uri.parse(uri),
        headers: {
          "Accept": "application/json",
        },
      );
      int status = response.statusCode;
      print("statussssssssss $status");
      if (status == 200) {
        countryCode = [];
        countryId = [];
        countryName = [];
        var data = json.decode(response.body);
        var d = data['data'];
        for (var u in d) {
          Data c = Data.fromJson(u);
          allCountries.add(c);
        }
        countryName = allCountries.map((e) => e.name).toList();
        countryCode = allCountries.map((e) => e.code).toList();
        countryId = allCountries.map((e) => e.id).toList();
        // return AllCountriesModel.fromJson(responseBody);
        print("================>>>>>>>>>>>>>>>>>");
        print(countryName);
        print(countryCode);
        print("==============>>>>>>>>>>>>>>>>>>>>>>>");
      }
    } catch (e) {
      print(e);
    }
  }
  // ignore: missing_return
  // Future<List<String>> getAllCountries() async {
  //   var uri = "https://demoapi.travtubes.com/api/v1/get_countries_for_video";

  //   final response = await http.get(Uri.parse(uri));
  //   int status = response.statusCode;
  //   if (status == 200) {
  //     countryCode = [];
  //     countryId = [];
  //     countryName = [];
  //     var data = json.decode(response.body);
  //     var d = data['data'];
  //     for (var u in d) {
  //       Data c = Data.fromJson(u);
  //       allCountries.add(c);
  //     }
  //     countryName = allCountries.map((e) => e.name).toList();
  //     countryCode = allCountries.map((e) => e.code).toList();
  //     countryId = allCountries.map((e) => e.id).toList();
  //     print("====>>>>>>>> $countryName");
  //   }
  //   return countryName;
  // }
}
