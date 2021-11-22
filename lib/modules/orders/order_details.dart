import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcourier/Model/OrderAssign.dart';
import 'package:tcourier/core/services/auth_service.dart';
import 'package:tcourier/utils/margin_utils.dart';

class OrderDetails extends StatefulWidget {
  OrderDetails({Key key, @required this.orderId}) : super(key: key);
  final Order orderId;
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
  AuthService authService = Get.put(AuthService());
  checkForInstalledMaps() async {
    // final availableMaps = await MapLauncher.installedMaps;
    // print(
    //     availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

    // await availableMaps.first.showMarker(
    //   coords: Coords(37.759392, -122.5107336),
    //   title: "Ocean Beach",
    // );
  }
  bool timer = true;
  @override
  void initState() {
    checkForInstalledMaps();
    super.initState();
  }

  void onEnd() {
    print('onEnd');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        title: Text(
          "Order Details",
          style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'popbold'),
        ),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: [
          YMargin(50),
          Center(
            child: Text(
              widget.orderId.pickupaddress ?? "Mark Restaurant",
              style: TextStyle(color: Colors.black, fontFamily: "popbold", fontSize: 30),
            ),
          ),
          YMargin(15),
          Center(
            child: Text(
              widget.orderId.pickupaddress ?? "Address",
              style: TextStyle(color: Colors.black, fontFamily: "popmedium", fontSize: 20),
            ),
          ),
          YMargin(20),
          // Center(
          //   child: CircleAvatar(
          //     minRadius: 60,
          //     maxRadius: 120,
          //     child: Center(
          //       child: CountdownTimer(
          //         controller: controller,
          //         onEnd: onEnd,
          //         endTime: endTime,
          //       ),
          //       // child: Text("Pickup in 2 mins"),
          //     ),
          //   ),
          // ),
          YMargin(50),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Customer Info: ",
                  style: TextStyle(color: Colors.black, fontFamily: "popmedium", fontSize: 20),
                ),
                XMargin(5),
                Text(
                  "Frank B.",
                  style: TextStyle(color: Colors.black, fontFamily: "popbold", fontSize: 20),
                )
              ],
            ),
          ),
          YMargin(20),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Payment Method: ",
                  style: TextStyle(color: Colors.black, fontFamily: "popmedium", fontSize: 20),
                ),
                XMargin(5),
                Text(
                  widget.orderId.coustomerId ?? "Cash",
                  style: TextStyle(color: Colors.black, fontFamily: "popbold", fontSize: 20),
                )
              ],
            ),
          ),
          YMargin(50),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20, right: 20),
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Expanded(
          //         child: GestureDetector(
          //           onTap: () async {
          //             await storage.read(key: "token").then(
          //                   (value) => authService
          //                       .acceptOrderRequest(widget.orderId.id, value)
          //                       .then(
          //                     (value) {
          //                       if (value.statusCode == 200) {
          //                         getDirectionsDialog(context);
          //                         print(value.body.toString());
          //                         Get.snackbar(
          //                             "You Accept this Order", "Order Accept");
          //                       } else {
          //                         Get.snackbar("Error!",
          //                             "Order Not Accepted, try again");
          //                       }
          //                     },
          //                   ),
          //                 );
          //             //     .then((value) =>
          //             // FlushbarUtils().showSuccessFlushbar(
          //             //
          //             // "Order Accepted", "You Accepted this Order ", context)));
          //             // popView(context);
          //           },
          //           child: Container(
          //             height: 70,
          //             width: 150,
          //             decoration: BoxDecoration(
          //               color: Colors.green,
          //               borderRadius: BorderRadius.all(
          //                 Radius.circular(20),
          //               ),
          //             ),
          //             child: Center(
          //               child: Text(
          //                 "Accept".toUpperCase(),
          //                 style: TextStyle(
          //                     fontFamily: "popmedium",
          //                     color: Colors.white,
          //                     fontSize: 20),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //       XMargin(15),
          //       Expanded(
          //         child: GestureDetector(
          //           onTap: () async {
          //             await storage.read(key: "token").then(
          //                   (value) => authService
          //                       .rejectRequest(widget.orderId, value)
          //                       .then(
          //                     (value) {
          //                       if (value == 200) {
          //                       } else {
          //                         Get.snackbar("You Rejected this Order",
          //                             "Order Rejected");
          //                       }
          //                     },
          //                   ),
          //                 );
          //             //     .then((value) =>
          //             // FlushbarUtils().showErrorFlushbar(
          //             //     "Order Rejected", "You Rejected this Order", context)));
          //             // popView(context);
          //           },
          //           child: Container(
          //             height: 70,
          //             width: 150,
          //             decoration: BoxDecoration(
          //               color: Colors.red,
          //               borderRadius: BorderRadius.all(
          //                 Radius.circular(20),
          //               ),
          //             ),
          //             child: Center(
          //               child: Text(
          //                 "Reject".toUpperCase(),
          //                 style: TextStyle(
          //                     fontFamily: "popmedium",
          //                     color: Colors.white,
          //                     fontSize: 20),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  // launchMap() async {
  //   if (await MapLauncher.isMapAvailable(MapType.google)) {
  //     await MapLauncher.showMarker(
  //       mapType: MapType.google,
  //       coords: Coords(37.759392, -122.5107336),
  //       title: "Directions",
  //       // description: description,
  //     );
  //   }
  // }

  // getDirectionsDialog(BuildContext buildContext) => showDialog(
  //     context: buildContext,
  //     builder: (buildContext) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(10))),
  //         child: Container(
  //           width: MediaQuery.of(buildContext).size.width / 1.1,
  //           height: MediaQuery.of(buildContext).size.height / 4.5,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               YMargin(30),
  //               Center(
  //                 child: Text(
  //                   "Get Directions?",
  //                   style: TextStyle(
  //                       color: Colors.black,
  //                       fontFamily: 'popbold',
  //                       fontSize: 20),
  //                 ),
  //               ),
  //               YMargin(30),
  //               Padding(
  //                 padding: const EdgeInsets.only(left: 20, right: 20),
  //                 child: Row(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Expanded(
  //                       child: GestureDetector(
  //                         onTap: () {
  //                           popView(buildContext);
  //                           navigate(buildContext, MapView());
  //                         },
  //                         child: Container(
  //                           height: 50,
  //                           width: 50,
  //                           decoration: BoxDecoration(
  //                             color: Colors.green,
  //                             borderRadius: BorderRadius.all(
  //                               Radius.circular(20),
  //                             ),
  //                           ),
  //                           child: Center(
  //                             child: Text(
  //                               "Yes".toUpperCase(),
  //                               style: TextStyle(
  //                                   fontFamily: "popmedium",
  //                                   color: Colors.white,
  //                                   fontSize: 20),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     XMargin(15),
  //                     Expanded(
  //                       child: GestureDetector(
  //                         onTap: () {
  //                           FlushbarUtils().showErrorFlushbar("Order Rejected",
  //                               "You Rejected this Order", context);
  //                           popView(context);
  //                         },
  //                         child: Container(
  //                           height: 50,
  //                           width: 50,
  //                           decoration: BoxDecoration(
  //                             color: Colors.red,
  //                             borderRadius: BorderRadius.all(
  //                               Radius.circular(20),
  //                             ),
  //                           ),
  //                           child: Center(
  //                             child: Text(
  //                               "No".toUpperCase(),
  //                               style: TextStyle(
  //                                   fontFamily: "popmedium",
  //                                   color: Colors.white,
  //                                   fontSize: 20),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     });
}
