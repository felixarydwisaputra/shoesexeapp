import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shoesexe/app/controllers/auth_controller.dart';

import '../../../data/models/data_produk.dart';

class CheckoutkeranjangController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxBool isloading = false.obs;
  RxBool enableBank = false.obs;
  RxString kurir = "".obs;
  List<Map<String, dynamic>> listproduk = [];

  var subproduk = Get.arguments[0];
  var idKota = Get.arguments[1];
  var totalberatproduk = Get.arguments[2].toString();

  late Map<String, dynamic> dataU;

  // CHECKOUT
  RxInt totalongkir = 0.obs;
  RxInt biayapenanganan = 0.obs;
  RxInt total = 0.obs;
  RxString etd = "".obs;

// FUNGSI CHECKOUT
  Future<Map<String, dynamic>> transaksi() async {
    CollectionReference users = firestore.collection("users");
    final batch = firestore.batch();

    try {
      for (var i = 0; i < listproduk.length; i++) {
        batch.set(
            users
                .doc(dataU["email"])
                .collection("transaksi")
                .doc("${DateTime.now().toIso8601String()}"),
            {
              "waktupesan": DateTime.now().toIso8601String(),
              "id_produk": listproduk[i]["id"],
              "nama_produk": listproduk[i]["nama"],
              "emailtoko": listproduk[i]["emailtoko"],
              "nama_toko": listproduk[i]["namatoko"],
              "berat": listproduk[i]["berat"],
              "harga": listproduk[i]["harga"],
              "jumlah": listproduk[i]["jumlah"],
              "size": listproduk[i]["size"],
            });
      }
      await batch.commit();

      return {"error": false, "message": "Berhasil"};
    } catch (e) {
      print(e);
      return {
        "error": true,
        "message": e.toString(),
      };
    }
  }

  //FUNGSI PESANAN TOKO
  Future<Map<String, dynamic>> pesanantoko() async {
    CollectionReference toko = firestore.collection("toko");
    final batch = firestore.batch();
    int id = 812398 + Random().nextInt(812399);

    try {
      for (var i = 0; i < listproduk.length; i++) {
        batch.set(
            toko
                .doc("${listproduk[i]["emailtoko"]}")
                .collection("pesanan")
                .doc("${id}"),
            {
              "waktupesan": DateTime.now().toIso8601String(),
              "id_pemesanan": id.toString(),
              "id_produk": listproduk[i]["id"],
              "nama_produk": listproduk[i]["nama"],
              "pemesan": listproduk[i]["pemesan"],
              "alamat": listproduk[i]["alamat"],
              "berat": listproduk[i]["berat"],
              "harga": listproduk[i]["harga"],
              "jumlah": listproduk[i]["jumlah"],
              "size": listproduk[i]["size"],
            });
        final jum =
            firestore.collection("produk").doc("${listproduk[i]["id"]}").get();
        print(jum.then((value) {
          firestore.collection("produk").doc("${listproduk[i]["id"]}").update(
              {"stok": value.data()?["stok"] - listproduk[i]["jumlah"]});
        }));
      }
      await batch.commit();

      return {"error": false, "message": "Berhasil"};
    } catch (e) {
      print(e);
      return {
        "error": true,
        "message": e.toString(),
      };
    }
  }

  Future hapus(String id_produk, id_toko) async {
    CollectionReference users = firestore.collection("users");

    await users
        .doc(dataU["email"])
        .collection("belanja")
        .doc(id_toko)
        .collection("produk")
        .doc(id_produk)
        .delete();

    await users.doc(dataU["email"]).collection("belanja").doc(id_toko).delete();
  }

  // mengambil data produk dari keranjang
  Future<QuerySnapshot<Map<String, dynamic>>> dataBelanja(String email) async {
    CollectionReference users = firestore.collection("users");

    final data = await users.doc(email).collection("keranjang");
    return data.get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> dataProduk(
      String email, id_toko) async {
    CollectionReference users = firestore.collection("users");

    final data = await users
        .doc(email)
        .collection("keranjang")
        .doc(id_toko)
        .collection("produk");
    return data.get();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> detailProduk(
      String id) async* {
    final data = await firestore.collection("produk").doc(id);
    yield* data.snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> dataUser(String email) async* {
    yield* firestore.collection("users").doc(email).snapshots();
  }

  // UBAH ALAMAT
  TextEditingController phoneC = TextEditingController();
  TextEditingController alamatC = TextEditingController();

  // TOTAL ONGKIR
  void totalOngkir(
    String kotatujuan,
    String kurir,
  ) async {
    try {
      final response = await http
          .post(Uri.parse("https://api.rajaongkir.com/starter/cost"), headers: {
        "key": "7e29ffa20c825c9d734d5b79ced0316b"
      }, body: {
        "origin": idKota,
        "destination": kotatujuan,
        "weight": totalberatproduk,
        "courier": kurir,
      });

      var data = json.decode(response.body) as Map<String, dynamic>;
      var hasil = data["rajaongkir"]["results"];
      totalongkir.value = hasil[0]["costs"][0]["cost"][0]["value"];
      etd.value = hasil[0]["costs"][0]["cost"][0]["etd"];
      total.value = subproduk + totalongkir.value + biayapenanganan.value;
    } catch (e) {
      Get.snackbar("Terjadi keslahan", e.toString());
    }
  }

  // TOTAL CHECKOUT
  void totalCheckout() {
    total.value = subproduk + totalongkir.value + biayapenanganan.value;
  }
}
