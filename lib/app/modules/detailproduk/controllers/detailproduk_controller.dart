import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shoesexe/app/controllers/auth_controller.dart';
import 'package:shoesexe/app/data/models/data_produk.dart';
import 'package:shoesexe/app/data/models/toko.dart';

class DetailprodukController extends GetxController {
  AuthController authC = Get.find<AuthController>();
  ProdukData dataP = Get.arguments;
  RxInt jumlahProduk = 1.obs;
  var select = 0.obs;
  RxBool love = false.obs;
  RxInt size = 38.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void tambahProduk() {
    jumlahProduk++;
  }

  void kurangProduk() {
    if (jumlahProduk != 1) {
      jumlahProduk--;
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> dataToko(String email) async {
    var data = firestore.collection("toko").doc(email).get();
    return data;
  }

  // FUNGSI KERANJANG
  Future<Map<String, dynamic>> keranjang(String id_produk) async {
    try {
      CollectionReference users = firestore.collection("users");

      await users
          .doc(authC.auth.currentUser!.email)
          .collection("keranjang")
          .doc(id_produk)
          .set({
        "id_produk": id_produk,
        "createdAt": DateTime.now().toIso8601String()
      });

      return {
        "error": false,
        "message": "Produk berhasil ditambahkan ke keranjang",
      };
    } catch (e) {
      return {
        "error": true,
        "message": e.toString(),
      };
    }
  }
}
