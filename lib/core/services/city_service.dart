import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tcourier/Model/citiesModel.dart';

List<Data> allCities = [];
List cityName = [];
List cityId = [];

class CityService {
  Future<List> fetchCities(countryCode) async {
    print("city name: $cityName");
    var uri = "https://demoapi.travtubes.com/api/v1/get_country_cities?country_code=$countryCode";
    print(uri);
    final response = await http.get(
      Uri.parse(uri),
      headers: {
        "Accept": "application/json",
      },
    );
    int status = response.statusCode;
    print("statusss ===>>> $status");
    if (status == 200) {
      cityName = [];

      var data = json.decode(response.body);
      var d = data['data'];
      for (var u in d) {
        Data c = Data.fromJson(u);
        allCities.add(c);
      }
    }
    cityName = allCities.map((e) => e.city).toList();
    cityId = allCities.map((e) => e.id).toList();
    // return status;
    return cityName;
  }
}
