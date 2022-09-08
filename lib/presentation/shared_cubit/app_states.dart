import '../../models/login_model.dart';

abstract class AppStates {}

//intial state
class AppIntialState extends AppStates {}

// Get products state
class AppGetProductsLoadingState extends AppStates {}

class AppGetProductsSuccessState extends AppStates {}

class AppGetProductsErrorState extends AppStates {}

//add value to recent searches list state
class AddToRecentSearchesStates extends AppStates {}

class RemoveFromRecentSearchesStates extends AppStates {}

//logout state
class LoadingAppLogoutState extends AppStates {}

class SuccessAppLogoutState extends AppStates {}

//sign with google
class SignInWithGoogleLoadingState extends AppStates {}

class SignInWithGoogleSuccessState extends AppStates {
  final LoginModel loginModel;

  SignInWithGoogleSuccessState(this.loginModel);
}

class SignInWithGoogleErrorState extends AppStates {}

// //sign with face
// class SignInWithFaceBookState extends AppStates {}

// send googleEmail to api state
class LoadingSendGoogleEmailToApi extends AppStates {}

class SuccessSendGoogleEmailToApi extends AppStates {
  final LoginModel loginModel;

  SuccessSendGoogleEmailToApi(this.loginModel);
}

class ErrorSendGoogleEmailToApi extends AppStates {}

//ada to cart state
class AddToCartState extends AppStates {}

class RemoveFormCartState extends AppStates {}
