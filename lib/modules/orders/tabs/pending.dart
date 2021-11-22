import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:tcourier/Model/OrderAssign.dart';
import 'package:tcourier/core/services/auth_service.dart';
import 'package:tcourier/modules/orders/order_details.dart';
import 'package:tcourier/utils/margin_utils.dart';

class PendingOrders extends StatefulWidget {
  @override
  _PendingOrdersState createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  AuthService authService = Get.put(AuthService());
  OrderAssign orderAssign;
  @override
  void initState() {
    super.initState();

    setState(() {
      authService.getPendingOrders().then((value) {
        setState(() {
          orderAssign = OrderAssign.fromJson(jsonDecode(value.body));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: orderAssign != null
            ? Column(
                children: [
                  ...List.generate(1, (index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () => pushNewScreen(context,
                              screen: OrderDetails(
                                orderId: orderAssign.order,
                              ),
                              withNavBar: false),
                          child: Container(
                            height: 60,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: ListTile(
                              title: Text(
                                orderAssign.order.id.toString(),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              trailing: Text(
                                "See More",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                        YMargin(20)
                      ],
                    );
                  }),
                ],
              )
            : Container(
                height: 400,
                width: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                ),
              ),
      ),
    );
  }
}
