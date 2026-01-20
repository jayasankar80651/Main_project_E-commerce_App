import 'package:e_commerce_app/Home_Screen.dart';
import 'package:flutter/material.dart';

class MyOrderConfirmationPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItem;
  final int totalAmount;
  final String paymentId;
  const MyOrderConfirmationPage({
    super.key,
    required this.cartItem,
    required this.totalAmount,
    required this.paymentId,
  });

  @override
  State<MyOrderConfirmationPage> createState() =>
      _MyOrderConfirmationPageState();
}

class _MyOrderConfirmationPageState extends State<MyOrderConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      },

      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "My order",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.amber[900],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text(
                "payment Successfull",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 10),
              Text("Payment Id:${widget.paymentId}"),
              SizedBox(height: 10),
              Text(
                "Order summary",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.cartItem.length,
                  itemBuilder: (context, index) {
                    var item = widget.cartItem[index];
                    return ListTile(
                      title: Text(item["name"]),
                      subtitle: Text("Quantity:${item['Quantity']}"),
                      trailing: Text("₹${item['price']}"),
                    );
                  },
                ),
              ),
              Text(
                "Total:₹${widget.totalAmount}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
