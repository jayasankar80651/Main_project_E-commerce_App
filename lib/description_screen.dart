import 'package:e_commerce_app/cart_screen.dart';
import 'package:flutter/material.dart';

class DescriptionPageScreen extends StatefulWidget {
  final productname;
  final image;
  final price;
  final description;
  const DescriptionPageScreen({
    super.key,
    required this.productname,
    required this.image,
    required this.price,
    required this.description,
  });

  @override
  State<DescriptionPageScreen> createState() => _DescriptionPageScreenState();
}

class _DescriptionPageScreenState extends State<DescriptionPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(image: NetworkImage(widget.image)),
              ),
            ),
            SizedBox(height: 10),
           
            SizedBox(height: 10),
            Text(
              widget.productname,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(widget.description, style: TextStyle(fontSize: 15)),

            SizedBox(height: 10),
            Row(
              children: [
                Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text("₹"+
                    widget.price ,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartPageScreen (
                              name:widget.productname,
                              image: widget.image,
                              price: widget.price,
                             
                      )),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "ADD TO CART",
                        style: TextStyle(
                          color: Colors.amber[900],
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
