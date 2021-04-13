import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food/models/userModel.dart';
import 'package:food/pages/signInPage.dart';
import 'package:food/scopedModel/mainScoppedModel.dart';
import 'package:food/widgets/customListTile.dart';
import 'package:food/widgets/smallbtn.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfilePage extends StatefulWidget {
  final MainModel model;
  ProfilePage({this.model});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool turnOnNotification = false;
  bool turnOnLocation = false;
  User user;
  final storage = new FlutterSecureStorage();

  getUserInfo() async {
    var response = await widget.model.get(widget.model.users.userName);
    print(widget.model.users.userName);
    user = new User(
      userName: response["data"]["username"],
      email: response["data"]["email"],
      fullName: response["data"]["fullName"],
      phoneNumber: response["data"]["phoneNumber"],
      image: response["data"]["image"],
    );
  }

  final ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(children: [
                Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60.0),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3.0,
                          offset: Offset(0, 4.0),
                          color: Colors.black38),
                    ],
                    image: DecorationImage(
                      image: _imageFile == null
                          ? user.image == ""
                              ? AssetImage("assets/profile.jpg")
                              : widget.model.getProfileImage(user.userName)
                          : FileImage(File(_imageFile.path)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 15.0,
                  right: 15.0,
                  child: InkWell(
                    onTap: () {
                      // showModalBottomSheet(
                      //   context: context,
                      //   builder: ((builder) => submitBottomSheet()),
                      // );
                      showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomSheet()),
                      );
                    },
                    child: Icon(
                      Icons.camera_alt,
                      color: Theme.of(context).primaryColor,
                      size: 30.0,
                    ),
                  ),
                ),
              ]),
              SizedBox(
                width: 20.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        user.fullName,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '(${user.userName})',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    user.email,
                    //"{userInfo.email}",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    user.phoneNumber,
                    //"{userInfo.email}",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  SmallButton(title: "Edit"),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            "Account",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Card(
            elevation: 3.0,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CustomListTile(
                    icon: Icons.location_on,
                    text: "Location",
                  ),
                  Divider(
                    height: 10.0,
                    color: Colors.grey,
                  ),
                  CustomListTile(
                    icon: Icons.visibility,
                    text: "Change Password",
                  ),
                  Divider(
                    height: 10.0,
                    color: Colors.grey,
                  ),
                  CustomListTile(
                    icon: Icons.shopping_cart,
                    text: "Shopping",
                  ),
                  Divider(
                    height: 10.0,
                    color: Colors.grey,
                  ),
                  CustomListTile(
                    icon: Icons.payment,
                    text: "Payment",
                  ),
                  Divider(
                    height: 10.0,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            "Notifications",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Card(
            elevation: 3.0,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "App Notification",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      Switch(
                        value: turnOnNotification,
                        onChanged: (bool value) {
                          // print("The value: $value");
                          setState(() {
                            turnOnNotification = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Divider(
                    height: 10.0,
                    color: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Location Tracking",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      Switch(
                        value: turnOnLocation,
                        onChanged: (bool value) {
                          // print("The value: $value");
                          setState(() {
                            turnOnLocation = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Divider(
                    height: 10.0,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            "Other",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Language", style: TextStyle(fontSize: 16.0)),
                    Divider(
                      height: 30.0,
                      color: Colors.grey,
                    ),
                    Text("Currency", style: TextStyle(fontSize: 16.0)),
                    Divider(
                      height: 30.0,
                      color: Colors.grey,
                    ),
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Logout",
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.red[700])),
                          Icon(
                            Icons.power_settings_new,
                            color: Colors.red[700],
                          ),
                        ],
                      ),
                      onTap: logOut,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          )
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Your Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            TextButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ]),
           _imageFile == null ? null : Container(
              height: 150.0,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Center(
                child: InkWell(
                  onTap: () async {
                    if (_imageFile.path != null) {
                      var imageResponse = await widget.model
                          .patchImage(_imageFile.path, user.userName);
                      print(imageResponse.statusCode);
                      if (imageResponse.statusCode == 200 ||
                          imageResponse.statusCode == 201) {
                        Navigator.of(context).pop();
                        SnackBar snackBar = SnackBar(
                          backgroundColor: Theme.of(context).primaryColor,
                          content: Text("Profile Image Updated Successfully"),
                          duration: Duration(milliseconds: 3000),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: Center(
                        child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    )),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedImage = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedImage;
    });
  }

  void logOut() async {
    await storage.delete(key: 'token');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SignInPage()),
        (route) => false);
  }
}
