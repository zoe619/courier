import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:tcourier/core/controllers/courier_orders_controller.dart';
import 'package:tcourier/modules/orders/ongoing_order_details.dart';
import 'package:tcourier/utils/margin_utils.dart';

// class OngoingOrders extends StatefulWidget {
//   @override
//   _OngoingOrdersState createState() => _OngoingOrdersState();
// }

// class _OngoingOrdersState extends State<OngoingOrders> {
//   Future<OngoingOrdersModel> _future;
//   @override
//   void initState() {
//     super.initState();

//     _future = CourierOrderService().getOngoingOrders();
//   }

//   @override
//   Widget build(BuildContext context) {
// double height = MediaQuery.of(context).size.height;
// double width = MediaQuery.of(context).size.width;
//     return Material(
//       color: Colors.white,
//       child: SingleChildScrollView(
//         // ignore: missing_return
//         child: FutureBuilder<OngoingOrdersModel>(
//             future: _future,
//             // ignore: missing_return
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 if (snapshot.data == null || snapshot.data.data == null) {
// return Container(
//   height: height / 1.7,
//   width: width,
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       Center(child: Text("No Orders")),
//     ],
//   ),
// );
//                 } else {
//                   var snapData = snapshot.data.data;
//                   return Column(
//                     children: [
//   ...List.generate(snapData.length, (index) {
//     return Column(
//       children: [
//         GestureDetector(
//           onTap: () => pushNewScreen(context,
//               screen: OngoingOrderDetails(), withNavBar: false),
//           child: Container(
//             height: 60,
//             width: double.maxFinite,
//             decoration: BoxDecoration(
//               color: Colors.grey.withOpacity(0.2),
//               borderRadius: BorderRadius.all(
//                 Radius.circular(15),
//               ),
//             ),
//             child: ListTile(
//               title: Text(
//                 "Chicken Soup",
//                 style: TextStyle(color: Colors.black, fontSize: 14),
//               ),
//               trailing: Text(
//                 "View Details",
//                 style: TextStyle(fontSize: 12),
//               ),
//             ),
//           ),
//         ),
//         YMargin(20)
//       ],
//     );
//   }),
// ],
//                   );
//                 }
//               } else {
// return Container(
//   height: 400,
//   child: Center(
//     child: CircularProgressIndicator(),
//   ),
// );
//               }
//             }),
//       ),
//     );
//   }
// }

class OngoingOrders extends StatelessWidget {
  const OngoingOrders({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final obj = Get.put(GetOngoingCourierOrdersController());

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
                    child: Text("No Orders"),
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
                                isCompleted: false,
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
                                "# ${obj.trx.data[index].id}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
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
