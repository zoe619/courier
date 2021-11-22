import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:tcourier/Model/get_courier_details_model.dart';
import 'package:tcourier/core/api/api.dart';
import 'package:tcourier/core/api/endpoints.dart';
import 'package:tcourier/core/services/courier_visibility_service.dart';
import 'package:tcourier/utils/constants.dart';
import 'package:tcourier/utils/shared_pref.dart';

class AuthService extends GetxController {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  CourierVisibilityService courierVisibilityService = Get.put(CourierVisibilityService());
  var headers = {"Accept": "application/json"};
  Future<http.Response> kycUpdate(address, dob, gender, country, city) async {
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.kycDetail);
    Map params = {
      "address": address,
      "date_of_birth": dob,
      "gender": gender,
      "country_id": country,
      "city_id": city,
    };
    final response = await http.post(uri, body: params, headers: headers);
    print(response.body);
    return response;
  }

  Future<http.Response> login(email, password) async {
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.login + "?phone=$email&password=$password");
    final response = await http.post(uri, headers: headers);
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      await storage.write(key: "token", value: "${data['data']}");
      //add fcm token
      await firebaseMessaging.getToken().then((value) {
        courierVisibilityService.addDeviceFcmToken(value);
      }).catchError((e) {
        print(e);
      });
    }
    print(response.body);
    return response;
  }

  Future<GetCourierDetailsModel> getCourierData() async {
    var token = await storage.read(key: "token");
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.getCourierDetails);
    final response = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    int status = response.statusCode;
    if (status == 200) {
      await SharedPref().save("courierData", json.decode(response.body));
    }
    return GetCourierDetailsModel.fromJson(json.decode(response.body));
  }

  Future<int> createAccount(String firstName, String lastName, String gender, String email,
      String password, String address, String dob, int countryId, int cityId) async {
    var uri = Uri.parse(Api.$BaseUrl +
        Endpoints.create +
        "?first_name=$firstName&last_name=$lastName&email=$email&password=$password&address=$address&date_of_birth=$dob&gender=$gender&country_id=$countryId&city_id=$cityId");
    print(uri);

    var token = await storage.read(key: "createAccToken");
    print(token);
    // Map<String, dynamic> boody = {
    //   "first_name": firstName,
    //   "last_name": lastName,
    //   "email": email,
    //   "password": password,
    //   "address": address,
    //   "date_of_birth": dob,
    //   "gender": gender,
    //   "country_id": countryId,
    //   "city_id": cityId,
    //   // cityId,
    // };
    // print(json.encode(boody));
    final response = await http.post(
      uri,
      // body: json.encode(boody),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );
    print(response.reasonPhrase);
    print(json.decode(response.body));
    int status = response.statusCode;
    return status;
  }

  Future<int> forgotPassword(email) async {
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.forgotPassword + "?email=$email");
    Map body = {
      "email": email,
    };
    final response = await http.post(uri, body: body);
    int status = response.statusCode;
    return status;
  }

  Future<int> resetPassword(
    email,
    token,
  ) async {
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.resetPassword + "?email=$email&Token=$token");
    Map body = {"email": email, "Token": token};
    final response = await http.post(uri, body: body);
    int status = response.statusCode;
    return status;
  }

  /////////////////////////////////
  // ignore: missing_return
  Future<int> verifyOtp(phone, otp) async {
    var uri = Api.$BaseUrl + "login_with_phone?phone=$phone&token=$otp";
    print(uri);
    final ioc = new HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    final response = await http.post(Uri.parse(uri), headers: {
      "Accept": "application/json",
    });
    int status = response.statusCode;
    print(status);
    if (response.statusCode == 200) {
      var responseString = json.decode(response.body);
      print("strrinnggg ==== > $responseString");
      await storage.write(key: "createAccToken", value: responseString["data"]);
      // UserService().getUserDetails();
    } else {
      print(response.body);
      print("failed" + status.toString());
    }
    return status;
  }

  // ignore: missing_return
  Future<int> requestOtp(
    String phone,
  ) async {
    var uri = Api.$BaseUrl + "generate_mobile_pin?phone=$phone";
    print(uri);
    // Map<String, dynamic> body = {'email': email, 'password': password};
    // print(body);
    final ioc = new HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    final response = await http.post(
      Uri.parse(uri),
      // headers: {
      //   'Accept': 'application/json',
      //   'Content-Type': 'application/json'
      // },
      // body: json.encode(body),
    );
    int status = response.statusCode;
    print(response.statusCode);

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print("failed" + status.toString());
    }
    return status;
  }

  Future<http.Response> goOnline(
    firebaseToken,
    mapId,
  ) async {
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.goOnline);
    var token = await storage.read(key: "token");
    Map body = {
      "firebase_token": firebaseToken,
      "gmap_id": mapId,
    };
    Map<String, String> header = {
      "Content-type": "application/json",
      "Authorization": 'Bearer $token',
      "Accept": "application/json"
    };
    final response = await http.post(uri, body: jsonEncode(body), headers: header);

    int status = response.statusCode;
    print(status);
    return response;
  }

  Future<int> goOffline(
    firebaseToken,
    mapId,
  ) async {
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.goOffline);
    var token = await storage.read(key: "key");
    Map body = {
      "firebase_token": firebaseToken,
      "gmap_id": mapId,
    };
    final response = await http.post(uri, body: jsonEncode(body), headers: {
      'Content-type': 'application/json',
      "Authorization": 'Bearer $token',
      "Accept": "application/json"
    });
    int status = response.statusCode;
    return status;
  }

  Future<int> rejectRequest(
    orderId,
    authToken,
  ) async {
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.orderReject);
    Map body = {
      "orderId": orderId,
    };
    final response = await http.post(uri, body: jsonEncode(body), headers: {
      'Content-type': 'application/json',
      "Authorization": 'Bearer $authToken',
      "Accept": "application/json"
    });

    int status = response.statusCode;
    print(status);
    return status;
  }

  Future<http.Response> acceptOrderRequest(
    orderId,
    authToken,
  ) async {
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.orderAccept);
    Map body = {
      "orderId": orderId,
    };
    final response = await http.post(uri, body: jsonEncode(body), headers: {
      'Content-type': 'application/json',
      "Authorization": 'Bearer $authToken',
      "Accept": "application/json"
    });
    int status = response.statusCode;
    print(status);
    return response;
  }

  Future<http.Response> getPendingOrders() async {
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.orderAssign);
    var token = await storage.read(key: "token");
    //"orderId": OrderId,
    final response = await http.get(uri, headers: {"Authorization": 'Bearer $token'});
    int status = response.statusCode;
    print(status);
    return response;
  }

  Future<http.Response> getOngoingOrders() async {
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.getOngoingOrder);
    var token = await storage.read(key: "token");
    //"orderId": OrderId,
    final response = await http.get(uri, headers: {"Authorization": 'Bearer $token'});
    int status = response.statusCode;
    print(status);
    return response;
  }

  Future<http.Response> getCompletedOrders() async {
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.getCompletedOrder);
    var token = storage.read(key: "token");
    //"orderId": OrderId,
    final response = await http.get(uri, headers: {"Authorization": 'Bearer $token'});
    int status = response.statusCode;
    print(status);
    return response;
  }

  Future<int> estimateDelivery(
    estimatedTime,
    orderId,
    authToken,
  ) async {
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.estimateDelivery);
    Map body = {
      "orderId": orderId,
      "estimateTime": estimatedTime,
    };
    final response = await http.post(uri, body: jsonEncode(body), headers: {
      'Content-type': 'application/json',
      "Authorization": 'Bearer $authToken',
      "Accept": "application/json"
    });
    int status = response.statusCode;
    return status;
  }

  Future<int> estimatePickup(
    estimatedTime,
    orderId,
    authToken,
  ) async {
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.estimatePickup);
    Map body = {
      "orderId": orderId,
      "estimateTime": estimatedTime,
    };
    final response = await http.post(uri, body: jsonEncode(body), headers: {
      'Content-type': 'application/json',
      "Authorization": 'Bearer $authToken',
      "Accept": "application/json"
    });
    int status = response.statusCode;
    return status;
  }

  Future<int> pinVerification(
    pin,
    orderId,
    authToken,
  ) async {
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.pinVerification);
    Map body = {
      "orderId": orderId,
      "pin": pin,
    };
    final response = await http.post(uri, body: jsonEncode(body), headers: {
      'Content-type': 'application/json',
      "Authorization": 'Bearer $authToken',
      "Accept": "application/json"
    });
    int status = response.statusCode;
    return status;
  }

  Future<int> orderDelivered(
    orderId,
    authToken,
  ) async {
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.orderDelivered);
    Map body = {
      "orderId": orderId,
    };
    final response = await http.post(uri, body: jsonEncode(body), headers: {
      'Content-type': 'application/json',
      "Authorization": 'Bearer $authToken',
      "Accept": "application/json"
    });
    int status = response.statusCode;
    return status;
  }

  Future<int> orderDispatch(
    orderId,
    authToken,
  ) async {
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.orderDispatch);
    Map body = {
      "orderId": orderId,
    };
    final response = await http.post(uri, body: jsonEncode(body), headers: {
      'Content-type': 'application/json',
      "Authorization": 'Bearer $authToken',
      "Accept": "application/json"
    });
    int status = response.statusCode;
    return status;
  }

  Future<int> orderAssign(authToken) async {
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.orderAssign);
    final response = await http.get(uri, headers: {
      'Content-type': 'application/json',
      "Authorization": 'Bearer $authToken',
      "Accept": "application/json"
    });
    int status = response.statusCode;
    return status;
  }

  Future<int> getTransportType(authToken) async {
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.getTransportType);
    final response = await http.get(uri, headers: {
      'Content-type': 'application/json',
      "Authorization": 'Bearer $authToken',
      "Accept": "application/json"
    });
    int status = response.statusCode;
    return status;
  }
}
