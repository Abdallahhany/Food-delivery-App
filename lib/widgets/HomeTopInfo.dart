import 'package:flutter/material.dart';

class HomeTopInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(fontSize: 32,fontWeight: FontWeight.bold);
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("What Would You",style:titleStyle,),
              Text("Like To Eat?",style: titleStyle,),
            ],
          ),
        ],
      ),
    );
  }
}
