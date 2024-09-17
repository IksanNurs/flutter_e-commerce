class PackageModelV3 {
  int? status;
  String? message;
  Data? data;

  PackageModelV3({this.status, this.message, this.data});

  PackageModelV3.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Package1? package1;

  Data({this.package1});

  Data.fromJson(Map<String, dynamic> json) {
    package1 = json['package1'] != null
        ? new Package1.fromJson(json['package1'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.package1 != null) {
      data['package1'] = this.package1!.toJson();
    }
    return data;
  }
}

class Package1 {
  int? id;
  int? motifId;
  int? sizeId;
  int? productId;
  int? methodId;
  int? shippingId;
  String? note;
  String? address;
  int? createdAt;

  Package1(
      {this.id,
      this.motifId,
      this.sizeId,
      this.productId,
      this.methodId,
      this.shippingId,
      this.note,
      this.address,
      this.createdAt});

  Package1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    motifId = json['motif_id'];
    sizeId = json['size_id'];
    productId = json['product_id'];
    methodId = json['method_id'];
    shippingId = json['shipping_id'];
    note = json['note'];
    address = json['address'];
    createdAt = json['created_at'];
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
    return data;
  }
}
