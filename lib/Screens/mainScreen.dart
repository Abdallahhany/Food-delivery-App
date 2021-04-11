import 'package:flutter/material.dart';
import 'package:food/admin/addFood.dart';
import 'package:food/pages/explorePage.dart';
import 'package:food/pages/homePage.dart';
import 'package:food/pages/orderPage.dart';
import 'package:food/pages/profilePage.dart';
import 'package:food/scopedModel/mainScoppedModel.dart';

class MainScreen extends StatefulWidget {
  final MainModel mainModel;
  MainScreen({this.mainModel});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTapIndex = 0;
  HomePage homePage;
  OrderPage order;
  ExplorePage favoritePage;
  ProfilePage profilePage;
  List<Widget> pages;
  Widget currentPage;

  @override
  void initState() {
    super.initState();
    widget.mainModel.fetchFoods();
    homePage = HomePage();
    order = OrderPage();
    favoritePage = ExplorePage();
    profilePage = ProfilePage(model: widget.mainModel,);
    pages = [homePage, favoritePage, order, profilePage];
    currentPage = homePage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 35.0,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => AddFoodItem()));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              currentTapIndex = index;
              currentPage = pages[index];
            });
          },
          currentIndex: currentTapIndex,
          type: BottomNavigationBarType.fixed,
          iconSize: 30.0,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.explore,
                ),
                label: "Explore"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                label: "Orders"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: "Profile"),
          ],
        ),
        body: currentPage,
        appBar: AppBar(
          title: Text(
            currentTapIndex == 0
                ? " Food Delivery App "
                : currentTapIndex == 1
                    ? " All Food Items "
                    : currentTapIndex == 2
                        ? " Your Food Card "
                        : currentTapIndex == 3
                            ? " Profile "
                            : null,
            style: TextStyle(color: Colors.black, fontSize: 28.0),
          ),
          //centerTitle: true,
          backgroundColor: Colors.white10,
          elevation: 0.0,
          actions: [
            IconButton(
                icon: _shoppingCart(),
                onPressed: () {}),
            IconButton(
                icon: Icon(Icons.notifications_none,
                    size: 28.0, color: Theme.of(context).primaryColor),
                onPressed: () {}),
          ],
        ));
  }
  Widget _shoppingCart() {
    return Stack(
      children: <Widget>[
        Icon(
          Icons.shopping_cart_outlined,
          size: 28.0,
          color: Theme.of(context).primaryColor,
        ),
        Positioned(
          top: 0.0,
          right: 0.0,
          child: Container(
            height: 12.0,
            width: 12.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.red,
            ),
            child: Center(
              child: Text(
                "1",
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
