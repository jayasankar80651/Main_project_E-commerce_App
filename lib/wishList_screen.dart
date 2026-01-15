import 'package:e_commerce_app/description_screen.dart';
import 'package:flutter/material.dart';
  
class WishListPage extends StatefulWidget {

  const WishListPage({super.key,});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My WishList")),
      body: wishList.isEmpty
          ? Center(child: Text("WishList is empty"))
          : ListView.builder(
            itemCount: wishList.length,
            itemBuilder: (context,index){
              final item=wishList[index];
              return Card(
                child: ListTile(
                  leading: Image.network(item['image'],width: 50,),
                  title: Text("₹${item['price']}"),
                  trailing: Row(
                    children: [
                      IconButton(onPressed: (){
                        
                        wishList.removeAt(index);
                        setState(() {
                          
                        });
                      }, icon: Icon(Icons.shopping_cart)),
                      IconButton(onPressed: (){
                        wishList.removeAt(index);
                        setState(() {
                          
                        });
                      }, icon: Icon(Icons.delete))
                    ],
                  ),

                ),
              );

          }),
    );
  }
}
