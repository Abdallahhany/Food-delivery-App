
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:food/models/userModel.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  User _user;
  User get users {
    return _user;
  }
  final storage = new FlutterSecureStorage();
  Future<http.Response> post(Map<String,String>body,String url)async{
    String token = await storage.read(key: "token");
    var baseUrl = Uri.parse("https://192.168.1.4:8080/users/$url");
    var response = await http.post(
        baseUrl,
        body:jsonEncode(body),
        headers:{
          "Content-type": "application/json",
          "Authorization": "Bearer $token"
        }
    );
    //Map<String,dynamic>fetchedData = body;
    _user = User(
      userName: body["username"],
      password: body["password"],
      email: body["email"],
      fullName: body["fullName"],
      phoneNumber:body["phoneNumber"],
      image: body["image"]
    );
    print(_user.userName);
    return response;
  }
  Future get(String userName)async{
    String token = await storage.read(key: "token");
    var baseUrl = Uri.parse('https://192.168.1.4:8080/users/$userName');
    var response = await http.get(baseUrl,headers: {"Authorization":"Bearer $token"});
    if(response.statusCode == 200 || response.statusCode ==201){
      print(response.body);
      // _user = User(
      //   userName: jsonDecode(response.body)["data"]["username"],
      //   password: jsonDecode(response.body)["data"]["password"],
      //   email: jsonDecode(response.body)["data"]["email"],
      //   fullName: jsonDecode(response.body)["data"]["fullName"],
      //   phoneNumber:jsonDecode(response.body)["data"]["phoneNumber"],
      // );
      // print(_user.userName);
      return jsonDecode(response.body);
    }
    print(response.body);
    print(response.statusCode);
  }
  NetworkImage getProfileImage(String imageName) {
    var baseUrl = Uri.parse(
      'https://192.168.1.4:8080/images//$imageName.jpg',
    );
    return NetworkImage(baseUrl.toString());
  }

  Future<http.StreamedResponse> patchImage(String filePath, String username) async {
    String token = await storage.read(key: "token");
    var baseUrl = Uri.parse(
      'https://192.168.1.4:8080/users/add/image/$username',
    );
    var request = http.MultipartRequest('PATCH', baseUrl);
    request.files.add(await http.MultipartFile.fromPath("img", filePath));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
      "Authorization": "Bearer $token"

    });
    var response = request.send();
    return response;
  }

}