import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tcourier/Model/ongoing_orders_model.dart';
import 'package:tcourier/core/api/api.dart';
import 'package:tcourier/core/api/endpoints.dart';
import 'package:tcourier/core/services/courier_order_service.dart';
import 'package:tcourier/modules/onboarding/splash_screen.dart';
import 'package:tcourier/utils/constants.dart';

class GetOngoingCourierOrdersController extends GetxController {
  var _trx;
  var _dataAvailable = false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
  }

  bool get dataAvailable => _dataAvailable.value;
  OngoingOrdersModel get trx => _trx;

  Future<void> fetchTransactions() {
    return NetService.fetchOngoingJsonData()
        .then((response) {
          log("respose from net ===>>>> $response");
          if (response != null) _trx = OngoingOrdersModel.fromJson(response);
        })
        .catchError((err) => print('Error!!!!! : $err'))
        .whenComplete(() => _dataAvailable.value = _trx != null);
  }
}

class GetCompletedCourierOrdersController extends GetxController {
  var _trx;
  var _dataAvailable = false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
  }

  bool get dataAvailable => _dataAvailable.value;
  OngoingOrdersModel get trx => _trx;

  Future<void> fetchTransactions() {
    return NetService.fetchCompletedJsonData()
        .then((response) {
          log("respose from net ===>>>> $response");
          if (response != null) _trx = OngoingOrdersModel.fromJson(response);
        })
        .catchError((err) => print('Error!!!!! : $err'))
        .whenComplete(() => _dataAvailable.value = _trx != null);
  }
}

class CourierOrderService extends GetxController {
  Future<int> acceptOrder(orderId) async {
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.orderAccept + "?order_id=$orderId");
    print(uri);

    var token = await storage.read(key: "token");
    final response = await http.post(uri, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });
    int status = response.statusCode;
    print(status);

    return status;
  }

  Future<int> rejectOrder(orderId) async {
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.orderReject + "?order_id=$orderId");
    print(uri);
    print(checkToken);
    var token = await storage.read(key: "token");
    final response = await http.post(uri, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });
    int status = response.statusCode;
    print(status);
    return status;
  }

  Future<int> confirmOrderDelivery(customerToken) async {
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.orderDelivered + "?token=$customerToken");
    print(uri);
    // var token = await storage.read(key: "token");
    print("===>> ${await storage.read(key: "token")}");
    final response = await http.post(uri, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $checkToken",
    });
    int status = response.statusCode;
    print(status);
    return status;
  }

  Future<int> setMaxDistance(distance) async {
    var token = await storage.read(key: "token");
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.maximumKm + "?distance=$distance");
    print(distance.runtimeType);
    final response = await http.post(
      uri,
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );
    int status = response.statusCode;

    return status;
  }

  Future<int> getOrders(distance) async {
    var token = await storage.read(key: "token");
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.getMyOrders);
    print(uri);

    final response = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );
    int status = response.statusCode;
    return status;
  }

  Future<http.Response> getCompletedOrders() async {
    var token = await storage.read(key: "token");
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.getCompletedOrder);
    print(uri);

    final response = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );
    // int status = response.statusCode;
    return response;
  }

  Future<OngoingOrdersModel> getOngoingOrders() async {
    var token = await storage.read(key: "token");
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.getOngoingOrder);
    print(uri);

    final response = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );
    int status = response.statusCode;
    var data = json.decode(response.body);
    log("$status ======>>>>> $data");

    return OngoingOrdersModel.fromJson(data);
  }

  Future<http.Response> getSingleOrders(orderId) async {
    var token = await storage.read(key: "token");
    var uri = Uri.parse(Api.$BaseUrl + Endpoints.getSingleOrder + "?order_id=$orderId");
    print(uri);

    final response = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );
    // int status = response.statusCode;
    return response;
  }
}
