import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tcourier/modules/dashboard/widgets/bar_chart_widget.dart';
import 'package:tcourier/utils/flushbar_utils.dart';
import 'package:tcourier/utils/margin_utils.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isOnline = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        title: Text(
          "Revenue",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontFamily: 'popbold'),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 34,
            ),
          ),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: [
          Container(
            width: double.maxFinite,
            height: screenHeight(context) / 4.5,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(45),
                bottomRight: Radius.circular(45),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                YMargin(50),
                Text(
                  "Total Revenue",
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontFamily: "popbold",
                  ),
                ),
                YMargin(8),
                Text(
                  "\$25",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontFamily: "popbold",
                  ),
                )
              ],
            ),
          ),
          YMargin(30),
          BarChartSample2(),
          YMargin(30),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
              width: double.maxFinite,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  YMargin(20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Order Received \n1",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Spacer(),
                        Text(
                          "Order Delivered \n0",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Today's Earnings \n\$0",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Spacer(),
                        Text(
                          "Monthly Earnings \n\$64",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  YMargin(20),
                ],
              ),
            ),
          ),
          YMargin(50),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: GestureDetector(
              onPanUpdate: (_) {
                if (_.delta.dx > 7) {
                  setState(() {
                    isOnline = true;
                  });
                  FlushbarUtils().showSuccessFlushbar(
                      "Online", "Courier Online!", context);
                } else if (_.delta.dx < 0) {
                  setState(() {
                    isOnline = false;
                  });
                  FlushbarUtils().showErrorFlushbar(
                      "Offline", "Courier Offline!", context);
                }
                return;
              },
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                width: double.maxFinite,
                height: 65,
                decoration: BoxDecoration(
                  color: isOnline == false ? Colors.red : Colors.green,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    isOnline == false ? XMargin(10) : Spacer(),
                    isOnline == false
                        ? Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Icon(
                              FontAwesomeIcons.arrowRight,
                              color: Colors.black,
                            ),
                          )
                        : SizedBox(),
                    XMargin(10),
                    Text(
                      isOnline == false
                          ? "Slide to Go Online"
                          : "Slide to Go Offline",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    XMargin(10),
                    isOnline == true
                        ? Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Icon(
                              FontAwesomeIcons.arrowLeft,
                              color: Colors.black,
                            ),
                          )
                        : SizedBox(),
                    isOnline == true ? XMargin(10) : SizedBox()
                  ],
                ),
              ),
            ),
          ),
          YMargin(50),
        ],
      ),
    );
  }
}
