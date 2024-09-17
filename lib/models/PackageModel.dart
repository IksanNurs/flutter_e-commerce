class PackageModel {
  int? motifId;
  int? sizeId;
  int? productId;

  PackageModel({this.motifId, this.sizeId, this.productId});

  PackageModel.fromJson(Map<String, dynamic> json) {
    motifId = json['motif_id'];
    sizeId = json['size_id'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['motif_id'] = this.motifId;
    data['size_id'] = this.sizeId;
    data['product_id'] = this.productId;
    return data;
  }
}