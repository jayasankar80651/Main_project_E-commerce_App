import 'package:e_commerce_app/Razorpay_screen.dart';
import 'package:flutter/material.dart';

class CartPageScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItem;
  final int totalAmount;
  final name;
  final image;
  final price;
  const CartPageScreen({
    super.key,
    required this.totalAmount,
    required this.cartItem,
    required this.name,
    required this.image,
    required this.price,
  });

  @override
  State<CartPageScreen> createState() => _CartPageScreenState();
}

class _CartPageScreenState extends State<CartPageScreen> {
  List<Map<String, dynamic>> Cart = [];
  void initState() {
    super.initState();
    int itemprice;
    if (widget.price is int) {
      itemprice = widget.price;
    } else if (widget.price is String) {
      itemprice = int.tryParse(widget.price) ?? 0;
    } else {
      itemprice = 0;
    }
    Cart.add({
      "name": widget.name,
      "image": widget.image,
      "price": itemprice,
      "Quantity": 1,
    });
  }

  int? getTotalPrice() {
    int total = 0;
    for (var item in Cart) {
      total += (item["price"] as int) * (item["Quantity"] as int);
    }
    return total;
  }

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
        actions: [
          IconButton(
            onPressed: () {
              setState(() => Cart.clear());
            },
            icon: Icon(Icons.delete_sweep_sharp),
          ),
        ],
      ),
      body: Cart.isEmpty
          ? Center(child: Text("Cart is empty"))
          : ListView.builder(
              itemCount: Cart.length,
              itemBuilder: (context, index) {
                var item = Cart[index];
                return Card(
                  child: ListTile(
                    leading: Image.network(
                      Cart[index]['image'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),

                    title: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                Cart[index]['name'],
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(children: [Text("Price : ₹ ${item['price']}")]),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              CircleAvatar(
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        item['Quantity']++;
                                      });
                                    },
                                    icon: Icon(Icons.add),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                Cart[index]['Quantity'].toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 5),
                              CircleAvatar(
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (item["Quantity"] > 1) {
                                          item['Quantity']--;
                                        } else {
                                          Cart.removeAt(index);
                                        }
                                      });
                                    },
                                    icon: Icon(Icons.remove),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          Cart.removeAt(index);
                        });
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Text(
              "Total : ₹${getTotalPrice()}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                
               int? totalAmount = getTotalPrice();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RazorpayPage(
                      totalAmount: totalAmount!,
                      cartItem:Cart, 
                      amount: totalAmount),
                  ),
                );
              },
              child: Container(
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.amber[900],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "CheckOut",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
