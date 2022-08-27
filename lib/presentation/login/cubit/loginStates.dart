import '../../../models/login_model.dart';

abstract class AppLoginStates {}

//intial state
class AppLoginIntialState extends AppLoginStates {}

// user Login functions state
class AppLoginLoadingState extends AppLoginStates {}

class AppLoginSuccessState extends AppLoginStates {
  final LoginModel loginModel;

  AppLoginSuccessState(this.loginModel);
}

class AppLoginErrorState extends AppLoginStates {}

// change password visibility stste
class AppLoginChangVisibiltyState extends AppLoginStates {}

//sign with face
class SignInWithFaceBookState extends AppLoginStates {}
