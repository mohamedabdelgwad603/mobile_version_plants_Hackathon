// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:palnts/core/utils/extentions.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton(
      {Key? key,
      required this.text,
      this.color = Colors.green,
      this.width = double.infinity,
      this.height = 35,
      this.isBorder = false,
      this.textColor,
      required this.onpressed})
      : super(key: key);
  final String text;
  final double? width;
  final double? height;
  final Color color;
  final Color? textColor;
  final VoidCallback onpressed;
  final bool isBorder;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: isBorder ? Border.all() : null),
      child: MaterialButton(
        onPressed: onpressed,
        child: Text(
          text,
          style: context.button?.copyWith(color: textColor),
        ),
      ),
    );
  }
}
