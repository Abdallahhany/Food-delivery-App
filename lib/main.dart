import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food/Screens/mainScreen.dart';
import 'package:food/pages/signInPage.dart';
import 'package:food/pages/signUpPage.dart';
import 'package:food/scopedModel/foodScoppedModel.dart';
import 'package:food/scopedModel/mainScoppedModel.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MainModel mainModel = MainModel();

  Widget page = SignUpPage();

  final storage = new FlutterSecureStorage();

  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin()async{
    String token = await storage.read(key: "token");
    if (token != null ){
      setState(() {
        page = MainScreen(mainModel: mainModel,);
      });
    }else{
      setState(() {
        page = SignInPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
        model: mainModel,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Food Delivery App',
          theme: ThemeData(primaryColor: Colors.blueAccent),
          home: page,
        ));
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
