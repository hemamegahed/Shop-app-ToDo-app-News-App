class CategoriesModel {
  bool? status;
  CategoriesDataModel? data;
  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel {
  int? currentPage;
  List<DataModel>? data = [];
  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['status'];
    json['data'].forEach((element) {
      data!.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  String? name;
  String? image;
  int? id;
  DataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    id = json['id'];
  }
}
