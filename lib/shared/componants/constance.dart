import 'package:flutter/material.dart';
import '../../modules/shop_app/login/login_screen.dart';
import '../network/lockal/cache_helper.dart';
import 'componants.dart';

const defaultColor = Colors.blue;

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    navigateAndFinish(context, ShopLoginScreen());
  });
}

String? token = '';
