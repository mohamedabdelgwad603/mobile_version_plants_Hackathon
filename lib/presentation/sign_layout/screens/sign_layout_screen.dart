// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:palnts/core/utils/app_colors.dart';
import 'package:palnts/core/utils/assets_manger.dart';
import 'package:palnts/presentation/login/login_screen.dart';
import 'package:palnts/presentation/register/register_screen.dart';

import '../../../core/utils/app_strings.dart';

class SignLayoutScreen extends StatelessWidget {
  const SignLayoutScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Container(
            height: 100,
            alignment: Alignment.topRight,
            child: Image.asset(
              ImgAssets.tree,
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                ImgAssets.logo,
                height: 40,
              ),
              Image.asset(
                ImgAssets.textLogo,
                height: 13,
              ),
            ],
          ),
          Expanded(
            child: DefaultTabController(
              initialIndex: 0,
              length: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TabBar(
                    padding: EdgeInsets.all(20) - EdgeInsets.only(bottom: 20),
                    indicatorPadding: EdgeInsets.zero,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: Colors.grey,
                    //  isScrollable: true,
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: AppStrings.fontFamily,
                        fontSize: 16),
                    indicator: UnderlineTabIndicator(
                        borderSide:
                            BorderSide(width: 2.0, color: AppColors.primary),
                        insets: EdgeInsets.symmetric(
                            horizontal: 60.0, vertical: 0)),

                    // ignore: prefer_const_literals_to_create_immutables
                    tabs: [
                      Tab(
                        text: 'Sign up',
                      ),
                      Tab(
                        text: 'Login',
                      ),
                    ],
                  ),
                  Expanded(
                      child: TabBarView(
                          children: [RegisterScreen(), LoginScreeen()])),
                ],
              ),
            ),
          ),
          Container(
            height: 70,
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              ImgAssets.bottomTree,
            ),
          ),
        ],
      ),
    );
  }
}
