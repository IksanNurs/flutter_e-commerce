class UserModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  int? isSales;
  int? createdAt;
  int? updatedAt;
  String? token;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.isSales,
      this.createdAt,
      this.updatedAt,
      this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['data']['user']['id'] ?? null;
    name = json['data']['user']['name'] ?? '';
    email = json['data']['user']['email'] ?? '';
    phone = json['data']['user']['phone'] ?? '';
    isSales = json['data']['user']['is_sales'] ?? null;
    createdAt = json['data']['user']['created_at'] ?? null;
    updatedAt = json['data']['user']['updated_at'] ?? null;
    token = json['data']['user']['token'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return{
      "id" : id,
      "name" : name,
      "email" : email,
      "phone" : phone,
      "isSales" : isSales,
      "createdAt" : createdAt,
      "updatedAt" : updatedAt,
      "token" : token,
    };
  }
}
