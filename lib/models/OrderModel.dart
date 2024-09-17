class OrderMordel {
  int? status;
  String? message;
  Data? data;

  OrderMordel({this.status, this.message, this.data});

  OrderMordel.fromJson(Map<String, dynamic> json) {
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
  String? midtransPaymentUrl;

  Data({this.midtransPaymentUrl});

  Data.fromJson(Map<String, dynamic> json) {
    midtransPaymentUrl = json['midtrans_payment_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['midtrans_payment_url'] = this.midtransPaymentUrl;
    return data;
  }
}
