import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:tcourier/core/controllers/courier_orders_controller.dart';
import 'package:tcourier/modules/orders/ongoing_order_details.dart';
import 'package:tcourier/utils/margin_utils.dart';

// class CompletedOrders extends StatefulWidget {
//   @override
//   _CompletedOrdersState createState() => _CompletedOrdersState();
// }

// class _CompletedOrdersState extends State<CompletedOrders> {
//   CourierOrderService authService = Get.put(CourierOrderService());
//   CompletedOrder orderAssign;
//   List<CompletedOrder> listCompletedOrder = [];
//   Future<http.Response> _future;

//   @override
//   void initState() {
//     super.initState();
//     setState(
//       () {
//         authService.getCompletedOrders().then(
//           (value) {
//             setState(
//               () {
//                 List<dynamic> completedOrderList = jsonDecode(value.body)['order'];
//                 print(completedOrderList);
//                 completedOrderList.map(
//                   (e) {
//                     setState(
//                       () {
//                         orderAssign = CompletedOrder.fromJson(e);
//                         print(orderAssign);
//                         listCompletedOrder.add(orderAssign);
//                         print(listCompletedOrder.length);
//                       },
//                     );
//                   },
//                 );
//               },
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return Material(
//       color: Colors.white,
//       child: Column(
//         children: [
//           listCompletedOrder.isNotEmpty
//               ? ListView.builder(
//                   scrollDirection: Axis.vertical,
//                   shrinkWrap: true,
//                   itemCount: listCompletedOrder.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Column(
//                       children: [
//                         CompletedOrdersWidget(
//                           title: listCompletedOrder[index].id.toString(),
//                         ),
//                         YMargin(10)
//                       ],
//                     );
//                   })
//               : Container(
//                   height: height / 1.7,
//                   width: width,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Center(child: Text("No Orders")),
//                     ],
//                   ),
//                 ),
//           //  Container(
//           //     height: 400,
//           //     child: Center(child: CircularProgressIndicator()),
//           //   ),
//         ],
//       ),
//     );
//   }
// }

class CompletedOrders extends StatelessWidget {
  const CompletedOrders({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final obj = Get.put(GetCompletedCourierOrdersController());
    return Scaffold(
      body: Obx(
          // ignore: missing_return
          () {
        if (obj.dataAvailable) {
          if (obj.trx.data.length == 0) {
            return Container(
              height: height / 1.7,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text("No Orders Completed"),
                  ),
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ...List.generate(obj.trx.data.length, (index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () => pushNewScreen(context,
                              screen: OngoingOrderDetails(
                                ongoingOrderItemModel: obj.trx.data[index],
                                isCompleted: true,
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
                                "${obj.trx.data[index].itemDescription}",
                                style: TextStyle(color: Colors.black, fontSize: 14),
                              ),
                              trailing: Text(
                                "View Details",
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
              ),
            );
          }
        } else {
          return Container(
            height: 400,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      }),
    );
  }
}
