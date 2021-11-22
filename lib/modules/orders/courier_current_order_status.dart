import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdi/mdi.dart';
import 'package:tcourier/utils/constants.dart';
import 'package:tcourier/utils/margin_utils.dart';

import 'orderpinverification.dart';

class CourierCurrentStatus extends StatefulWidget {
  @override
  _CourierCurrentStatusState createState() => _CourierCurrentStatusState();
}

class _CourierCurrentStatusState extends State<CourierCurrentStatus> {
  List<String> statuses = ["Order Accepted", "Order picked up", "In Transit", "Order delivered"];
  List<Color> newColor = [Colors.grey, Colors.grey, Colors.grey, Colors.grey];
  bool isCompleted = false;
  List<bool> stepCompleted = [false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YMargin(10),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Text(
          //       "What's your status?",
          // style: GoogleFonts.montserrat(
          //   color: Colors.black,
          //   fontWeight: FontWeight.bold,
          //   fontSize: 25,
          // ),
          //     ),
          //     Text(
          //       "Update your delivery status on-the-go",
          //       style: GoogleFonts.montserrat(
          //         color: Colors.grey,
          //         fontSize: 17,
          //       ),
          //     ),
          //   ],
          // ),
          // YMargin(50),
          Text(
            "Order #234",
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Divider(),
          YMargin(10),
          ...List.generate(
            4,
            (index) {
              return GestureDetector(
                onTap: () {
                  setState(
                    () {
                      newColor[index] = stepCompleted[index] == false ? Colors.green : Colors.grey;
                      stepCompleted[index] = !stepCompleted[index];
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        stepCompleted[index] == true
                            ? Icon(
                                Mdi.circleSlice8,
                                color: Colors.green,
                              )
                            : Icon(Icons.circle_outlined),
                        Container(
                          height: 50,
                          width: 2,
                          color: stepCompleted[index] == true ? Colors.green : newColor[index],
                        ),
                      ],
                    ),
                    //circle slice 8
                    XMargin(10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${statuses[index]}",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, top: 5, bottom: 5),
                          child: Container(
                            height: 40,
                            width: 2,
                            color: stepCompleted[index] == true ? Colors.green : newColor[index],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isCompleted = true;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    isCompleted == true
                        ? Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                          )
                        : Icon(Icons.circle_outlined),
                    // Container(
                    //   height: 50,
                    //   width: 2,
                    //   color: redColor,
                    // ),
                  ],
                ),
                //circle slice 8
                XMargin(10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Completed",
                      style: GoogleFonts.montserrat(
                        // fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          YMargin(5),
          Divider(
            color: Colors.black,
          ),
          YMargin(20),
          Center(
            child: Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                color: redColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton(
                onPressed: isCompleted == true
                    ? () {
                        Get.to(
                          () => DeliveryVerificationScreen(
                            clientName: "Ovienloba Joel",
                          ),
                          transition: Transition.downToUp,
                          duration: Duration(milliseconds: 500),
                        );
                      }
                    : null,
                child: Text(
                  "Confirm Delivery",
                  style: GoogleFonts.montserrat(
                    color: isCompleted == true ? Colors.white : Colors.grey,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          YMargin(70),
        ],
      ),
    );
  }
}
