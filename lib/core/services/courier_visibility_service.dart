import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tcourier/core/api/api.dart';
import 'package:tcourier/core/api/endpoints.dart';

class CourierVisibilityService {
  final storage = new FlutterSecureStorage();

  Future<int> goOnline(transportMeansId) async {
    var uri = Uri.parse(Api.$BaseUrl +
        Endpoints.goOnline +
        "?transport_means_id=$transportMeansId");
    var token = await storage.read(key: "token");
    print(uri);

    final response = await http.post(uri, headers: {
      "Authorization": "Bearer $token",
      "Accept": "application/json",
    });

    int status = response.statusCode;
    print("========>> $status ===>>> ${response.reasonPhrase}");
    return status;
  }

  Future<int> goOffline() async {
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.goOffline);
    var token = await storage.read(key: "token");
    print(uri);
    final response = await http.post(uri, headers: {
      "Authorization": "Bearer $token",
      "Accept": "application/json",
    });
    int status = response.statusCode;
    print("========>> $status ===>>> ${response.reasonPhrase}");
    return status;
  }

  Future sendCurrentLocation(lat, lng, speed) async {
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.sendCurrentLocation);
    var token = await storage.read(key: "token");
    print(uri);
    Map body = {
      "lat": "$lat",
      "lng": "$lng",
      "speed": "$speed",
    };
    print(json.encode(body));
    final response = await http.post(uri, body: body, headers: {
      "Authorization": "Bearer $token",
      // "Accept": "application/json",
    });
    int status = response.statusCode;
    print("-====>> $status ======>>>> ${response.body}");
    return status;
  }

  Future addDeviceFcmToken(String fcmToken) async {
    var device = GetPlatform.isAndroid ? "android" : "ios";
    print(device);
    var token = await storage.read(key: "token");
    var url = Api.$BaseUrl +
        Endpoints.addDeviceFcmToken +
        "?device=$device&token=$fcmToken";
    print(token);
    print(url);
    try {
      final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      if (response.statusCode == 200) {
        print("${json.decode(response.body)["message"]}");
      } else {
        print("device token error ${response.statusCode}");
        print("device token error body ${response.body}");
      }
    } catch (e) {
      print(e);
    }
  }
}
