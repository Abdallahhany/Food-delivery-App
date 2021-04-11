import 'package:flutter/material.dart';
import 'package:food/models/food.dart';
import 'package:food/scopedModel/foodScoppedModel.dart';
import 'package:food/scopedModel/mainScoppedModel.dart';
import 'package:food/widgets/button.dart';

class FoodDetails extends StatelessWidget {
  final Food food;
  FoodDetails({this.food});
  MainModel model = MainModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Food Details",
          style: TextStyle(fontSize: 28.0, color: Colors.black),
        ),
        backgroundColor: Colors.white10,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: ListView(
          children: <Widget>[
            Container(
              height: 200.0,
              width: MediaQuery.of(context).size.width,
              child: Image(image: model.getFoodImage(food.id),fit: BoxFit.cover,),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  food.name,
                  style: TextStyle(fontSize: 24.0, color: Colors.black,fontWeight: FontWeight.bold),
                ),
                Text(
                  "\u{20b5} ${food.price}",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Description:",
              style: TextStyle(fontSize: 24.0, color: Colors.black),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "${food.description}",
              style: TextStyle(fontSize: 18.0,fontStyle: FontStyle.italic),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(icon: Icon(Icons.add_circle,color: Theme.of(context).primaryColor,), onPressed: (){}),
                SizedBox(
                  width: 15.0,
                ),
                Text(
                  "1",
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                IconButton(icon: Icon(Icons.remove_circle,color: Theme.of(context).primaryColor,), onPressed: (){}),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            InkWell(
              onTap: (){},
              child: Button(
                btnText: "Add to cart",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
