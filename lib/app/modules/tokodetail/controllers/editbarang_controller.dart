import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shoesexe/app/data/models/data_produk.dart';

import '../../../controllers/auth_controller.dart';

class EditbarangController extends GetxController {
  AuthController authC = Get.find<AuthController>();
  RxBool isLoading = false.obs;
  ProdukData produk = Get.arguments[0];
  var idKota = Get.arguments[1];
  var kota = Get.arguments[2];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> hapusProduk(String id) async {
    CollectionReference produk = firestore.collection("produk");
    CollectionReference toko = firestore
        .collection("toko")
        .doc(authC.auth.currentUser!.email)
        .collection("produk");

    try {
      await produk.doc(id).delete();
      await toko.doc(id).delete();

      return {"error": false, "message": "Produk berhasil dihapus"};
    } catch (e) {
      return {
        "error": true,
        "message": "Produk gagal dihapus",
      };
    }
  }
}
