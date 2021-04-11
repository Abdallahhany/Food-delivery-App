import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food/admin/addFood.dart';
import 'package:food/models/food.dart';
import 'package:food/scopedModel/mainScoppedModel.dart';
import 'package:food/widgets/foodItemCard.dart';
import 'package:food/widgets/showDialog.dart';
import 'package:scoped_model/scoped_model.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  GlobalKey<ScaffoldState> _explorePageScaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _explorePageScaffoldKey,
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ScopedModelDescendant<MainModel>(
                builder: (BuildContext context, Widget child, MainModel model) {
                  model.fetchFoods();
                  List<Food> foods = model.foods;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: foods.map((Food food) {
                      return InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddFoodItem(food: food,)));
                        },
                        onLongPress: ()async{
                          showLoadingIndicator(context,"deleting food");
                          var response = await model.deleteFood(food.id);
                          if(jsonDecode(response.body)["msg"] == true){
                            print(jsonDecode(response.body)["msg"]);
                            Navigator.of(context).pop();
                            SnackBar snackBar = SnackBar(
                              backgroundColor: Theme.of(context).primaryColor,
                              content: Text("Food deleted Successfully"),
                              duration: Duration(milliseconds: 3000),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }else{
                            Navigator.of(context).pop();
                            SnackBar snackBar = SnackBar(
                              backgroundColor: Theme.of(context).primaryColor,
                              content: Text("Failed to delete Food"),
                              duration: Duration(milliseconds: 3000),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: FoodItemCard(
                          title: food.name,
                          description: food.description,
                          price: food.price,
                          id: food.id,
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        )
    );
  }
}
