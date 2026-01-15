import 'package:e_commerce_app/admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final AdminController controller = Get.put(AdminController());
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController imageCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fashion Store",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ADMIN",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              TextField(
                controller: nameCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: "product name",
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: imageCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: "Image urls",
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: priceCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: "price",
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: descriptionCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: "description",
                ),
              ),

              SizedBox(height: 20),
              Obx(
                () => controller.isLoding.value
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          controller.addProduct(
                            nameCtrl.text.trim(),
                            imageCtrl.text.trim(),
                            priceCtrl.text.trim(),
                            descriptionCtrl.text.trim(),
                          );
                          nameCtrl.clear();
                          imageCtrl.clear();
                          priceCtrl.clear();
                          descriptionCtrl.clear();
                        },
                        child: Text("Add Product"),
                      ),
              ),
              SizedBox(height: 30),
              Divider(),
               SizedBox(height: 30),
              Expanded(
                child: StreamBuilder(
                  stream: controller.getProduct(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Text("No products founds");
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var docs = snapshot.data!.docs[index];
                        return Card(
                          child: ListTile(
                            leading: Image.network(
                              docs["image"],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(docs['productname']),
                            subtitle: Text("₹${docs['price']}"),
                            trailing: IconButton(
                              onPressed: () {
                                controller.deleteEcommerce(docs.id);
                              },
                              icon: Icon(Icons.delete),
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
        ),
      ),
    );
  }
}
