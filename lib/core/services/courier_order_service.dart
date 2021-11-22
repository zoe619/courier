import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tcourier/core/api/api.dart';
import 'package:tcourier/core/api/endpoints.dart';
import 'package:tcourier/utils/constants.dart';

class NetService {
  static Future fetchOngoingJsonData() async {
    var token = await storage.read(key: "token");
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.getOngoingOrder);
    return http
        .get(
          uri,
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        )
        .then((response) => response?.statusCode == 200
            ? jsonDecode(response.body)
            : Get.snackbar("Error", "Failed to fetch orders"))
        // ignore: invalid_return_type_for_catch_error
        .catchError((err) => print('Error!!!!! : $err'));
  }

  static Future fetchCompletedJsonData() async {
    var token = await storage.read(key: "token");
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.getCompletedOrder);
    return http
        .get(
          uri,
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        )
        .then((response) => response?.statusCode == 200
            ? jsonDecode(response.body)
            : Get.snackbar("Error", "Failed to fetch orders"))
        // ignore: invalid_return_type_for_catch_error
        .catchError((err) => print('Error!!!!! : $err'));
  }
}
