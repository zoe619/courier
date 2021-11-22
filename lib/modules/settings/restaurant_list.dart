import 'package:flutter/material.dart';
import 'package:tcourier/utils/margin_utils.dart';

class RestaurantList extends StatefulWidget {
  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  List<Map<String, dynamic>> _res = [
    {"header": "Mark's Restaurant", "body": "No 17, Talinn Close"},
    {"header": "Jozy's Restaurant", "body": "No 17, Code Close"},
    {"header": "Lizzy's Choice", "body": "No 5, Wrick Close"},
    {"header": "Ford's Shop", "body": "No 17, Deutsche Close"},
    {"header": "Mark's Restaurant", "body": "No 17, Talinn Close"},
    {"header": "Mark's Restaurant", "body": "No 17, Talinn Close"}
  ];
  List<Item> generateItems(int numberOfItems) {
    return List.generate(numberOfItems, (int index) {
      return Item(
        headerValue: _res[index]["header"],
        expandedValue: _res[index]["body"],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Item> res = generateItems(_res.length);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        title: Text(
          "Restaurant List",
          style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'popbold'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              YMargin(20),
              ExpansionPanelList(
                animationDuration: Duration(milliseconds: 300),
                expansionCallback: (int index, bool isExpanded) {
                  print("index expanded ${res[index].isExpanded}");
                  setState(() {
                    res[index].isExpanded = !isExpanded;
                  });
                },
                children: res.map<ExpansionPanel>((Item item) {
                  return ExpansionPanel(
                    canTapOnHeader: true,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text(item.headerValue),
                      );
                    },
                    body: ListTile(
                      title: Text(item.headerValue),
                      subtitle: Text(item.expandedValue),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 0),
                        onPressed: () => showSuspendRes(context, item.headerValue),
                        child: Text(
                          "Suspend",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                    isExpanded: item.isExpanded,
                  );
                }).toList(),
              ),
              YMargin(20),
            ],
          ),
        ),
      ),
    );
  }

  showSuspendRes(BuildContext buildContext, String resName) => showDialog(
      context: buildContext,
      builder: (buildContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Container(
            width: MediaQuery.of(buildContext).size.width / 1.1,
            height: MediaQuery.of(buildContext).size.height / 4.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                YMargin(30),
                Center(
                  child: Text(
                    "Suspend $resName",
                    style: TextStyle(color: Colors.black, fontFamily: 'popbold', fontSize: 20),
                  ),
                ),
                YMargin(30),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "yes".toUpperCase(),
                                style: TextStyle(
                                    fontFamily: "popmedium", color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      XMargin(15),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // FlushbarUtils().showErrorFlushbar("Order Rejected",
                            //     "You Rejected this Order", context);
                            // popView(context);
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "No".toUpperCase(),
                                style: TextStyle(
                                    fontFamily: "popmedium", color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}
