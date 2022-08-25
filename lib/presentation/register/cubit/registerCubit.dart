import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palnts/core/utils/end_points.dart';

import '../../../network/remote/DioHelper.dart';
import '../../../models/user_model.dart';
import 'registerStates.dart';

class AppRegisterCubit extends Cubit<AppRegisterStates> {
  AppRegisterCubit() : super(AppRegisterIntialState());
  UserModel registerModel = UserModel();
  //TODO:edit register function
  void userRegister(
      {required String email,
      required String password,
      required String firstName,
      required String lastName}) {
    emit(AppRegisterLoadingState());
    DioHelper.postData(url: AuthEndPoints.register, data: {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password
    }).then((value) {
      registerModel = UserModel.fromjson(value.data);
      print(value.data.toString());

      print(registerModel.message);
      // print(UserModel.data!.token);
      emit(AppRegisterSuccessState(registerModel));
    }).catchError((error) {
      print("error occured is ${error.toString()}");
      emit(AppRegisterErrorState());
    });
  }

  //change Visibilty icon for padssword Text field
  IconData suffixicon = Icons.visibility_outlined;
  bool isObscure = true;
  changeVisibilty() {
    isObscure = !isObscure;
    suffixicon =
        isObscure ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(AppRegisterChangVisibiltyState());
  }
}
