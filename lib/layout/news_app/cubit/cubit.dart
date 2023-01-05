import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/news_app/cubit/states.dart';
import 'package:flutter/material.dart';

import '../../../modules/news_app/business/business_screen.dart';
import '../../../modules/news_app/science/science_screen.dart';
import '../../../modules/news_app/sports/sports_screen.dart';
import '../../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItem = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business_center), label: 'Business'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.sports_football), label: 'Sports'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.science_outlined), label: 'Science'),
  ];
  void changeBottomNav(int index) {
    currentIndex = index;
    // if(index == 1) {
    //   getSports();
    // }
    // if(index == 2) {
    //   getScience();
    // }
    emit(NewsIChangeNavState());
  }

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '2006ad2f17b747079eddfb1974546885',
    }).then((value) {
      // print(value?.data['articles'][0]['title']);
      business = value?.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessFailedState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsBusinessLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '2006ad2f17b747079eddfb1974546885',
      }).then((value) {
        // print(value?.data['articles'][0]['title']);
        sports = value?.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsFailedState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];
  void getScience() {
    if (science.length == 0) {
      emit(NewsScienceLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '2006ad2f17b747079eddfb1974546885',
      }).then((value) {
        // print(value?.data['articles'][0]['title']);
        science = value?.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceFailedState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }


  List<dynamic> search = [];
  void getSearch(String value) {

    emit(NewsSearchLoadingState());
    search = [];


    DioHelper.getData(url: 'v2/everything', query: {

      'q': '$value',
      'apiKey': '2006ad2f17b747079eddfb1974546885',
    }).then((value) {
      // print(value?.data['articles'][0]['title']);
      search = value?.data['articles'];
      print(search[0]['title']);

      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchFailedState(error.toString()));
    });
    emit(NewsGetSearchSuccessState());

  }
}




