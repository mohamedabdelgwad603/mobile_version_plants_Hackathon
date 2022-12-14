// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palnts/core/utils/constants.dart';
import 'package:palnts/presentation/blogs/blogs_screen.dart';
import 'package:palnts/presentation/home_screen/screens/home_screen.dart';
import 'package:palnts/presentation/notification/blogs_screen.dart';
import 'package:palnts/presentation/profile_screen.dart/profile_screen.dart';
import 'package:palnts/presentation/scanner_screen.dart/scanner_screen.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/assets_manger.dart';
import '../shared_cubit/app_cubit.dart';
import '../shared_cubit/app_states.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  static const IconData qr_code_scanner_rounded =
      IconData(0xf00cc, fontFamily: 'MaterialIcons');
  int _botNavIndex = 2;
  Widget buildIcon({int? inx, IconData? icon}) {
    return Icon(icon,
        size: 30, color: _botNavIndex == inx ? Colors.white : Colors.black);
  }

  List<Widget> iconsList = [
    // buildIcon(0),
    Icon(
      Icons.message_outlined,
      size: 30,
    ),
    Icon(Icons.qr_code_scanner_rounded, size: 30),
    Icon(Icons.home_outlined, size: 30),
    Icon(Icons.notifications_outlined, size: 30),
    Icon(Icons.person_outlined, size: 30),
  ];
  List<Widget> screens = [
    BlogsScreen(),
    ScannerScreen(),
    HomeScreen(),
    NotificationsScreen(),
    ProfileScreen()
  ];

  @override
  void didChangeDependencies() {
    BlocProvider.of<AppCubit>(context).getProducts();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BlocProvider.of<AppCubit>(context);
          // if (cubit.productsModel.products.isEmpty &&
          //     state is! AppGetProductsLoadingState)
          // cubit.getProducts();
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                centerTitle: true,
                title: Stack(
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
              ),
              bottomNavigationBar: CurvedNavigationBar(
                  index: _botNavIndex,
                  letIndexChange: (index) {
                    if (index == 0) {
                      Constants.push(context, BlogsScreen());
                      return _botNavIndex == index;
                    } else if (index == 1) {
                      Constants.push(context, ScannerScreen());
                      return _botNavIndex == index;
                    } else if (index == 3) {
                      Constants.push(context, NotificationsScreen());
                      return _botNavIndex == index;
                    } else if (index == 4) {
                      Constants.push(context, ProfileScreen());
                      return _botNavIndex == index;
                    }
                    return _botNavIndex == index;
                  },
                  color: Colors.grey[200]!,
                  buttonBackgroundColor:
                      _botNavIndex == 2 ? AppColors.primary : null,
                  backgroundColor: Colors.transparent,
                  items: [
                    buildIcon(
                      inx: 0,
                      icon: Icons.fireplace,
                    ),
                    buildIcon(
                      inx: 1,
                      icon: Icons.qr_code_scanner_rounded,
                    ),
                    buildIcon(
                      inx: 2,
                      icon: Icons.home_outlined,
                    ),
                    buildIcon(
                      inx: 3,
                      icon: Icons.notifications_outlined,
                    ),
                    buildIcon(
                      inx: 4,
                      icon: Icons.person_outlined,
                    ),
                  ]),
              body: screens[_botNavIndex]);
        });
  }
}
