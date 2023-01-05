import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/news_app/cubit/cubit.dart';
import 'package:todo_app/layout/shop_app/cubit/cubit.dart';
import 'package:todo_app/layout/shop_app/shop_layout.dart';
import 'package:todo_app/modules/shop_app/login/login_screen.dart';
import 'package:todo_app/shared/bloc_observer.dart';

import 'package:todo_app/shared/network/lockal/cache_helper.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';
import 'package:todo_app/shared/style/themes.dart';
import 'layout/todo_app/cubit/cubit.dart';
import 'layout/todo_app/cubit/states.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'shared/componants/constance.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CacheHelper.init();
  HttpOverrides.global = MyHttpOverrides();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  // isDark ??= false;
  //chick for  null
  Widget widget;

  if (onBoarding != null) {
    if (token != null) {
      widget = ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    // isDark: isDark,
    startwidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  // final bool? isDark;
  final Widget? startwidget;
  const MyApp({this.startwidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        ),
        BlocProvider(
          create: (BuildContext context) => AppCubit()..changeAppMode(),
        ),
        BlocProvider(
            create: (BuildContext context) => ShopCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavoritesData()
              ..getProfileData())
      ],
      child: BlocConsumer<AppCubit, AppState>(
          listener: (BuildContext context, states) {},
          builder: (BuildContext context, states) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: ThemeMode.light,
                home: startwidget);
          }),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
