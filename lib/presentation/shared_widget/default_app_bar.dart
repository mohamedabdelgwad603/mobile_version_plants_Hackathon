// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:palnts/core/utils/extentions.dart';

import '../../config/styles/icon_broken.dart';
import 'default_divider.dart';

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar(
      {Key? key, required this.text, this.onPressedArrowBack, this.action})
      : super(key: key);
  final String text;
  final Widget? action;

  final VoidCallback? onPressedArrowBack;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Row(
            children: [
              MaterialButton(
                  padding: EdgeInsets.zero,
                  minWidth: 1,
                  onPressed: onPressedArrowBack,
                  child: Icon(
                    IconBroken.Arrow___Left_2,
                    size: 22,
                    color: context.primaryColor,
                  )),
              SizedBox(
                width: 17,
              ),
              Text(text, style: context.subtitle1),
              if (action != null) Spacer(),
              action ??
                  Container(
                    height: 0,
                  ),
              if (action != null)
                SizedBox(
                  width: 10,
                )
            ],
          ),
        ),
        DefaultDivider(),
      ],
    );
  }
}
