import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tcourier/Model/receipt_dashboard_model.dart';
import 'package:tcourier/core/api/api.dart';
import 'package:tcourier/core/api/endpoints.dart';
import 'package:tcourier/utils/constants.dart';

class UserService extends GetxController {
  Future<int> bankDetUpload(rName, acctNo, swiftCode, bnkName) async {
    var token = await storage.read(key: "token");
    var uri = Api.$BaseUrl +
        Endpoints.addBankDetails +
        "?recipient_name=$rName&recipient_account_number=$acctNo&recipient_bank_swift_code=$swiftCode&recipient_bank_name=$bnkName";
    print(uri);
    var status;
    try {
      final response = await http.post(Uri.parse(uri), headers: {
        "Authorization": "Bearer $token",
      });
      status = response.statusCode;
      print(status);
      if (response.statusCode == 200) {}
    } catch (e) {
      print(e);
    }
    return status;
  }

  Future<bool> uploadIdMeans(File file, issueDate, expiryDate) async {
    var token = await storage.read(key: "token");
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.addIdMeans);
    print(uri);
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    }; // remove headers if not wanted
    var request = http.MultipartRequest('POST', uri); // your server url
    print("  'issue_date': '$issueDate'   'expire_date': '$expiryDate',");
    request.fields.addAll({
      'issue_date': '$issueDate',
      'expire_date': '$expiryDate',
    }); // any other fields required by your server
    request.files.add(
        await http.MultipartFile.fromPath('id_file', '${file.path}')); // file you want to upload
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    } else if (response.statusCode == 500) {
      Get.snackbar("Error", "${await response.stream.bytesToString()}");
      return false;
    } else if (response.statusCode == 422) {
      Get.snackbar("Error", "${await response.stream.bytesToString()}");
      print("===>> ${response.statusCode} ==>> ${response.reasonPhrase}");
      return false;
    } else {
      print("===>> ${response.statusCode} ==>> ${response.reasonPhrase}");
      return false;
    }
  }

  Future<int> logOut() async {
    var token = await storage.read(key: "token");
    var uri = Api.$BaseUrl + "logout";
    var status;
    try {
      final response = await http.post(Uri.parse(uri), headers: {
        "Authorization": "Bearer $token",
      });
      status = response.statusCode;
      print(status);
      if (response.statusCode == 200) {
        await storage.deleteAll();
        print(token);
      }
      // return status;
    } catch (e) {
      print(e);
    }
    return status;
  }

  Future<bool> uploadUserImage(
    file,
  ) async {
    var token = await storage.read(key: "token");
    String fileName = file.path.split('/').last;

    var uri = (Api.$BaseUrl + "save_profile_picture");
    print("url $uri");
    try {
      dio.FormData data = dio.FormData.fromMap({
        "profile_image": await dio.MultipartFile.fromFile(file.path, filename: fileName),
      });
      dio.Dio _dio = new dio.Dio();
      _dio.options.headers["authorization"] = "Bearer $token";

      print("data body ======= ${data.files}");

      final response = await _dio.post(uri, data: data);
      if (response.statusCode == 200) {
        // UserService().getUserDetails();
        return true;
      } else {
        print("error message =====${response.statusMessage} ==>>> ${response.statusMessage}");
        Get.snackbar(
          "Error",
          response.statusMessage,
          colorText: Colors.white,
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          snackPosition: SnackPosition.TOP,
        );
        return false;
      }
    } catch (e) {
      print("error here =====${e.toString()}");
      Get.snackbar(
        "Error",
        "An Error Occurred.Please try again",
        colorText: Colors.white,
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }
  }

  Future<ReceiptDashboardModel> getUserDashboard() async {
    var token = await storage.read(key: "token");
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.getDashboard);
    final response = await http.post(
      uri,
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "Application/json",
      },
    );
    var data = json.decode(response.body);
    return ReceiptDashboardModel.fromJson(data);
  }
}
