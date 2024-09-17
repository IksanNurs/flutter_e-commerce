import 'package:showroom_app/models/UserModel.dart';

class ResponseModel{
  int? status;
  String? message;
  int? issales;

  ResponseModel({
    this.status,
    this.message,
    this.issales
  });

  ResponseModel.fromJson(Map<String, dynamic>json){
    status = json["status"];
    message = json["message"];
    issales = json["data"]["user"]["is_sales"] ?? null;
  }

  Map<String,dynamic> toJson(){
    return 
    {
      "status" : status,
      "message" : message,
  
    };

  }

}