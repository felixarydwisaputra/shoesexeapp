import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shoesexe/app/data/models/data_produk.dart';
import 'package:shoesexe/app/data/models/toko.dart';

class StoreController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var dataToko = Get.arguments;

// fungsi produk
  Future dataProduk(String email) async {
    var dataP = await firestore
        .collection("toko")
        .doc(email)
        .collection("produk")
        .orderBy("createdAt", descending: true)
        .get();

    return dataP.docs;
  }

// fungsi data produk
  Future detailProduk(String id_produk) async {
    final data = await firestore.collection("produk").doc(id_produk).get();
    return data.data();
  }

// satuan toko
  Future currToko(String email) async {
    final data = firestore.collection("toko").doc(email).get();
    return data;
  }
}
