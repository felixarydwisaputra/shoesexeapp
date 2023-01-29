import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/models/data_produk.dart';

class CatalogController extends GetxController {
  List<ProdukData> dataP = Get.arguments;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> dataToko1(String email) async {
    var data = firestore.collection("toko").doc(email).get();
    return data;
  }
}
