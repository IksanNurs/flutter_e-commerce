import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../models/CategoryModel.dart';
import '../models/OrderModel.dart';
import '../models/PackageModel.dart';
import '../models/PackageModelV3.dart';
import '../models/PackageModelV4.dart';
import '../models/PackageModleV2.dart';
import '../models/ProductModel.dart';
import '../models/ResponseModel.dart';
import '../models/ResponseModel2.dart';
import '../models/UserModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  static var baseUrl = "http://e-commerce.febunidha.ac.id:8008";

  static Future<ResponseModel> login({
    String? email,
    String? password_hash,
  }) async {
    var linkUrl = '/api/auth/login';
    var _body = jsonEncode({'email': email, 'password_hash': password_hash});
    var response = await http.post(Uri.parse(baseUrl + linkUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: _body
    );
    // print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      ResponseModel loginModel = ResponseModel.fromJson(data);

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('token', data['data']['token']);
      await prefs.setInt('id', data['data']['user']['id']);

      await prefs.setInt('isUser', data['data']['user']['is_sales']);
      // print(prefs.getBool('isUser'));

      final String? sptoken = prefs.getString('token');
      // print("Sptoken : " + sptoken.toString());

      final int? spid = prefs.getInt('id');
      // print("SpId : " + spid.toString());
      // print(data);
      return loginModel;
    } else {
      var data = jsonDecode(response.body);
      ResponseModel loginModel = ResponseModel.fromJson(data);
      return loginModel;
    }
  }

  static Future<ResponseModel2> register(
  {
    String? email,
    String? phone,
    String? password_hash,
    String? name
  }) async {
    var linkUrl = '/api/auth/register';
    var _body = jsonEncode({
      'phone': phone,
      'email': email,
      'name': name,
      'password_hash': password_hash
    });
    var response = await http.post(Uri.parse(baseUrl + linkUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: _body);
    // print(_body);
    // print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      ResponseModel2 registerModel = ResponseModel2.fromJson(data);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['data']['token']);
      await prefs.setInt('id', data['data']['user']['id']);

      await prefs.setInt('isUser', data['data']['user']['is_sales']);
      // print(prefs.getBool('isUser'));

      // print(response.body);
      return registerModel;
    } else {
      var data = jsonDecode(response.body);
      ResponseModel2 registerModel = ResponseModel2.fromJson(data);
      // print(response.body);
      return registerModel;
    }
  }

  Future<List<CategoryModel>> getCategory() async {
    var linkUrl = '/api/category';
    final prefs = await SharedPreferences.getInstance();
    final String? sptoken = prefs.getString('token');

    var response = await http.get(
      Uri.parse(baseUrl + linkUrl),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: 'Bearer ' + sptoken.toString()
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data']['category'] as List<dynamic>;
      var listCategory = data.map((i) => CategoryModel.fromJson(i)).toList();

      UserModel u = new UserModel();
      u.token.toString();
      return listCategory;
    } else {
      throw Exception('Gagal Get Category!');
    }
  }

  
  Future<bool> postCategory(Map<String, String> body, String filepath) async {
    var linkUrl = '/api/category';
    final prefs = await SharedPreferences.getInstance();
    final String? sptoken = prefs.getString('token');
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      HttpHeaders.authorizationHeader: 'Bearer ' + sptoken.toString()

    };
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl + linkUrl))
      ..fields.addAll(body)
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath('image', filepath));
    var response = await request.send();
    if (response.statusCode == 200) {
      print('berhasil');
      return true;
    } else {
      print('gagal');
      return false;
    }
  }
  

  Future<bool> postProduct(
    Map<String, String> body, String filePath
    ) async {
    var linkUrl = '/api/product';

    final prefs = await SharedPreferences.getInstance();
    final String? sptoken = prefs.getString('token');
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      HttpHeaders.authorizationHeader: 'Bearer ' + sptoken.toString()
    };

    var request = http.MultipartRequest('POST', Uri.parse(baseUrl + linkUrl))
      ..fields.addAll(body)
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath('image', filePath));
    var response = await request.send();
    if (response.statusCode == 200) {
      print('berhasil');
      return true;
    } else {
      print('gagal');
      return false;
    }
  }

  Future<bool> postMotif(
    Map<String, String> body, String filePath
    ) async {
    var linkUrl = '/api/motif';
    final prefs = await SharedPreferences.getInstance();
    final String? sptoken = prefs.getString('token');
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      HttpHeaders.authorizationHeader: 'Bearer ' + sptoken.toString()
    };

    var request = http.MultipartRequest('POST', Uri.parse(baseUrl + linkUrl))
      ..fields.addAll(body)
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath('image', filePath));
    var response = await request.send();
    if (response.statusCode == 200) {
      print('berhasil');
      return true;
    } else {
      print('gagal');
      return false;
    }
  }

  Future<List<ProductModel>> getAllProduct() async {
    var linkUrl = '/api/product';
    final prefs = await SharedPreferences.getInstance();
    final String? sptoken = prefs.getString('token');

    var response = await http.get(
      Uri.parse(baseUrl + linkUrl),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: 'Bearer ' + sptoken.toString()
      },
    );
    // print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data']['product'] as List<dynamic>;
      var listAllProduct = data.map((i) => ProductModel.fromJson(i)).toList();
      UserModel u = new UserModel();
      u.token.toString();
      return listAllProduct;
    } else {
      throw Exception('Gagal Get Category!');
    }
  }
  
  Future<List<ProductModel>> getProductByCategory(int id) async{
    var linkUrl = '/api/product-category/$id';
    final prefs = await SharedPreferences.getInstance();
    final String? sptoken = prefs.getString('token');

    var response = await http.get(
      Uri.parse(baseUrl + linkUrl),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: 'Bearer ' + sptoken.toString()
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data']['product'] as List<dynamic>;
      var listAllProduct = data.map((i) => ProductModel.fromJson(i)).toList();

      UserModel u = new UserModel();
      u.token.toString();
      return listAllProduct;
    } else {
      throw Exception('Gagal Get Category!');
    }
  }

  Future<List<ProductModel>> getProductBySearch(String search) async{
    var linkUrl = '/api/product/$search';
    final prefs = await SharedPreferences.getInstance();
    final String? sptoken = prefs.getString('token');

    var response = await http.get(
      Uri.parse(baseUrl + linkUrl),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: 'Bearer ' + sptoken.toString()
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data']['product'] as List<dynamic>;
      var listAllProduct = data.map((i) => ProductModel.fromJson(i)).toList();

      UserModel u = new UserModel();
      u.token.toString();
      return listAllProduct;
    } else {
      throw Exception('Gagal Get Category!');
    }
  }

  Future<UserModel> getUserSelf() async{
    var linkUrl = '/api/user';
    final prefs = await SharedPreferences.getInstance();
    final String? sptoken = prefs.getString('token');

    var response = await http.get(
      Uri.parse(baseUrl + linkUrl),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: 'Bearer ' + sptoken.toString()
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      UserModel getUser = UserModel.fromJson(data);
      // print(getUser);
      // print(response.body);
      return getUser;
    } else {
      var data = jsonDecode(response.body);
      UserModel getUser = UserModel.fromJson(data);
      // print(response.body);
      return getUser;
    }
  }

  Future<ResponseModel2> putUserSelf(
    {
      String? name,
      String? email,
      String? phone
    }
  ) async{
    var linkUrl = '/api/user';
    var _body = jsonEncode({
      'phone': phone,
      'email': email,
      'name': name,
    });
    print(_body);
    final prefs = await SharedPreferences.getInstance();
    final String? sptoken = prefs.getString('token');
    // print(_body);
    var response = await http.put(
      Uri.parse(baseUrl + linkUrl),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: 'Bearer ' + sptoken.toString()
      },
      body: _body
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      ResponseModel2 putUser = ResponseModel2.fromJson(data);
      print(response.body);
      return putUser;
    } else {
      var data = jsonDecode(response.body);
      ResponseModel2 putUser = ResponseModel2.fromJson(data);
      print(response.body);
      return putUser;
    }
  }


  Future <PackageModelV3> postPackage({int? motif_id, int? size_id,int? product_id}) async{
    var linkUrl ='/api/package';
    var _body = jsonEncode({'motif_id': motif_id, 'size_id': size_id,'product_id' : product_id});
    // var _body = PackageModel(
    //   motifId : motif_id,
    //   sizeId : size_id,
    //   productId : product_id
    // );
    // print('motif_id ');
    // print(_body);
    final prefs = await SharedPreferences.getInstance();
    final String? sptoken = prefs.getString('token');

    var response = await http.post(
      Uri.parse(baseUrl + linkUrl),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: 'Bearer ' + sptoken.toString()
        },
        body: _body
    );
    
    if (response.statusCode == 200){
      var data = jsonDecode(response.body);
      print(response.body);
      PackageModelV3 postPackageModel = PackageModelV3.fromJson(data);
      return postPackageModel;
    }else {
      var data = jsonDecode(response.body);
      print(response.body);
      PackageModelV3 postPackageModel = PackageModelV3.fromJson(data);
      return postPackageModel;
    }
  }

  Future<PackageModelV4>? getPackageById(int id) async{
    var linkUrl = '/api/package/$id';
    final prefs = await SharedPreferences.getInstance();
    final String? sptoken = prefs.getString('token');

    var response = await http.get(
      Uri.parse(baseUrl + linkUrl),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: 'Bearer ' + sptoken.toString()
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      PackageModelV4 packageModel = PackageModelV4.fromJson(data);
      // print('log');
      // print(packageModel);
      // print(response.body);
      return packageModel;
    } else {
      var data = jsonDecode(response.body);
      PackageModelV4 packageModel = PackageModelV4.fromJson(data);
      // print(response.body);
      return packageModel;
    }
  }

  Future<PackageModelV3> putPackageById({
    int? id,
    int? motif_id,
    int? size_id,
    int? product_id,
    int? method_id,
    int? shipping_id,
    String? note,
    String? address,
  }) async{
    var linkUrl = '/api/package';
    var _body = jsonEncode({
      'motif_id': motif_id, 
      'size_id': size_id,
      'product_id' : product_id,
      'id' : id,
      'method_id' : method_id,
      'shipping_id' : shipping_id,
      'note' : note,
      'address' : address,
    });
    final prefs = await SharedPreferences.getInstance();
    final String? sptoken = prefs.getString('token');

    var response = await http.put(
      Uri.parse(baseUrl + linkUrl),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: 'Bearer ' + sptoken.toString()
      },
      body: _body

    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      PackageModelV3 packageModel = PackageModelV3.fromJson(data);
      print('log');
      // print(packageModel);
      print(response.body);
      return packageModel;
    } else {
      var data = jsonDecode(response.body);
      PackageModelV3 packageModel = PackageModelV3.fromJson(data);
      // print(response.body);
      return packageModel;
    }
  }

  Future<ResponseModel2> postSizeProduct(
    int? product_id,
    String? name
  ) async{
    var linkUrl = '/api/size';
    var _body = jsonEncode({
      'product_id': product_id,
      'name': name,
    });
    print(_body);
    final prefs = await SharedPreferences.getInstance();
    final String? sptoken = prefs.getString('token');
     var response = await http.post(Uri.parse(baseUrl + linkUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + sptoken.toString()
      },
      body: _body,
      // print(body);
    );
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      ResponseModel2 postSize = ResponseModel2.fromJson(data);
      print('log');
      print(response.body);
      return postSize;
    } else {
      var data = jsonDecode(response.body);
      ResponseModel2 postSize = ResponseModel2.fromJson(data);
      return postSize;
    }
  }

  Future<OrderMordel> postOrder(
    int? package_id,
    int? amount
  )async{
    var linkUrl = '/api/order';
    final prefs = await SharedPreferences.getInstance();
    final String? sptoken = prefs.getString('token');
    var _body = jsonEncode({
      'package_id': package_id,
      'amount': amount,
    });
    var response = await http.post(Uri.parse(baseUrl + linkUrl),
    headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + sptoken.toString()
      },
      body: _body,
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      OrderMordel order = OrderMordel.fromJson(data);
      print('log');
      print(response.body);
      return order;
    } else {
      var data = jsonDecode(response.body);
      OrderMordel order = OrderMordel.fromJson(data);
      return order;
    }
  }
    




  Future<bool> logout() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final token = storage.getString('token');
    if (token != null) {
      await storage.remove('token');
      return true;
    } else {
      return false;
    }
  }
}
