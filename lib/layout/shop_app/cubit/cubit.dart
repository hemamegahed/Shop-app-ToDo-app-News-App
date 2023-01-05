import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/shop_app/cubit/states.dart';
import 'package:todo_app/models/shop_app/favorites_data_model.dart';
import 'package:todo_app/models/shop_app/home_model.dart';
import 'package:todo_app/models/shop_app/login_model.dart';
import 'package:todo_app/modules/shop_app/categories/categories.dart';
import 'package:todo_app/modules/shop_app/favorites/favorites.dart';
import 'package:todo_app/modules/shop_app/products/products.dart';
import 'package:todo_app/modules/shop_app/settings/settings.dart';
import 'package:todo_app/shared/componants/constance.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';
import 'package:todo_app/shared/network/remote/end_points.dart';

import '../../../models/shop_app/categories_model.dart';
import '../../../models/shop_app/favorits_model.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];
  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopBottomNavStates());
  }

  HomeModel? homeModel;
  Map<int, bool>? favorite = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataStates());
    DioHelper.getData(url: HOME, token: token).then((value) async {
      homeModel = HomeModel.fromJson(value.data);
      // print(homeModel?.data?.banners![4].image);
      // print(homeModel?.status);
      homeModel!.data!.products!.forEach((element) {
        favorite!.addAll({element.id!: element.inFavorites!});
      });
      print(favorite.toString());
      emit(ShopSuccessHomeDataStates());
    }).catchError((error) {
      print(error.toString());

      emit(ShopErrorHomeDataStates());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(url: getCategories, token: token).then((value) async {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesStates());
    }).catchError((error) {
      print(error.toString());

      emit(ShopErrorCategoriesStates());
    });
  }

  ChangeFavoriteModel? changeFavoriteModel;

  void changeFavorites(int productID) {
    favorite![productID] = !favorite![productID]!;
    emit(ShopChangeFavoritesStates());
    DioHelper.postData(
            url: FAVORITES, data: {'product_id': productID}, token: token)
        .then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      print(value.data);
      if (!changeFavoriteModel!.status!) {
        favorite![productID] = !favorite![productID]!;
      } else {
        getFavoritesData();
      }
      emit(ShopSuccessChangeFavoritesStates(changeFavoriteModel!));
    }).catchError((error) {
      favorite![productID] = !favorite![productID]!;
      emit(ShopErrorChangeFavoritesStates());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavoritesData() {
    emit(ShopLoadingGetFavoritesStates());
    DioHelper.getData(url: FAVORITES, token: token).then((value) async {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(value.data.toString());

      emit(ShopSuccessGetFavoritesStates());
    }).catchError((error) {
      print(error.toString());

      emit(ShopErrorGetFavoritesStates());
    });
  }

  ShopLoginModel? shopUserModel;

  void getProfileData() {
    emit(ShopLoadingUserDataStates());
    DioHelper.getData(url: PROFILE, token: token).then((value) async {
      shopUserModel = ShopLoginModel.formJson(value.data);
      print(shopUserModel!.data!.name!);

      emit(ShopSuccessUserDataStates());
    }).catchError((error) {
      emit(ShopErrorUserDataStates());
    });
  }

  void updateProfileData({
    required String name,
    required String phone,
    required String email,
  }) {
    emit(ShopLoadingUpdateProfileStates());
    DioHelper.putData(
      url: UPDATEPROFILE,
      token: token,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
      },
    ).then((value) async {
      shopUserModel = ShopLoginModel.formJson(value.data);
      print(shopUserModel!.data!.name!);

      emit(ShopSuccessUpdateProfileStates(shopUserModel));
    }).catchError((error) {
      emit(ShopErrorUpdateProfileStates());
    });
  }
}
