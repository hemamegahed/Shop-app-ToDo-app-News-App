import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/shop_app/login_model.dart';
import 'package:todo_app/modules/shop_app/login/cubit/states.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';

import '../../../../shared/network/remote/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? shopLoginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadinglState());
    DioHelper.postData(url: LOGIN, data: {'email': email, 'password': password})
        .then((value) {
      shopLoginModel = ShopLoginModel.formJson(value.data);
      emit(ShopLoginSuccessState(shopLoginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility;
  bool isSecure = true;
  void changePasswordVisibility() {
    isSecure = !isSecure;
    suffix = isSecure ? Icons.visibility : Icons.visibility_off_outlined;

    emit(ShopLoginPasswordSuffixState());
  }
}
