import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shoesexe/app/controllers/auth_controller.dart';

class PesanansayaController extends GetxController {
  AuthController authC = Get.find<AuthController>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> pesanan() async* {
    final data = await firestore
        .collection("users")
        .doc(authC.auth.currentUser!.email)
        .collection("transaksi")
        .orderBy("waktupesan", descending: true);
    yield* data.snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> detailproduk(
      String id_produk) async {
    var data = await firestore.collection("produk").doc(id_produk).get();
    return data;
  }
}
