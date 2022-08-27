import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:palnts/presentation/root/root_page.dart';
import 'package:palnts/presentation/sign_layout/screens/sign_layout_screen.dart';
import '../../core/utils/app_strings.dart';
import '../../core/utils/assets_manger.dart';
import '../../core/utils/constants.dart';

class DefaultSplashScreen extends StatefulWidget {
  DefaultSplashScreen({Key? key}) : super(key: key);
  @override
  State<DefaultSplashScreen> createState() => _DefaultSplashScreenState();
}

class _DefaultSplashScreenState extends State<DefaultSplashScreen> {
  late Timer _timer;
  String? token = AppStrings.token;
  _goNext() => Constants.pushReplace(
      context, token != null ? RootPage() : SignLayoutScreen());

  _startDelay() {
    _timer = Timer(const Duration(milliseconds: 3000), () => _goNext());
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimationConfiguration.staggeredList(
        duration: Duration(milliseconds: 1200),
        position: 1,
        child: SlideAnimation(
          horizontalOffset: 300,
          child: FadeInAnimation(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(ImgAssets.logo),
                  Image.asset(ImgAssets.textLogo),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
