// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:palnts/core/utils/extentions.dart';

class SeparetorWidget extends StatelessWidget {
  const SeparetorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Divider(
            thickness: 1.5,
            indent: 10,
            endIndent: 10,
          ),
        ),
        Text(
          'or continue with ',
          style: context.caption,
        ),
        Expanded(
            child: Divider(
          thickness: 1.5,
          indent: 10,
          endIndent: 10,
        ))
      ],
    );
  }
}
