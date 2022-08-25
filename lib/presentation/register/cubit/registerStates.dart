import '../../../models/user_model.dart';

abstract class AppRegisterStates {}
//intial state

class AppRegisterIntialState extends AppRegisterStates {}

// register function states
class AppRegisterLoadingState extends AppRegisterStates {}

class AppRegisterSuccessState extends AppRegisterStates {
  final UserModel registerModel;

  AppRegisterSuccessState(this.registerModel);
}

class AppRegisterErrorState extends AppRegisterStates {}

// change password icon visibitey
class AppRegisterChangVisibiltyState extends AppRegisterStates {}
