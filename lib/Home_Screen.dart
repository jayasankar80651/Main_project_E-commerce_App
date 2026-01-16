import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Account_screen.dart';
import 'package:e_commerce_app/cart_screen.dart';
import 'package:e_commerce_app/description_screen.dart';
import 'package:e_commerce_app/firebase_services.dart';
import 'package:e_commerce_app/wishList_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> Category = ["All", "Men", "Women", "Girls", "Kids"];
  final List<String> imageurls = [
    "assets/images/carousel2.jpeg",
    "assets/images/carousel_1.jpg",
    "assets/images/carousel3.png",
    "assets/images/carousel5.jpg",
  ];

  TextEditingController productName = TextEditingController();
  TextEditingController productimage = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  Stream<QuerySnapshot>? e_commerce;
  getload() async {
    e_commerce = await Database.getEcommerceDetails();
    setState(() {});
  }

  User? user;
  String? idToken;

  @override
  void initState() {
    super.initState();
    _loadIdToken();
    getload();
  }

  Future<void> _loadIdToken() async {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final token = await user!.getIdToken();
      setState(() {
        idToken = token;
      });
    }
  }

  //bottomnavigation
  int SelectedIndex = 0;

  void itemtapped(int index) {
    setState(() {
      SelectedIndex = index;
    });
  }

  Widget buildHometab() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: user?.photoURL != null
                    ? NetworkImage(user!.photoURL!)
                    : null,
                child: user?.photoURL == null
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  Text(
                    user?.displayName ?? "user name",
                    style: TextStyle(color: Colors.black,fontSize: 18)
                  ),
                  Text(
                    user?.email ?? "user@gmail.com",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Spacer(),
              Icon(Icons.notifications_none),
            ],
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(height: 15),
          SizedBox(
            height: 40,

            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Category.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(right: 10),
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[400],
                  ),
                  child: Text(Category[index], style: TextStyle(fontSize: 14)),
                );
              },
            ),
          ),
          SizedBox(height: 30),
          CarouselSlider(
            options: CarouselOptions(
              height: 150,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 17 / 9,
              autoPlayCurve: Curves.linear,
              autoPlayAnimationDuration: Duration(microseconds: 800),
              viewportFraction: 0.9,
            ),
            items: imageurls.map((item) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 150,
                width: double.infinity,

                child: Image.asset(item, fit: BoxFit.cover),
              );
            }).toList(),
          ),

          SizedBox(height: 20),
          Row(
            children: [Text("Popular Product", style: TextStyle(fontSize: 20))],
          ),
          SizedBox(height: 20),
          Expanded(
            child: StreamBuilder(
              stream: e_commerce,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("An error occured:${snapshot.error}"),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Text("No data available");
                }
                return GridView.builder(
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot Ds = snapshot.data!.docs[index];

                    return Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Colors.amber[200],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DescriptionPageScreen(
                                      productname: Ds['productname'],
                                      image: Ds['image'],
                                      price: Ds['price'],
                                      description: Ds['description'],
                                    ),
                                  ),
                                );
                              },
                              child: SizedBox(
                                
                                child: Container(
                                  height: 100,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage("" + Ds['image']),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "" + Ds['productname'],
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),

                            Row(
                              children: [
                                Text(
                                  "₹${Ds["price"].toString()}",
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CartPageScreen(
                                          totalAmount: 0,
                                          cartItem: [],
                                          name: Ds['productname'],
                                          image: Ds['image'],
                                          price: Ds['price'].toString(),
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.shopping_cart_checkout,
                                    size: 20,
                                    color: Colors.amber[900],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      buildHometab(),
      WishListPage(),
    
      AccountPage(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber[900],
        unselectedItemColor: Colors.grey,
        currentIndex: SelectedIndex,
        onTap: itemtapped,

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "wishList",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
      ),
      body: screens[SelectedIndex],
    );
  }
}
