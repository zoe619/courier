import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tcourier/utils/margin_utils.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {},
          child: Icon(FontAwesomeIcons.solidBell),
        ),
        title: Text(
          "Orders",
          style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'popbold'),
        ),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: [
          YMargin(20),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pending Orders".toUpperCase(),
                  style: TextStyle(color: Colors.black, fontFamily: "popbold", fontSize: 18),
                ),
                YMargin(10),
                GestureDetector(
                  onTap: () {
                    // Get.to(() => OrderDetails());
                  },
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
                        "Big Burger and Fries",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      trailing: Text(
                        "See More",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          YMargin(30),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ongoing Orders".toUpperCase(),
                  style: TextStyle(color: Colors.black, fontFamily: "popbold", fontSize: 18),
                ),
                YMargin(10),
                ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded) {},
                  children: [
                    ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Text('Item 2'),
                          );
                        },
                        body: Container(
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
                              "Big Burger and Fries",
                              style: TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            trailing: Text(
                              "See More",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        isExpanded: true,
                        canTapOnHeader: true),
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text('Item 2'),
                        );
                      },
                      body: ListTile(
                        title: Text('Item 2 child'),
                        subtitle: Text('Details goes here'),
                      ),
                      isExpanded: false,
                    ),
                  ],
                )
              ],
            ),
          ),
          YMargin(30),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Completed Orders".toUpperCase(),
                  style: TextStyle(color: Colors.black, fontFamily: "popbold", fontSize: 18),
                ),
                YMargin(10),
                CompletedOrdersWidget(
                  title: "Chicken and Chips",
                ),
                YMargin(10),
                CompletedOrdersWidget(
                  title: "Groceries",
                ),
                YMargin(10),
                CompletedOrdersWidget(
                  title: "Yam and Egg",
                ),
                YMargin(10),
                CompletedOrdersWidget(
                  title: "Pasta",
                ),
                YMargin(10),
                CompletedOrdersWidget(
                  title: "Pizza",
                ),
                YMargin(10),
                CompletedOrdersWidget(
                  title: "Snacks and Drinks",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CompletedOrdersWidget extends StatelessWidget {
  final String title;
  const CompletedOrdersWidget({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          title,
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
        trailing: Text(
          "Completed",
          style: TextStyle(fontSize: 12, color: Colors.green),
        ),
      ),
    );
  }
}
