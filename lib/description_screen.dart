import 'package:e_commerce_app/cart_screen.dart';

import 'package:flutter/material.dart';

List<Map<String,dynamic>>wishList=[];
   

class DescriptionPageScreen extends StatefulWidget {
  final productname;
  final image;
  final int price;
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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          "Fashion store",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber[900],
      ),
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
                Center(
                  child: Text(
                    "₹" + widget.price.toString(),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Spacer(),

                //wishList button
                IconButton(
                  onPressed: () {
                    wishList.add({
                      "name": widget.productname,
                      "image": widget.image,
                      "price": widget.price,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Added to wishList")),
                    );
                  },
                  icon: Icon(Icons.favorite_border, color: Colors.red[700]),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPageScreen(
                          totalAmount: widget.price,
                          cartItem: [],
                          name: widget.productname ?? "no name",
                          image: widget.image ?? "",
                          price: widget.price.toString(),
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.shopping_cart_checkout),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
