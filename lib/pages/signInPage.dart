import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food/Screens/mainScreen.dart';
import 'package:food/pages/signUpPage.dart';
import 'package:food/scopedModel/mainScoppedModel.dart';
import 'package:food/widgets/button.dart';
import 'package:scoped_model/scoped_model.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool _toggleVisibility = true;
  TextEditingController userNameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool validate = false;
  bool circular = false;
  String errorMsg;
  final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 60.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 70.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "Forgotten Password?",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Card(
                      elevation: 5.0,
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            _emailTextField(),
                            SizedBox(
                              height: 20.0,
                            ),
                            _passwordTextField(),
                            SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    ScopedModelDescendant(
                        builder: (BuildContext context, Widget child,
                            MainModel model) {
                          return InkWell(
                            onTap: ()async{
                              setState(() {
                                circular = true;
                              });
                              Map <String,String> data ={
                                "username":userNameController.text,
                                "password":passwordController.text,
                              };
                              var response = await model.post(data, 'login');
                              if(response.statusCode ==200 || response.statusCode == 201){
                                Map<String,dynamic> output = await jsonDecode(response.body);
                                print(output['token']);
                                await storage.write(key: "token", value: output['token']);
                                setState(() {
                                  validate = true;
                                  circular = false;
                                });
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>MainScreen(mainModel: model,)),(route)=>false);
                              }
                              else{
                                String output = await jsonDecode(response.body);
                                setState(() {
                                  validate = false;
                                  errorMsg = output;
                                  circular = false;
                                });
                              }
                            },
                            child: Container(
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                borderRadius: BorderRadius.circular(35.0),
                              ),
                              child: Center(
                                child: circular ? CircularProgressIndicator(
                                  backgroundColor: Colors.white,) : Text(
                                  "Sign In",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                    ),
                    Divider(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                              color: Color(0xFFBDC2CB),
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        SizedBox(width: 10.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SignUpPage()));
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        errorText: validate ? null : errorMsg,
        hintText: "User Name",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
      ),
      controller: userNameController,
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        errorText: validate ? null : errorMsg,
        hintText: "Password",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _toggleVisibility = !_toggleVisibility;
            });
          },
          icon: _toggleVisibility
              ?
          Icon(Icons.visibility_off)
              :
          Icon(Icons.visibility),
        ),
      ),
      obscureText: _toggleVisibility,
      controller: passwordController,
    );
  }
}