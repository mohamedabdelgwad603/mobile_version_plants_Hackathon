import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palnts/core/utils/app_strings.dart';
import 'package:palnts/network/local/cashe_helper.dart';
import 'package:palnts/network/remote/DioHelper.dart';
import 'package:palnts/presentation/register/register_screen.dart';
import 'package:palnts/presentation/root/root_page.dart';
import 'package:palnts/presentation/shared_cubit/app_cubit.dart';
import 'package:palnts/presentation/shared_cubit/app_states.dart';
import 'config/themes/app_theme.dart';
import 'presentation/splash_screen/default_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  await DioHelper.init();
  await CashHelper.init();
  AppStrings.token = CashHelper.getData('token');
  // Widget widget;
  // if (AppStrings.token == null) {
  //   widget = RegisterScreen();
  // } else {
  //   widget = RootPage();
  // }
  print('access token is ${AppStrings.token}');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  //final Widget widget;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getProducts()
        ..getRecentSearchesFromSharedPref(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: Themes.theme,
            home: DefaultSplashScreen(),
          );
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
