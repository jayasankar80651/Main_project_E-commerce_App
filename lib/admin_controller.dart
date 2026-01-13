import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/firebase_services.dart';
import 'package:get/get.dart';

class AdminController extends GetxController {
  var isLoding = false.obs;
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
        "id":id,
        "productname": name,
        "image": image,
        "price": int.parse(price),
        "description": description,
      },
      id,
      );
      Get.snackbar("Success", "product added successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoding.value = false;
    }
  }

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
