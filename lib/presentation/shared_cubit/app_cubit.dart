import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:palnts/core/utils/constants.dart';
import 'package:palnts/models/login_model.dart';
import 'package:palnts/models/products_model.dart';
import 'package:palnts/network/local/cashe_helper.dart';
import 'package:palnts/network/remote/DioHelper.dart';
import 'package:palnts/presentation/sign_layout/screens/sign_layout_screen.dart';
import '../../core/utils/app_strings.dart';
import '../../network/remote/dio_exceptions.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntialState());
  ProductsModel productsModel = ProductsModel();
  getProducts() {
    emit(AppGetProductsLoadingState());
    DioHelper.getData(url: '/api/v1/products', token: AppStrings.token)
        .then((value) {
      productsModel = ProductsModel.fromjson(value.data);
      // print(productsModel.products[0].imageUrl);
      emit(AppGetProductsSuccessState());
    }).catchError((e) {
      print(e);
      emit(AppGetProductsErrorState());
    });
  }

  //add value to recent searches list
  List<String> recentSearches = [];
  addToRecentSearches(String value) {
    recentSearches.add(value);
    CashHelper.setData('recentSearches', recentSearches);
    emit(AddToRecentSearchesStates());
  }

  removeFromRecentsearches(int index) {
    recentSearches.removeAt(index);
    CashHelper.setData('recentSearches', recentSearches);
    emit(RemoveFromRecentSearchesStates());
  }

  getRecentSearchesFromSharedPref() {
    // var recSearches = CashHelper.getData('recentSearches');
    var recSearches =
        CashHelper.sharedPreferences.getStringList('recentSearches');
    if (recSearches != null) {
      recentSearches = recSearches;
    }
  }

  logout(BuildContext context) {
    emit(LoadingAppLogoutState());
    CashHelper.removeData('token').then((value) {
      AppStrings.token = null;
      Constants.pushReplace(context, SignLayoutScreen());
      logOutGoogle();
      // logoutFaceBook();
      emit(SuccessAppLogoutState());
    });
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  LoginModel loginModel = LoginModel();
  GoogleSignInAccount? googleSignInAccount;
  Future signInWithGoogle() async {
    try {
      googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        return null;
      }
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication? googleSignInAuthentication =
            await googleSignInAccount?.authentication;
        AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication?.idToken,
          accessToken: googleSignInAuthentication?.accessToken,
        );
        UserCredential userCredential =
            await auth.signInWithCredential(authCredential);
        sendGoogleEmailToApi();
      }
    } on FirebaseAuthException catch (e) {
      return null;
      //return e.message ?? e.toString();
    }
  }

  AccessToken? accessToken;
  Map<String, dynamic>? user;
  // FacebookAuth facebookAuth = FacebookAuth.instance;
  // signInWithFace() async {
  //   final LoginResult result = await FacebookAuth.instance
  //       .login(permissions: ['email', 'public_profile']);
  //   if (result.status == LoginStatus.success) {
  //     accessToken = result.accessToken;
  //     final userData = await FacebookAuth.instance.getUserData();
  //     user = userData;
  //     //print(user);
  //     // print(user!['picture']['data']['url']);
  //     emit(SignInWithFaceBookState());
  //   } else {
  //     print(result.status);
  //     print(result.message);
  //     print(user);
  //     emit(SignInWithFaceBookState());
  //   }
  // }

  // logoutFaceBook() async {
  //   await FacebookAuth.i.logOut().then((value) => print('logee out face'));
  // }

  sendGoogleEmailToApi() {
    emit(LoadingSendGoogleEmailToApi());
    DioHelper.postData(url: '/api/v1/auth/google', data: {
      "id": '${auth.currentUser?.uid}',
      "email": '${auth.currentUser?.email}',
      "firstName": '${auth.currentUser?.displayName}',
      "lastName": '${auth.currentUser?.displayName}',
      "picture": '${auth.currentUser?.photoURL}'
    }).then((value) {
      // print(value.data);
      print('data is ${value.data}');
      loginModel = LoginModel.fromjson(value.data);
      print(loginModel.userData?.user?.firstName);
      print(loginModel.userData?.user?.lastName);
      emit(SuccessSendGoogleEmailToApi(loginModel));
    }).catchError((error) {
      logOutGoogle();
      DioExceptions? dioExceptions;
      dioExceptions = DioExceptions.fromDioError(error);
      Constants.showToast(msg: '${dioExceptions.message}');
      emit(ErrorSendGoogleEmailToApi());
    });
  }

  logOutGoogle() async {
    googleSignInAccount = null;
    await googleSignIn.signOut();
    await auth.signOut();
  }

  //add to cart
  List<Product> cartItems = [];
  addToCart(Product product) {
    if (!cartItems.contains(product)) {
      cartItems.add(product);
      emit(AddToCartState());
    }
  }

  removeFromCart(Product product) {
    if (cartItems.contains(product)) {
      cartItems.remove(product);
      emit(RemoveFormCartState());
    }
  }
}
