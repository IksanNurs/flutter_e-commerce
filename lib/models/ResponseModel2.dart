import 'package:showroom_app/models/UserModel.dart';

class ResponseModel2{
  int? status;
  String? message;
  int? issales;

  ResponseModel2({
    this.status,
    this.message,
    this.issales
  });

  ResponseModel2.fromJson(Map<String, dynamic>json){
    status = json["status"];
    message = json["message"];
  }

  Map<String,dynamic> toJson(){
    return 
    {
      "status" : status,
      "message" : message,
  
    };

  }

}