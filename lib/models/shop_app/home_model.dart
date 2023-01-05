class HomeModel {
  bool? status;
  String? massage;
  HomeDataModel? data;
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
     massage = json['message'];
    data = json['data'] != null ? HomeDataModel.fromJson(json['data']) : null;
  }
}

class HomeDataModel {
   List<BannerModel>? banners;
  List<ProductsModel>? products;
  HomeDataModel.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = [];
      json['banners'].forEach((element) {
        banners!.add(BannerModel.fromJson(element));
      });
    }
    if (json['products'] != null) {
      products = <ProductsModel>[];
      json['products'].forEach((element) {
        products!.add(ProductsModel.fromJson(element));
      });
    }
  }
}

class BannerModel {
  int? id;
   String? image;

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductsModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? name;
  String? image;
  bool? inFavorites;
  bool? inCart;

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    name = json['name'];
    image = json['image'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
