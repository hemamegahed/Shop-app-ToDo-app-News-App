class ShopLoginModel {
  bool? status;
  String? message;
  UserData? data;

  ShopLoginModel.formJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.formJson(json['data']) : null;
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;
  int? points;
  int? credit;

  UserData.formJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
    points = json['points'];
    credit = json['credit'];
  }
}
