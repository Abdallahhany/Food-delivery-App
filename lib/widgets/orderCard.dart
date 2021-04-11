import 'package:flutter/material.dart';

class OrderCard extends StatefulWidget {
  final int number;
  final int rate;

  final String imagePath;
  final String foodName;
  final String kind;
  OrderCard({
    this.number,
    this.rate,
    this.imagePath,
    this.foodName,
    this.kind
});

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFD3D3D3), width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              height: 75.0,
              width: 45.0,
              child: Column(
                children: [
                  InkWell(
                    child:
                        Icon(Icons.keyboard_arrow_up, color: Color(0xFFD3D3D3)),
                    onTap: () {},
                  ),
                  Text("${widget.number}",
                      style: TextStyle(fontSize: 18.0, color: Colors.grey)),
                  InkWell(
                    child: Icon(Icons.keyboard_arrow_down,
                        color: Color(0xFFD3D3D3)),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Container(
              height: 70.0,
              width: 70.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/${widget.imagePath}"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(35.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 5.0,
                        offset: Offset(0.0, 2.0)
                    ),
                  ]
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.foodName,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.0),
                Text(
                  "\u023B ${widget.rate}",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.0),
                Container(
                  height: 25.0,
                  width: 120.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(widget.kind,
                              style: TextStyle(
                                  color: Color(0xFFD3D3D3),
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 5.0,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "x",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            InkWell(
              onTap: () {},
              child: Icon(
                Icons.cancel,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
