import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/shop_app/login_model.dart';

import 'package:todo_app/modules/shop_app/regester/cubit/states.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';

import '../../../../shared/network/remote/end_points.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? shopRegisterModel;
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(ShopRegisterLoadinglState());
    DioHelper.postData(url: Register, data: {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone
    }).then((value) {
      shopRegisterModel = ShopLoginModel.formJson(value!.data);
      emit(ShopRegisterSuccessState(shopRegisterModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility;
  bool isSecure = true;
  void changePasswordVisibility() {
    isSecure = !isSecure;
    suffix = isSecure ? Icons.visibility : Icons.visibility_off_outlined;

    emit(ShopRegisterPasswordSuffixState());
  }
}
