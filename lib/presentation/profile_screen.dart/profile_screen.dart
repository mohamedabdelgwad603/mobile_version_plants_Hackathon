// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palnts/core/utils/app_colors.dart';
import 'package:palnts/core/utils/assets_manger.dart';
import 'package:palnts/core/utils/extentions.dart';
import 'package:palnts/core/utils/hex_color.dart';
import 'package:palnts/presentation/shared_cubit/app_cubit.dart';
import 'package:palnts/presentation/shared_cubit/app_states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = BlocProvider.of<AppCubit>(context).loginModel;
        return Scaffold(
          body: SafeArea(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
              child: Stack(children: [
                Image.asset(
                  ImgAssets.myPhoto,
                  fit: BoxFit.cover,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    color: Colors.black.withOpacity(.7),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_outlined,
                                color: Colors.white,
                                size: 30,
                              )),
                          // Spacer(),
                          Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                          )
                        ],
                      ),
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage(
                          ImgAssets.myPhoto,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Mohamed abd elGwad",
                        style: context.subtitle2?.copyWith(color: Colors.white),
                      ),
                    ]),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(30),
                    height: MediaQuery.of(context).size.height * .62,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          decoration: BoxDecoration(
                              color: HexColor('#f3fef1'),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Container(
                                  height: 30,
                                  width: 30,
                                  child: Icon(
                                    Icons.star_purple500_sharp,
                                    color: Colors.yellow,
                                  ),
                                  decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      shape: BoxShape.circle,
                                      border:
                                          Border.all(color: Colors.yellow))),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "You have 30 points",
                                style: context.bodyText1,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Edit Profile',
                          style: context.subtitle2,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ChangeField(
                          text: 'Change Name',
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ChangeField(
                          text: 'Change Email',
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                  ),
                )
              ]),
            ),
          ),
        );
      },
    );
  }
}

class ChangeField extends StatelessWidget {
  const ChangeField({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 17),
      child: Row(
        children: [
          Container(
              height: 40,
              width: 40,
              child: Icon(
                Icons.keyboard_arrow_left_rounded,
                color: Colors.yellow,
              ),
              decoration: BoxDecoration(
                color: HexColor('#1d592c'),
                borderRadius: BorderRadius.circular(10),
              )),
          SizedBox(
            width: 15,
          ),
          Text(
            text,
            style: context.bodyText1,
          ),
          Spacer(),
          Icon(
            Icons.arrow_right_alt_outlined,
            color: HexColor('#1d592c'),
          )
        ],
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[400]!),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white),
    );
  }
}
