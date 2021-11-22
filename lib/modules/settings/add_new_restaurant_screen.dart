import 'package:flutter/material.dart';
import 'package:tcourier/utils/margin_utils.dart';

class AddNewRestaurant extends StatefulWidget {
  @override
  _AddNewRestaurantState createState() => _AddNewRestaurantState();
}

class _AddNewRestaurantState extends State<AddNewRestaurant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        title: Text(
          "Add New Restaurant",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontFamily: 'popbold'),
        ),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: [
          YMargin(50),
          AddNewRestaurantWIdget(
            labelText: "Restaurant Name",
            hintText: "Mark Restaurant",
          ),
          YMargin(20),
          AddNewRestaurantWIdget(
            labelText: "Price for 3KM",
            hintText: "3 EUR",
          ),
          YMargin(20),
          AddNewRestaurantWIdget(
            labelText: "Additional KM price",
            hintText: "0.5 EUR KM",
          ),
          YMargin(50),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 60,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Center(
                child: Text(
                  "Connect Restaurant".toUpperCase(),
                  style: TextStyle(color: Colors.white, fontFamily: "popbold"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AddNewRestaurantWIdget extends StatelessWidget {
  final String labelText, hintText;
  const AddNewRestaurantWIdget({
    Key key,
    this.labelText,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        textCapitalization: TextCapitalization.none,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          contentPadding: EdgeInsets.all(18.0),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(14.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.5,
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(14.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(14.0),
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
      ),
    );
  }
}
