import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food/Screens/mainScreen.dart';
import 'package:food/pages/signInPage.dart';
import 'package:food/scopedModel/mainScoppedModel.dart';
import 'package:scoped_model/scoped_model.dart';

import 'homePage.dart';


class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _toggleVisibility = true;
  TextEditingController userNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController fullNameController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool validate = false;
  bool circular = false;
  String errorMsg;
  final storage = new FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.grey.shade100,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 40.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Card(
                    elevation: 5.0,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          _usernameTextField(),
                          SizedBox(
                            height: 20.0,
                          ),
                          _emailTextField(),
                          SizedBox(
                            height: 20.0,
                          ),
                          _passwordTextField(),
                          SizedBox(
                            height: 20.0,
                          ),
                          _fullNameTextField(),
                          SizedBox(
                            height: 20.0,
                          ),
                          _phoneNumberTextField(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  //_signUpButton(),
                  ScopedModelDescendant(
                      builder: (BuildContext context, Widget child, MainModel model){
                        return InkWell(
                          //check user
                          onTap: () async {
                            setState(() {
                              circular = true;
                            });
                            if(userNameController.text.isEmpty){
                              setState(() {
                                circular = false;
                                validate = false ;
                                errorMsg = " username can't be empty ";
                              });
                            }
                            else{
                              var response = await model.get(
                                  "checkusername/${userNameController.text}");
                              if (response['status']){
                                setState(() {
                                  //circular = false;
                                  validate = false ;
                                  errorMsg = " username is already used ";
                                });
                              }
                              else{
                                validate = true;
                              }
                            }
                            //end check user
                            if(_formKey.currentState.validate() && validate) {
                              Map <String,String> data ={
                                "username"    :userNameController.text,
                                "email"       :emailController.text,
                                "password"    :passwordController.text,
                                "fullName"    :fullNameController.text,
                                "phoneNumber" :phoneNumberController.text
                              };
                              print (data);
                              await model.post(data,'signup');
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
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Network Error')));
                              }
                              setState(() {
                                circular = false;
                              });
                            }else{
                              setState(() {
                                circular = false;
                              });
                            }
                          },
                          child: Container(
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(35.0),
                            ),
                            child: Center(
                              child:circular ? CircularProgressIndicator(backgroundColor: Colors.white,) : Text(
                                "Sign Up",
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
                        "Already have an account?",
                        style: TextStyle(
                            color: Color(0xFFBDC2CB),
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                      SizedBox(width: 10.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (BuildContext context) => SignInPage()));
                        },
                        child: Text(
                          "Sign In",
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
      ),
    );
  }
  Widget _emailTextField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: "Email",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
      ),
      controller: emailController,
      validator: (String email) {
        String errorMessage;
        if (!email.contains("@")) {
          errorMessage = "Your email is incorrect";
        }
        if (email.isEmpty) {
          errorMessage = "Your email field is required";
        }

        return errorMessage;
      },
    );
  }
  Widget _usernameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        errorText: validate ? null : errorMsg,
        hintText: "Username",
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
              ? Icon(Icons.visibility_off)
              : Icon(Icons.visibility),
        ),
      ),
      obscureText: _toggleVisibility,
      controller: passwordController,
      validator: (String password) {
        String errorMessage;

        if (password.isEmpty) {
          errorMessage = "Your password is required";
        }
        return errorMessage;
      },
    );
  }
  Widget _fullNameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Full Name",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
      ),
      controller: fullNameController,
      validator: (String fullName) {
        String errorMessage;
        if (fullName.isEmpty) {
          errorMessage = "Your Name is required";
        }
        return errorMessage;
      },
    );
  }
  Widget _phoneNumberTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Phone Number",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
      ),
      keyboardType:TextInputType.number ,
      controller: phoneNumberController,
      validator: (String phoneNumber) {
        String errorMessage;
        if (phoneNumber.isEmpty) {
          errorMessage = "Your Phone Number required";
        }
        return errorMessage;
      },
    );
  }

}
