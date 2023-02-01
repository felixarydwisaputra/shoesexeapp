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

  int subproduk(int harga, int jumlahProduk) {
    var sub = harga * jumlahProduk;
    return sub;
  }

  // FUNGSI KERANJANG
  Future<Map<String, dynamic>> keranjang(
      String id_produk, id_toko, idKota, toko, int jumlah, ukuran, berat) async {
    int total = 0;
    try {
      CollectionReference users = firestore.collection("users");

      await users
          .doc(authC.auth.currentUser!.email)
          .collection("keranjang")
          .doc(id_toko)
          .set({
        "updatedAt": DateTime.now().toIso8601String(),
        "id_toko": id_toko,
        "idKota": idKota,
        "toko" : toko
      });
      var total = dataP.harga! * jumlah;
      await users
          .doc(authC.auth.currentUser!.email)
          .collection("keranjang")
          .doc(id_toko)
          .collection("produk")
          .doc(id_produk)
          .set({
        "id_produk": id_produk,
        "createdAt": DateTime.now().toIso8601String(),
        "id_toko": id_toko,
        "jumlah": jumlah,
        "size": ukuran,
        "harga": total,
        "berat": berat * jumlah
      });
      var data = await users
          .doc(authC.auth.currentUser!.email)
          .collection("keranjang")
          .doc(id_toko)
          .collection("produk")
          .get();

      num hasil = 0;
      num beratproduk = 0;
      data.docs.forEach((element) {
        hasil += element["harga"];
        beratproduk += element["berat"];
      });

      await users
          .doc(authC.auth.currentUser!.email)
          .collection("keranjang")
          .doc(id_toko)
          .update({
        "total": hasil,
        "berat": beratproduk,
      });

      var totalprice = await users
          .doc(authC.auth.currentUser!.email)
          .collection("keranjang")
          .get();

      num price = 0;
      num weight = 0;
      totalprice.docs.forEach((element) {
        price += element["total"];
        weight += element["berat"];
      });

      await users.doc(authC.auth.currentUser!.email).update({
        "totalkeranjang": price,
        "totalberatproduk": weight,
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

  Future<Map<String, dynamic>> belanja(
      String id_produk, id_toko, int jumlah, ukuran) async {
    try {
      CollectionReference users = firestore.collection("users");

      await users
          .doc(authC.auth.currentUser!.email)
          .collection("belanja")
          .doc(id_toko)
          .set({
        "createdAt": DateTime.now().toIso8601String(),
        "id_toko": id_toko,
      });

      await users
          .doc(authC.auth.currentUser!.email)
          .collection("belanja")
          .doc(id_toko)
          .collection("produk")
          .doc(id_produk)
          .set({
        "id_produk": id_produk,
        "createdAt": DateTime.now().toIso8601String(),
        "id_toko": id_toko,
        "jumlah": jumlah,
        "size": ukuran,
        "harga": dataP.harga
      });

      return {
        "error": false,
        "message": "Produk sedang diproses",
      };
    } catch (e) {
      return {
        "error": true,
        "message": e.toString(),
      };
    }
  }
}
