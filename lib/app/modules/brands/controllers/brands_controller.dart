import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BrandsController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // fungsi memanggil brands
  Future<QuerySnapshot<Map<String, dynamic>>> brands() async {
    var toko = await firestore.collection("toko").get();
    return toko;
  }
}
