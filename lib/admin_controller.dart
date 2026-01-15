import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/firebase_services.dart';
import 'package:get/get.dart';

class AdminController extends GetxController {
  var isLoding = false.obs;

  var productList = <QueryDocumentSnapshot>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchProduct();
  }

  void fetchProduct() {
    FirebaseFirestore.instance.collection("E_commerce").snapshots().listen((
      snapshot,
    ) {
      productList.value = snapshot.docs;
    });
  }
//add function
  Future<void> addProduct(
    String name,
    String image,
    String price,
    String description,
  ) async {
    try {
      isLoding.value = true;

      String id = FirebaseFirestore.instance.collection("E_commerce").doc().id;
      await Database.addEcommerceDetails({
        "id": id,
        "productname": name,
        "image": image,
        "price": int.parse(price),
        "description": description,
      }, id);
      Get.snackbar("Success", "product added successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoding.value = false;
    }
  }
  //get product

  Stream<QuerySnapshot> getProduct() {
    return FirebaseFirestore.instance
        .collection("E_commerce")
        .orderBy("productname")
        .snapshots();
  }
//delete function
  Future deleteEcommerce(String id) async {
    try {
      isLoding.value = true;
      await Database.deleteEcommerceDetails(id);
      Get.snackbar(
        "Deleted",
        "Product deleted successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoding.value = false;
    }
  }
}
