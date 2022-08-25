import 'package:flutter/material.dart';
import 'package:palnts/core/utils/extentions.dart';

class DefaultFormField extends StatelessWidget {
  const DefaultFormField(
      {Key? key,
      this.validate,
      this.onChange,
      this.isObscure = false,
      this.controller,
      required this.inputType})
      : super(key: key);

  final TextEditingController? controller;
  final TextInputType inputType;
  final bool isObscure;
  final String? Function(String?)? validate;
  final void Function(String)? onChange;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      obscureText: isObscure,
      onChanged: onChange,
      validator: validate,
      style: context.bodyText1,
      //  cursorColor: context.primaryColor,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

        border: OutlineInputBorder(
            // ignore: prefer_const_constructors
            borderSide: BorderSide(
              width: 1,
              color: context.primaryColor,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(8.0)),
        focusedBorder: OutlineInputBorder(
            // ignore: prefer_const_constructors
            borderSide: BorderSide(
              width: 1,
              color: context.primaryColor,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(8.0)),
        //enabledBorder: InputBorder.none,
        errorBorder: OutlineInputBorder(
            // ignore: prefer_const_constructors
            borderSide: BorderSide(
              width: 1,
              color: context.primaryColor,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }
}
