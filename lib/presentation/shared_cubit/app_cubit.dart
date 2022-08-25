import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palnts/models/products_model.dart';
import 'package:palnts/network/local/cashe_helper.dart';
import 'package:palnts/network/remote/DioHelper.dart';
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
      print(productsModel.products[0].imageUrl);
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
}
