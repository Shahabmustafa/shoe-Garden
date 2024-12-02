class UserModel {
  String? token;
  bool? isLogin;
  String? id;
  String? name;
  String? address;
  String? phoneNumber;

  UserModel(
      {this.token, this.isLogin, this.id,this.name, this.address, this.phoneNumber});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    isLogin = json['isLogin'];
    id = json['id'];
    name = json['name'];
    address = json['address'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['isLogin'] = this.token;
    data['id'] = this.id;
    data['name'] = this.name;

    data['address'] = this.address;
    data['phone_number'] = this.phoneNumber;
    return data;
  }
}
