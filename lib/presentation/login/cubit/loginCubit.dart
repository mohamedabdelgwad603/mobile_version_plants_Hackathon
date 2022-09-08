import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:palnts/core/utils/constants.dart';
import 'package:palnts/core/utils/end_points.dart';
import 'package:palnts/network/remote/dio_exceptions.dart';
import '../../../models/login_model.dart';
import '../../../network/remote/DioHelper.dart';
import 'loginStates.dart';

class AppLoginCubit extends Cubit<AppLoginStates> {
  AppLoginCubit() : super(AppLoginIntialState());
  LoginModel loginModel = LoginModel();
  void userLogin({required String email, required String password}) {
    emit(AppLoginLoadingState());
    DioHelper.postData(
        url: AuthEndPoints.login,
        data: {'email': email, 'password': password}).then((value) {
      loginModel = LoginModel.fromjson(value.data);
      //print(value.data.toString());
      emit(AppLoginSuccessState(loginModel));
    }).catchError((error) {
      DioExceptions? dioExceptions;
      dioExceptions = DioExceptions.fromDioError(error);
      Constants.showToast(msg: '${dioExceptions.message}');
      emit(AppLoginErrorState());
    });
  }

  //sign with facebook
  // FacebookLogin facebookLogin = FacebookLogin();

  // faceBookSignIn() async {
  //   FacebookLoginResult result = await facebookLogin.logIn(permissions: [
  //     FacebookPermission.publicProfile,
  //     FacebookPermission.email,
  //   ]);
  //   final accessToken = result.accessToken?.token;
  //   if (result.status == FacebookLoginStatus.success) {
  //     final faceCredential = FacebookAuthProvider.credential(accessToken!);
  //     auth.signInWithCredential(faceCredential);
  //   }
  // }

  // FirebaseAuth auth = FirebaseAuth.instance;
  AccessToken? accessToken;
  Map<String, dynamic>? user;
  signInWithFace() async {
    final LoginResult result = await FacebookAuth.instance
        .login(permissions: ['email', 'public_profile']);
    if (result.status == LoginStatus.success) {
      accessToken = result.accessToken;
      final userData = await FacebookAuth.instance.getUserData();
      user = userData;
      //print(user);
      print(user!['picture']['data']['url']);
      emit(SignInWithFaceBookState());
    } else {
      print(result.status);
      print(result.message);
      print(user);
      emit(SignInWithFaceBookState());
    }
  }

  //change Visibilty icon for padssword Text field
  IconData suffixicon = Icons.visibility_outlined;
  bool isObscure = true;
  changeVisibilty() {
    isObscure = !isObscure;
    suffixicon =
        isObscure ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(AppLoginChangVisibiltyState());
  }
}
