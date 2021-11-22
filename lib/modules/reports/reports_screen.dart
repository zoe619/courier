import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcourier/Model/receipt_dashboard_model.dart';
import 'package:tcourier/core/services/user_service.dart';
import 'package:tcourier/modules/reports/widgets/barchart_screen.dart';
import 'package:tcourier/utils/constants.dart';
import 'package:tcourier/utils/margin_utils.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key key}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;
  Future<ReceiptDashboardModel> _future;
  UserService userService = Get.put(UserService());
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _future = UserService().getUserDashboard();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        title: Text(
          "Reports",
          style: GoogleFonts.quicksand(
            color: redColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<ReceiptDashboardModel>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: height,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
            return Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  YMargin(10),
                  Container(
                    height: 30,
                    child: TabBar(
                      controller: _tabController,
                      // give the indicator a decoration (color and border radius)
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                        color: redColor,
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(
                          text: 'Balances',
                        ),
                        Tab(
                          text: 'Revenue',
                        ),
                        Tab(
                          text: "Net",
                        ),
                      ],
                    ),
                  ),
                  // tab bar view here
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // first tab bar view widget
                        Balances(
                          snapshot.data.startingBalance,
                          snapshot.data.currentBalance,
                        ),
                        // second tab bar view widget
                        RevenueTab(
                          snapshot.data.revenue.length,
                          snapshot.data.revenue,
                        ),
                        //third tab bar
                        Net(7),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              height: height,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}

class Balances extends StatelessWidget {
  final dynamic startBal;
  final dynamic currentBal;
  const Balances(
    this.startBal,
    this.currentBal, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          YMargin(20),
          Material(
            borderRadius: BorderRadius.circular(10),
            elevation: 1,
            child: Container(
              height: 160,
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Starting balance",
                        style: TextStyle(fontFamily: "popmedium"),
                      ),
                      Text(
                        "\$${this.startBal}",
                        style: TextStyle(fontFamily: "popbold", fontSize: 20),
                      ),
                    ],
                  ),
                  YMargin(10),
                  Divider(color: Colors.grey),
                  YMargin(10),
                  Divider(color: Colors.grey),
                  YMargin(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Current balance",
                        style: TextStyle(fontFamily: "popmedium"),
                      ),
                      Text(
                        "\$${this.currentBal}",
                        style: TextStyle(fontFamily: "popbold", fontSize: 20),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RevenueTab extends StatefulWidget {
  final int revenueLength;
  final List<Revenue> revenue;
  const RevenueTab(this.revenueLength, this.revenue, {Key key}) : super(key: key);

  @override
  _RevenueTabState createState() => _RevenueTabState();
}

class _RevenueTabState extends State<RevenueTab> {
  // List<String> days = ["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"];
  int isSelected = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            YMargin(10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...List.generate(widget.revenueLength, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          isSelected = index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isSelected == index ? Colors.red : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "${widget.revenue[index].day}",
                            style: TextStyle(
                              color: isSelected == index ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
            YMargin(10),
            Container(
              child: BarChartSample1(
                // lastWeekSales: snapshot.data.lastWeekSales,
                // currentWeekSales: snapshot.data.currentWeekSales,
                charts: widget.revenue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Net extends StatefulWidget {
  final int netLength;
  const Net(this.netLength, {Key key}) : super(key: key);

  @override
  _NetState createState() => _NetState();
}

class _NetState extends State<Net> {
  List<String> days = ["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"];
  int isSelected = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            YMargin(10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...List.generate(days.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          isSelected = index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isSelected == index ? Colors.red : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "${days[index]}",
                            style: TextStyle(
                              color: isSelected == index ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
            YMargin(10),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Center(
                child: Text("NET shows earnings excluding commissions"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
