import 'package:flutter/material.dart';
import 'package:food/models/food.dart';
import 'package:food/scopedModel/mainScoppedModel.dart';
import 'package:food/widgets/boughtFoods.dart';
import 'package:food/widgets/foodCategory.dart';
import 'package:food/widgets/HomeTopInfo.dart';
import 'package:food/widgets/searchField.dart';
import 'package:food/widgets/vewAll.dart';
import 'package:scoped_model/scoped_model.dart';

import 'foodDetails.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Food> _foods = foods;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal:20.0,vertical: 10.0),
        shrinkWrap: true,
        children: [
          HomeTopInfo(),
          FoodCategory(),
          SizedBox(
            height: 20.0,),
          SearchField(),
          SizedBox(
            height: 20.0,
          ),
          ViewAll(),
          SizedBox(
            height: 20.0,
          ),
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              return Column(
                children: model.foods.map(_buildFoodItems).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
  Widget _buildFoodItems(Food food) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => FoodDetails(
            food: food,
          ),
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        child: BoughtFood(
          id: food.id,
          name: food.name,
          imagePath: food.imagePath,
          category: food.category,
          discount: food.discount,
          price: food.price,
          ratings: food.ratings,
        ),
      ),
    );
  }
}
