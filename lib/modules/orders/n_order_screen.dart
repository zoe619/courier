import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcourier/modules/orders/tabs/completed.dart';
import 'package:tcourier/modules/orders/tabs/ongoing.dart';
import 'package:tcourier/utils/constants.dart';
import 'package:tcourier/utils/margin_utils.dart';

class NOrdersScreen extends StatefulWidget {
  @override
  _NOrdersScreenState createState() => _NOrdersScreenState();
}

class _NOrdersScreenState extends State<NOrdersScreen>
    with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, initialIndex: 0, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        title: Text(
          "Orders",
          style: GoogleFonts.quicksand(
            color: redColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: [
          YMargin(5),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Center(
              child: Container(
                height: 30,
                child: buildOrdersTab(),
              ),
            ),
          ),
          YMargin(15),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.maxFinite,
              child: buildOrdersTabBarView(),
            ),
          ),
          YMargin(25)
        ],
      ),
    );
  }

  TabBar buildOrdersTab() {
    double width = MediaQuery.of(context).size.width;

    double yourWidth = width / 1.6;
    return TabBar(
      // indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: redColor,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.black,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(
          25.0,
        ),
        color: redColor,
      ),
      tabs: [
        Container(
          width: yourWidth,
          child: Center(
            child: Text(
              "Ongoing",
            ),
          ),
        ),
        Container(
          width: yourWidth,
          child: Center(
            child: Text(
              "Completed",
            ),
          ),
        )
      ],
      controller: tabController,
    );
  }

  TabBarView buildOrdersTabBarView() {
    return TabBarView(
        controller: tabController,
        children: [OngoingOrders(), CompletedOrders()]);
  }
}
