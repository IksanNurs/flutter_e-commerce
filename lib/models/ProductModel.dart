class ProductModel {
  int? id;
  int? categoryId;
  int? userId;
  String? name;
  String? deskripsi;
  int? price;
  int? stock;
  int? weight;
  String? image;
  int? createdAt;
  int? updatedAt;
  List<Size>? size;
  List<Motif>? motif;

  ProductModel(
      {this.id,
      this.categoryId,
      this.userId,
      this.name,
      this.deskripsi,
      this.price,
      this.stock,
      this.weight,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.size,
      this.motif});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    userId = json['user_id'];
    name = json['name'];
    deskripsi = json['deskripsi'];
    price = json['price'];
    stock = json['stock'];
    weight = json['weight'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['Size'] != null) {
      size = <Size>[];
      json['Size'].forEach((v) {
        size!.add(new Size.fromJson(v));
      });
    }
    if (json['Motif'] != null) {
      motif = <Motif>[];
      json['Motif'].forEach((v) {
        motif!.add(new Motif.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['deskripsi'] = this.deskripsi;
    data['price'] = this.price;
    data['stock'] = this.stock;
    data['weight'] = this.weight;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.size != null) {
      data['Size'] = this.size!.map((v) => v.toJson()).toList();
    }
    if (this.motif != null) {
      data['Motif'] = this.motif!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Size {
  int? id;
  String? name;
  int? ProductModelId;
  int? createdAt;
  int? updatedAt;

  Size({this.id, this.name, this.ProductModelId, this.createdAt, this.updatedAt});

  Size.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    ProductModelId = json['ProductModel_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['ProductModel_id'] = this.ProductModelId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Motif {
  int? id;
  String? name;
  int? ProductModelId;
  int? price;
  String? image;
  int? createdAt;
  int? updatedAt;

  Motif(
      {this.id,
      this.name,
      this.ProductModelId,
      this.price,
      this.image,
      this.createdAt,
      this.updatedAt});

  Motif.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    ProductModelId = json['ProductModel_id'];
    price = json['price'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['ProductModel_id'] = this.ProductModelId;
    data['price'] = this.price;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}