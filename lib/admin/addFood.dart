import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food/models/food.dart';
import 'package:food/scopedModel/mainScoppedModel.dart';
import 'package:food/widgets/button.dart';
import 'package:food/widgets/showDialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class AddFoodItem extends StatefulWidget {
  final Food food;
  AddFoodItem({this.food});
  @override
  _AddFoodItemState createState() => _AddFoodItemState();
}

class _AddFoodItemState extends State<AddFoodItem> {
  GlobalKey<ScaffoldState> _stateKey = GlobalKey();
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _nameEditingController = new TextEditingController();
  TextEditingController _categoryEditingController =
      new TextEditingController();
  TextEditingController _descriptionEditingController =
      new TextEditingController();
  TextEditingController _priceEditingController = new TextEditingController();
  TextEditingController _discountEditingController =
      new TextEditingController();
  final ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;
  MainModel model;
  checkData(){
    if(widget.food !=null){
      _nameEditingController.text = widget.food.name;
      _categoryEditingController.text = widget.food.category;
      _descriptionEditingController.text = widget.food.description;
      _priceEditingController.text = widget.food.price;
      _discountEditingController.text =widget.food.discount;
    }
  }

  @override
  void initState() {
    checkData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _stateKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white10,
        title: Text(
          widget.food != null ? "Update Food Item" : "Add Food Item",
          style: TextStyle(
              color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              foodImage(),
              SizedBox(
                height: 10,
              ),
              _nameFormField(),
              SizedBox(
                height: 10,
              ),
              _categoryFormField(),
              SizedBox(
                height: 10,
              ),
              _descriptionFormField(),
              SizedBox(
                height: 10,
              ),
              _priceFormField(),
              SizedBox(
                height: 10,
              ),
              _discountFormField(),
              SizedBox(
                height: 20.0,
              ),
              ScopedModelDescendant(
                builder: (BuildContext context, Widget child, MainModel model) {
                  return InkWell(
                    onTap: () async{
                      if(widget.food != null){
                          showLoadingIndicator(context, "Updating Food Item.....");
                          if (_formKey.currentState.validate()) {
                            final Map<String, String> foodData = {
                              "name": _nameEditingController.text,
                              "category": _categoryEditingController.text,
                              "price": _priceEditingController.text,
                              "discount": _discountEditingController.text,
                              "description": _descriptionEditingController.text
                            };
                            var response = await model.updateFood(widget.food.id,foodData);
                            if (response.statusCode == 200 ||
                                response.statusCode == 201){
                              if (_imageFile.path != null) {
                                var imageResponse =
                                await model.patchImage(_imageFile.path, widget.food.id);
                                print(imageResponse.statusCode);
                                if (imageResponse.statusCode == 200 ||
                                    imageResponse.statusCode == 201) {
                                  Navigator.of(context).pop();
                                  SnackBar snackBar = SnackBar(
                                    backgroundColor: Theme.of(context).primaryColor,
                                    content: Text("Food updated Successfully"),
                                    duration: Duration(milliseconds: 3000),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              } else if(_imageFile.path == null) {
                                Navigator.of(context).pop();
                                SnackBar snackBar = SnackBar(
                                  backgroundColor: Theme.of(context).primaryColor,
                                  content: Text("Food updated Successfully"),
                                  duration: Duration(milliseconds: 3000),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            }else{
                              Navigator.of(context).pop();
                              SnackBar snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text("Food doesn't exist"),
                                duration: Duration(milliseconds: 3000),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                          Navigator.of(context).pop();
                      }
                      else{
                          showLoadingIndicator(context, "Adding Food Item.....");
                          if (_formKey.currentState.validate()) {
                            final Map<String, String> foodData = {
                              "name": _nameEditingController.text,
                              "category": _categoryEditingController.text,
                              "price": _priceEditingController.text,
                              "discount": _discountEditingController.text,
                              "description": _descriptionEditingController.text
                            };
                            var response = await model.addFood(foodData);
                            if (response.statusCode == 200 ||
                                response.statusCode == 201) {
                              String id = jsonDecode(response.body)["data"];
                              print(id);
                              if (_imageFile.path != null) {
                                var imageResponse =
                                await model.patchImage(_imageFile.path, id);
                                print(imageResponse.statusCode);
                                if (imageResponse.statusCode == 200 ||
                                    imageResponse.statusCode == 201) {
                                  Navigator.of(context).pop();
                                  SnackBar snackBar = SnackBar(
                                    backgroundColor: Theme.of(context).primaryColor,
                                    content: Text("Food Added Successfully"),
                                    duration: Duration(milliseconds: 3000),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              } else {
                                Navigator.of(context).pop();
                                SnackBar snackBar = SnackBar(
                                  content: Text("please provide food image"),
                                  duration: Duration(milliseconds: 3000),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            }
                          }
                          Navigator.of(context).pop();
                      }
                    },
                    child: Button(
                        btnText: widget.food != null
                            ? "Update Food"
                            : "Add Food"
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }



  void takePhoto(ImageSource source) async {
    final pickedImage = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedImage;
    });
  }

  Widget foodImage() {
    return Center(
      child: Stack(
          children:[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 170.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: _imageFile == null
                      ? AssetImage("assets/noimage.png")
                      : FileImage(File(_imageFile.path)),
                ),
              ),
            ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => bottomSheet()),
                );
              },
              child: Icon(
                Icons.camera_alt,
                color: Theme.of(context).primaryColor,
                size: 40.0,
              ),
            ),
          ),
      ]),
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
            "Choose Food photo",
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
          ])
        ],
      ),
    );
  }

  Widget _nameFormField() {
    return TextFormField(
      // initialValue:widget.food != null ? widget.food.name : "",
      controller: _nameEditingController,
      decoration: InputDecoration(
        hintText: "Food Name",
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.blue,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.blue,
          width: 2,
        )),
      ),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value.isEmpty) return "the name can't be empty";
        return null;
      },
    );
  }

  Widget _categoryFormField() {
    return TextFormField(
      //initialValue:widget.food != null ? widget.food.category : null,
      controller: _categoryEditingController,
      decoration: InputDecoration(
        hintText: "category",
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.blue,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.blue,
          width: 2,
        )),
      ),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value.isEmpty) return "the Category field can't be empty";
        return null;
      },
    );
  }

  Widget _descriptionFormField() {
    return TextFormField(
    //  initialValue:widget.food != null ? widget.food.description : null,
      controller: _descriptionEditingController,
      decoration: InputDecoration(
        hintText: "description",
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.blue,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.blue,
          width: 2,
        )),
      ),
      maxLines: 6,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value.isEmpty) return "the name can't be empty";
        return null;
      },
    );
  }

  Widget _priceFormField() {
    return TextFormField(
     // initialValue:widget.food != null ? widget.food.price : null,
      controller: _priceEditingController,
      decoration: InputDecoration(
        hintText: "price",
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.blue,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.blue,
          width: 2,
        )),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) return "the price field can't be empty";
        return null;
      },
    );
  }

  Widget _discountFormField() {
    return TextFormField(
      //initialValue:widget.food != null ? widget.food.discount : null,
      controller: _discountEditingController,
      decoration: InputDecoration(
        hintText: "discount",
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.blue,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.blue,
          width: 2,
        )),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) return "the discount field can't be empty";
        return null;
      },
    );
  }
}
