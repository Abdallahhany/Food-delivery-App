import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:food/models/food.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class FoodModel extends Model {
  List<Food> _foods = [];
  List<Food> get foods {
    return List.from(_foods);
  }

  int get foodLength {
    return _foods.length;
  }

  Future<http.Response> addFood(Map<String, dynamic> body) async {
    var url = Uri.parse('https://192.168.1.4:8080/foods/addFood');
    var response = await http.post(
      url,
      body: jsonEncode(body),
      headers: {
        "Content-type": "application/json",
      },
    );
    Food foodData = Food(
      name: body["name"],
      description: body["description"],
      category: body["category"],
      price: body["price"],
      discount: body['discount'],
    );
    _foods.add(foodData);
    return response;
  }

  Future<http.Response> updateFood(String foodID, Map<String, dynamic> body) async{
    var url = Uri.parse('https://192.168.1.4:8080/foods/updateFood/$foodID');
    var response = await http.put(
        url,
      body: jsonEncode(body),
      headers: {
          "Content-type": "application/json",
        },
    );
        Food foodData = Food(
          name: body["name"],
          description: body["description"],
          category: body["category"],
          price: body["price"],
          discount: body['discount'],
        );
        _foods.add(foodData);
    return response ;
  }

  Future fetchFoods() async{
    var url = Uri.parse('https://192.168.1.4:8080/foods/getFoods');
    var response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      //print(response.body);
      final List fetchedData = jsonDecode(response.body);
      final List<Food> fetchedFoodItem = [];
      fetchedData.forEach((data) {
        Food food = Food(
            id: data["_id"],
            category: data["category"],
            name: data["name"],
            imagePath: data["coverImage"],
            price: data["price"],
            discount: data["discount"],
            ratings: data["rate"],
            description: data["description"]);
        fetchedFoodItem.add(food);
      });
      _foods = fetchedFoodItem;
      notifyListeners();
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }
  
  Future<http.Response> deleteFood(String id) async{
    var url = Uri.parse('https://192.168.1.4:8080/foods/deleteFood/$id');
    var response = await http.delete(url,
      headers: {
      "Content-type": "application/json",
    },);
    _foods.removeWhere((Food food) => food.id == id);
    return response;
  }

  NetworkImage getFoodImage(String imageName) {
    var baseUrl = Uri.parse(
      'https://192.168.1.4:8080/uploads//$imageName.jpg',
    );
    return NetworkImage(baseUrl.toString());
  }

  Future<http.StreamedResponse> patchImage(String filePath, String id) async {
    var baseUrl = Uri.parse(
      'https://192.168.1.4:8080/foods/add/coverImage/$id',
    );
    var request = http.MultipartRequest('PATCH', baseUrl);
    request.files.add(await http.MultipartFile.fromPath("img", filePath));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
    });
    var response = request.send();
    return response;
  }
  
}
