import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/login/cubit/loginCubit.dart';
import '../../presentation/register/cubit/registerCubit.dart';

extension ThemeExtentions on BuildContext {
  TextStyle? get subtitle1 => Theme.of(this).textTheme.subtitle1;
  TextStyle? get subtitle2 => Theme.of(this).textTheme.subtitle2;
  TextStyle? get bodyText1 => Theme.of(this).textTheme.bodyText1;
  TextStyle? get button => Theme.of(this).textTheme.button;
  TextStyle? get caption => Theme.of(this).textTheme.caption;
  Color get primaryColor => Theme.of(this).primaryColor;
}

extension AppLoginCubitExtentions on BuildContext {
  AppLoginCubit get loginCubit => BlocProvider.of<AppLoginCubit>(this);
}

extension AppRegisterCubitExtentions on BuildContext {
  AppRegisterCubit get registerCubit => BlocProvider.of<AppRegisterCubit>(this);
}
