import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final int numbers;
  FoodCard({this.name,this.imagePath,this.numbers});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16.0),
      child: Card(
        elevation: 5.0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Row(
            children: [
              Image(image:AssetImage("assets/$imagePath"),height: 65.0,width: 65.0,),
              SizedBox(width: 20.0,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(name,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                  Text("$numbers Kinds"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
