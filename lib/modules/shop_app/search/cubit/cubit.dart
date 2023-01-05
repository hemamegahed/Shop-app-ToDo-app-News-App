import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/shop_app/search_model.dart';
import 'package:todo_app/modules/shop_app/search/cubit/states.dart';
import 'package:todo_app/shared/componants/constance.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';

import '../../../../shared/network/remote/end_points.dart';

class ShopSearchCubit extends Cubit<SearchStates> {
  ShopSearchCubit() : super(ShopSearchInitialStates());
  static ShopSearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void search(String text) {
    emit(ShopLoadingSearchStates());
    DioHelper.postData(url: SEARCH, token: token, data: {'text': text})
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(ShopSuccessSearchStates());
    }).catchError((erroe) {
      emit(ShopErrorSearchStates());
    });
  }
}
