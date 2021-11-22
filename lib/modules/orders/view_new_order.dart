import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tcourier/core/controllers/courier_orders_controller.dart';
import 'package:tcourier/modules/orders/delivery_status_update.dart';
import 'package:tcourier/utils/constants.dart';
import 'package:tcourier/utils/margin_utils.dart';

class ViewNewOrder extends StatefulWidget {
  @override
  _ViewNewOrderState createState() => _ViewNewOrderState();
}

class _ViewNewOrderState extends State<ViewNewOrder> {
  CourierOrderService courierOrderService = Get.put(CourierOrderService());
  bool _isLoading;
  int timerValue = 60;
  Future<Position> _currentLocation;
  GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    _currentLocation = Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (mounted) {
      Future.delayed(Duration(seconds: 1), () {
        if (timerValue > 0) {
          setState(() {
            timerValue -= 1;
          });
        } else {
          // Get.back();
          courierOrderService.rejectOrder(123).then((value) {}).whenComplete(() {
            Get.back();
            Get.snackbar("Rejected", "Order Rejected");
          });
        }
      });
    }
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: height / 2,
                      width: width,
                      color: Colors.black,
                      child: FutureBuilder(
                          future: _currentLocation,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              if (snapshot.hasData) {
                                // The user location returned from the snapshot
                                Position snapshotData = snapshot.data;
                                LatLng _userLocation =
                                    LatLng(snapshotData.latitude, snapshotData.longitude);
                                return GoogleMap(
                                  onMapCreated: (GoogleMapController controller) {
                                    mapController = controller;
                                  },
                                  mapType: MapType.normal,
                                  // onCameraMove: (position) {
                                  //   print("ahhhhhhhhhh  ====>>> $position");
                                  // },
                                  buildingsEnabled: true,
                                  myLocationButtonEnabled: true,
                                  myLocationEnabled: true,
                                  initialCameraPosition: CameraPosition(
                                    target: _userLocation,
                                    zoom: 12,
                                  ),
                                );
                              } else {
                                return Center(child: Text("Failed to get user location."));
                              }
                            }
                            // While the connection is not in the done state yet
                            return Center(child: CircularProgressIndicator());
                          }),
                    ),
                    Container(
                      // height: 270,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Text(
                                        "$timerValue",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Spacer(),
                                    Icon(
                                      Icons.delivery_dining,
                                      color: redColor,
                                    ),
                                    Spacer(),
                                  ],
                                ),
                                YMargin(15),
                                Text(
                                  "$euro 5.70",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                                Divider(),
                                Text(
                                  "10 min total  .  3.2 mi",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                                YMargin(20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.location_pin,
                                      size: 15,
                                      color: Colors.grey,
                                    ),
                                    XMargin(3),
                                    Expanded(
                                      child: Text(
                                        "Kilimanjaro, Gideon Street, Rumuagholu, Ph",
                                        style: TextStyle(
                                          color: Colors.black,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                        // overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                YMargin(10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 15,
                                      color: Colors.grey,
                                    ),
                                    XMargin(3),
                                    Text(
                                      "NE 14 Bells drive",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          YMargin(10),
                          _isLoading == true
                              ? CircularProgressIndicator()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 60,
                                      width: 300,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: redColor,
                                        ),
                                        onPressed: () {
                                          Get.off(
                                            () => DeliveryStatusUpdate(lat: 4.8156, lng: 7.0498),
                                          );
                                          // courierOrderService.acceptOrder(123).then((value) {
                                          //   Get.back();
                                          // }).whenComplete(() {
                                          //   Get.snackbar("Accepted", "Order Accepted");
                                          // });
                                        },
                                        child: Text(
                                          "Accept",
                                          style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          YMargin(10),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, top: 20),
                  child: Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        courierOrderService.rejectOrder(123).then((value) {
                          Get.back();
                        }).whenComplete(() {
                          Get.snackbar("Rejected", "Order Rejected");
                        });
                      },
                      child: Text(
                        "REJECT",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
