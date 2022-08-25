import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:palnts/core/utils/end_points.dart';
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
      print(value.data.toString());

      // print(LoginModel.message);
      // print(LoginModel.data!.token);
      emit(AppLoginSuccessState(loginModel));
    }).catchError((error) {
      print("errors occured is ${error.toString()}");
      emit(AppLoginErrorState());
    });
  }

  //sign in with google
  GoogleSignInAccount? currentUser;
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  FirebaseAuth auth = FirebaseAuth.instance;
  signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;
    AuthCredential authCredential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication?.idToken,
      accessToken: googleSignInAuthentication?.accessToken,
    );
    UserCredential userCredential =
        await auth.signInWithCredential(authCredential);
    User? user = userCredential.user;
    final email = googleSignInAccount?.email;
    print('email is $email');

    emit(SignInWithGoogleState());
  }

  //sign with facebook
  AccessToken? accessToken;
  Map<String, dynamic>? user;
  signInWithFace() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      accessToken = result.accessToken;

      final userData = await FacebookAuth.instance.getUserData();
      user = userData;
      print(user);
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
