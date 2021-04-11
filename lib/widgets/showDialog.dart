import 'package:flutter/material.dart';

Future<void> showLoadingIndicator(BuildContext context, String title) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 10.0,
              ),
              Text(title),
            ],
          ),
        );
      });
}