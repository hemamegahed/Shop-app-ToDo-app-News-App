import 'package:todo_app/layout/news_app/cubit/cubit.dart';

abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsIChangeNavState extends NewsStates {}

class NewsBusinessLoadingState extends NewsStates {}

class NewsGetBusinessSuccessState extends NewsStates {}

class NewsGetBusinessFailedState extends NewsStates {
  final String error;

  NewsGetBusinessFailedState(this.error);
}

class NewsSportsLoadingState extends NewsStates {}

class NewsGetSportsSuccessState extends NewsStates {}

class NewsGetSportsFailedState extends NewsStates {
  final String error;

  NewsGetSportsFailedState(this.error);
}

class NewsScienceLoadingState extends NewsStates {}

class NewsGetScienceSuccessState extends NewsStates {}

class NewsGetScienceFailedState extends NewsStates {
  final String error;

  NewsGetScienceFailedState(this.error);
}

class NewsSearchLoadingState extends NewsStates {}

class NewsGetSearchSuccessState extends NewsStates {}

class NewsGetSearchFailedState extends NewsStates {
  final String error;

  NewsGetSearchFailedState(this.error);
}
