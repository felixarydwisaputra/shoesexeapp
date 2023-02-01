import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shoesexe/app/controllers/auth_controller.dart';

class PesanantokoController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  AuthController authC = Get.find<AuthController>();
  RxBool isLoading = false.obs;

  Stream<QuerySnapshot<Map<String, dynamic>>> pesanan() async* {
    yield* firestore
        .collection("toko")
        .doc(authC.auth.currentUser!.email)
        .collection("pesanan")
        .snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> detailProduk(
      String id_produk) async {
    final data = firestore.collection("produk").doc(id_produk).get();
    return data;
  }

  Future<Map<String, dynamic>> kirimpesan(String idpesanan) async {
    try {
      await firestore
          .collection("toko")
          .doc(authC.auth.currentUser!.email)
          .collection("pesanan")
          .doc(idpesanan)
          .delete();

      return {
        "error": false,
        "message": "Produk sedang dikirim",
      };
    } catch (e) {
      return {
        "error": true,
        "message": e.toString(),
      };
    }
  }
}
