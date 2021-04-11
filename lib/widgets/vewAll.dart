import 'package:flutter/material.dart';
import 'package:food/Screens/mainScreen.dart';
import 'package:food/pages/explorePage.dart';


class ViewAll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Frequently Bought Foods",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          onTap: () {},
          child: Text(
            "View all",
            style: TextStyle(
              color: Colors.orangeAccent,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
      ],
    );
  }
}
