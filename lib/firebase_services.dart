import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static Future addEcommerceDetails(
    Map<String, dynamic> ecommerceinfo,
    String id,
  ) async {
    return await FirebaseFirestore.instance
        .collection("E_commerce")
        .doc(id)
        .set(ecommerceinfo);
  }

  static Future<Stream<QuerySnapshot>> getEcommerceDetails() async {
    return await FirebaseFirestore.instance
        .collection("E_commerce")
        .snapshots();
  }

  static Future deleteEcommerceDetails(String id) async {
    return await FirebaseFirestore.instance
        .collection("E_commerce")
        .doc(id)
        .delete();
  }
}
