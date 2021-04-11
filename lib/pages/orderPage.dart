import 'package:flutter/material.dart';
import 'package:food/widgets/orderCard.dart';
import 'package:food/data/orderData.dart';


class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final textStyle = TextStyle(
      color: Color(0xFF9BA7C6),
      fontSize: 16.0,
      fontWeight: FontWeight.bold
  );
  final numberStyle = TextStyle(
      color: Color(0xFF6C6D6D),
      fontSize: 16.0,
      fontWeight: FontWeight.bold
  );
  List<OrderCard> _orders = orderData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
        children:[
          Column(
            children:  _orders.map((_buildOrder) ).toList(),
          ),
          _buildContainer(),

        ],
      ),
    );
  }
  Widget _buildOrder(OrderCard orderCard){
    return OrderCard(
      foodName: orderCard.foodName,
      number: orderCard.number,
      imagePath: orderCard.imagePath,
      kind: orderCard.kind,
      rate: orderCard.rate,
    );
  }
  Widget _buildContainer(){
    return Container(
      height: 240.0,
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Subtotal",
                style: textStyle
              ),
              Text(
                "23.0",
                style: numberStyle
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Discount",
                style: textStyle
              ),
              Text(
                "10.0",
                style: numberStyle
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Tax",
                style:textStyle
              ),
              Text(
                "0.5",
                style: numberStyle
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Divider(
            height: 2.0,
            color: Colors.black,
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Cart Total",
                style: textStyle
              ),
              Text(
                "26.5",
                style: numberStyle
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          InkWell(
            onTap: () {
              //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SignInPage()));
            },
            child: Container(
              height: 50.0,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(35.0),
              ),
              child: Center(
                child: Text(
                  "Proceed To Checkout",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
