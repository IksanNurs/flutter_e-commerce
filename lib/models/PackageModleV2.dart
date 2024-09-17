class PackageModelV2 {
  Package? package;

  PackageModelV2({this.package});

  PackageModelV2.fromJson(Map<String, dynamic> json) {
    package =
        json['package'] != null ? new Package.fromJson(json['package']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.package != null) {
      data['package'] = this.package!.toJson();
    }
    return data;
  }
}

class Package {
  int? id;
  int? motifId;
  int? sizeId;
  int? productId;
  int? methodId;
  int? shippingId;
  String? note;
  String? address;
  int? createdAt;
  int? updatedAt;
  Size? size;
  Motif? motif;
  Product? product;
  Method? method;
  Shipping? shipping;

  Package(
      {this.id,
      this.motifId,
      this.sizeId,
      this.productId,
      this.methodId,
      this.shippingId,
      this.note,
      this.address,
      this.createdAt,
      this.updatedAt,
      this.size,
      this.motif,
      this.product,
      this.method,
      this.shipping});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    motifId = json['motif_id'];
    sizeId = json['size_id'];
    productId = json['product_id'];
    methodId = json['method_id'];
    shippingId = json['shipping_id'];
    note = json['note'];
    address = json['address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    size = json['Size'] != null ? new Size.fromJson(json['Size']) : null;
    motif = json['Motif'] != null ? new Motif.fromJson(json['Motif']) : null;
    product =
        json['Product'] != null ? new Product.fromJson(json['Product']) : null;
    method =
        json['Method'] != null ? new Method.fromJson(json['Method']) : null;
    shipping = json['Shipping'] != null
        ? new Shipping.fromJson(json['Shipping'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['motif_id'] = this.motifId;
    data['size_id'] = this.sizeId;
    data['product_id'] = this.productId;
    data['method_id'] = this.methodId;
    data['shipping_id'] = this.shippingId;
    data['note'] = this.note;
    data['address'] = this.address;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.size != null) {
      data['Size'] = this.size!.toJson();
    }
    if (this.motif != null) {
      data['Motif'] = this.motif!.toJson();
    }
    if (this.product != null) {
      data['Product'] = this.product!.toJson();
    }
    if (this.method != null) {
      data['Method'] = this.method!.toJson();
    }
    if (this.shipping != null) {
      data['Shipping'] = this.shipping!.toJson();
    }
    return data;
  }
}

class Size {
  int? id;
  String? name;
  int? productId;
  int? createdAt;
  int? updatedAt;

  Size({this.id, this.name, this.productId, this.createdAt, this.updatedAt});

  Size.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['product_id'] = this.productId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Motif {
  int? id;
  String? name;
  int? productId;
  int? price;
  String? image;
  int? createdAt;
  int? updatedAt;

  Motif(
      {this.id,
      this.name,
      this.productId,
      this.price,
      this.image,
      this.createdAt,
      this.updatedAt});

  Motif.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    productId = json['product_id'];
    price = json['price'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['product_id'] = this.productId;
    data['price'] = this.price;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Product {
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
  Null? size;
  Null? motif;

  Product(
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

  Product.fromJson(Map<String, dynamic> json) {
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
    size = json['Size'];
    motif = json['Motif'];
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
    data['Size'] = this.size;
    data['Motif'] = this.motif;
    return data;
  }
}

class Method {
  int? id;
  String? name;
  int? createdAt;
  int? updatedAt;

  Method({this.id, this.name, this.createdAt, this.updatedAt});

  Method.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Shipping {
  int? id;
  String? name;
  int? productId;
  int? price;
  int? createdAt;
  int? updatedAt;

  Shipping(
      {this.id,
      this.name,
      this.productId,
      this.price,
      this.createdAt,
      this.updatedAt});

  Shipping.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    productId = json['product_id'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['product_id'] = this.productId;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
