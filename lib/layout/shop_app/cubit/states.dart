import 'package:todo_app/models/shop_app/favorits_model.dart';
import 'package:todo_app/models/shop_app/login_model.dart';

abstract class ShopStates {}

class ShopInitialStates extends ShopStates {}

class ShopBottomNavStates extends ShopStates {}

class ShopLoadingHomeDataStates extends ShopStates {}

class ShopSuccessHomeDataStates extends ShopStates {}

class ShopErrorHomeDataStates extends ShopStates {}

class ShopSuccessCategoriesStates extends ShopStates {}

class ShopErrorCategoriesStates extends ShopStates {}

class ShopChangeFavoritesStates extends ShopStates {}

class ShopSuccessChangeFavoritesStates extends ShopStates {
  final ChangeFavoriteModel model;

  ShopSuccessChangeFavoritesStates(this.model);
}

class ShopErrorChangeFavoritesStates extends ShopStates {}

class ShopLoadingGetFavoritesStates extends ShopStates {}

class ShopSuccessGetFavoritesStates extends ShopStates {}

class ShopErrorGetFavoritesStates extends ShopStates {}

class ShopSuccessUserDataStates extends ShopStates {}

class ShopErrorUserDataStates extends ShopStates {}

class ShopLoadingUserDataStates extends ShopStates {}

class ShopSuccessUpdateProfileStates extends ShopStates {
  final ShopLoginModel? shopLoginModel;

  ShopSuccessUpdateProfileStates(this.shopLoginModel);
}

class ShopErrorUpdateProfileStates extends ShopStates {}

class ShopLoadingUpdateProfileStates extends ShopStates {}
