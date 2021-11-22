import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tcourier/Model/ongoing_order_item_model.dart';
import 'package:tcourier/modules/orders/orderpinverification.dart';
import 'package:tcourier/utils/constants.dart';
import 'package:tcourier/utils/margin_utils.dart';

class OngoingOrderDetails extends StatefulWidget {
  final OngoingOrderItemModel ongoingOrderItemModel;
  final bool isCompleted;
  const OngoingOrderDetails({this.ongoingOrderItemModel, this.isCompleted});
  @override
  _OngoingOrderDetailsState createState() => _OngoingOrderDetailsState();
}

class _OngoingOrderDetailsState extends State<OngoingOrderDetails> {
  _callNumber(String phoneNumber) async {
    // phoneNumber;
    await FlutterPhoneDirectCaller.callNumber(phoneNumber);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("ece9e9"),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        title: Text(
          "Delivery Details",
          style: TextStyle(color: Colors.white, fontFamily: 'popbold'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.isCompleted == true ? Container() : YMargin(50),
            widget.isCompleted == true
                ? Container()
                : Center(
                    child: Column(
                      children: [
                        Text(
                          "Estimated Delivery Period",
                          style: TextStyle(
                            fontFamily: "popmedium",
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "${widget.ongoingOrderItemModel.humanTime}",
                          style: TextStyle(
                            fontFamily: "popbold",
                            fontSize: 26,
                          ),
                        )
                      ],
                    ),
                  ),
            YMargin(50),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: widget.isCompleted == true
                    ? MediaQuery.of(context).size.height / 1.1
                    : MediaQuery.of(context).size.height / 2,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: SingleChildScrollView(
                  // physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      YMargin(20),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: [
                            Text(
                              "order no: ".toUpperCase(),
                              style: TextStyle(fontSize: 18, fontFamily: "popmedium"),
                            ),
                            // Spacer(),
                            Text(
                              "#${widget.ongoingOrderItemModel.id}",
                              style: TextStyle(fontSize: 18, fontFamily: "popbold"),
                            ),
                          ],
                        ),
                      ),
                      YMargin(30),
                      Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: OrderListDetails(
                            iconData: FontAwesomeIcons.userAlt,
                            label: "Clients Name",
                            text: "${widget.ongoingOrderItemModel.consumerName}",
                          )),
                      YMargin(30),
                      Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: InkWell(
                            onTap: () {
                              _callNumber(widget.ongoingOrderItemModel.consumerPhoneNumber);
                            },
                            child: OrderListDetails(
                              iconData: FontAwesomeIcons.phone,
                              label: "Clients Number",
                              text: "${widget.ongoingOrderItemModel.consumerPhoneNumber}",
                              isPhone: true,
                            ),
                          )),
                      YMargin(30),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: OrderListDetails(
                          iconData: FontAwesomeIcons.locationArrow,
                          label: "Client Location",
                          text: "${widget.ongoingOrderItemModel.consumerAddress}",
                        ),
                      ),
                      YMargin(30),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: OrderListDetails(
                          iconData: FontAwesomeIcons.building,
                          label: "Client Apartment",
                          text: "${widget.ongoingOrderItemModel.building}",
                        ),
                      ),
                      YMargin(30),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: OrderListDetails(
                          iconData: FontAwesomeIcons.locationArrow,
                          label: "Restaurant Location",
                          text: "${widget.ongoingOrderItemModel.customerAddress}",
                        ),
                      ),
                      YMargin(30),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: InkWell(
                          onTap: () {
                            _callNumber(widget.ongoingOrderItemModel.customerPhoneNumber);
                          },
                          child: OrderListDetails(
                            iconData: FontAwesomeIcons.phone,
                            label: "Restaurant phone number",
                            text: "${widget.ongoingOrderItemModel.customerPhoneNumber}",
                          ),
                        ),
                      ),
                      YMargin(30),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: DeliveryNoteWidget(
                          iconData: FontAwesomeIcons.book,
                          label: widget.ongoingOrderItemModel.comment == null
                              ? "Delivery note"
                              : "${widget.ongoingOrderItemModel.comment}",
                        ),
                      ),
                      YMargin(30),
                    ],
                  ),
                ),
              ),
            ),
            YMargin(20),
            widget.isCompleted == true
                ? Container()
                : Center(
                    child: Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        color: redColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(
                            () => DeliveryVerificationScreen(
                              clientName: "${widget.ongoingOrderItemModel.consumerName}",
                            ),
                            transition: Transition.downToUp,
                            duration: Duration(milliseconds: 500),
                          );
                        },
                        child: Text("Confirm Delivery"),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
            YMargin(10),
          ],
        ),
      ),
    );
  }
}

class OrderListDetails extends StatelessWidget {
  final IconData iconData;
  final String label, text;
  final bool isPhone;

  const OrderListDetails({
    Key key,
    this.iconData,
    this.label,
    this.text,
    this.isPhone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 20,
            child: isPhone == true
                ? RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      iconData,
                      size: 18,
                    ),
                  )
                : Icon(
                    iconData,
                    size: 18,
                  ),
          ),
          XMargin(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                ),
                Text(
                  text,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DeliveryNoteWidget extends StatelessWidget {
  final IconData iconData;
  final String label;

  const DeliveryNoteWidget({Key key, this.iconData, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 20,
            child: Icon(
              iconData,
              size: 18,
            ),
          ),
          XMargin(20),
          Expanded(
            child: TextFormField(
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              textCapitalization: TextCapitalization.none,
              textAlignVertical: TextAlignVertical.bottom,
              textAlign: TextAlign.start,
              maxLines: 5,
              enabled: false,
              inputFormatters: [LengthLimitingTextInputFormatter(200)],
              decoration: InputDecoration(
                // counterText: '',
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
                labelText: label,
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                hintText: "Lorem Ipsum",
                hintStyle: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.withOpacity(0.2),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
