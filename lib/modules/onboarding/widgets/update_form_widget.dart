import 'package:flutter/material.dart';

class UpdateFormWidget extends StatelessWidget {
  final IconData iconData;
  final String labelText, hintText;
  final bool isPassword;
  final TextEditingController controller;
  final TextInputType type;
  final dynamic validator;
  const UpdateFormWidget({
    Key key,
    this.iconData,
    this.validator,
    this.controller,
    this.labelText,
    this.hintText,
    this.type,
    this.isPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      controller: controller,
      textCapitalization: TextCapitalization.none,
      textAlignVertical: TextAlignVertical.bottom,
      obscureText: isPassword == true ? true : false,
      // validator: validator,
      decoration: InputDecoration(
        counterText: '',
        suffixIcon: Icon(
          iconData,
          color: Colors.red,
        ),
        filled: true,
        // fillColor: HexColor(fillColorCode),
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
            color: Colors.red,
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
    );
  }
}
