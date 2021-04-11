import 'package:flutter/material.dart';
import 'package:food/data/categoryData.dart';
import 'package:food/models/category.dart';
import 'foodCard.dart';

class FoodCategory extends StatelessWidget {
  final List<Category> _categories = categories;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (BuildContext context, int index) {
          return FoodCard(
            name:_categories[index].name,
            numbers: _categories[index].numberOfItems,
            imagePath: _categories[index].imagePath,
          );
        },
      ),
    );
  }
}
