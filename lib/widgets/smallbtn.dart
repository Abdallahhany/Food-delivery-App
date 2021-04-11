import 'package:flutter/material.dart';
class SmallButton extends StatelessWidget {
  final String title;
  SmallButton({this.title});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
        height: 25.0,
        width: 60.0,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Center(child:Text(title,style: TextStyle(color: Colors.blue , fontSize: 16.0),)),
      ),
    );
  }
}
