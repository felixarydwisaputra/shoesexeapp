import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shoesexe/app/controllers/auth_controller.dart';

import '../../../data/models/data_produk.dart';

class CheckoutController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxBool isloading = false.obs;
  RxBool enableBank = false.obs;
  RxString kurir = "".obs;
  var id_produk = Get.arguments[0];
  var dataToko = Get.arguments[1];
  var sizeProduk = Get.arguments[2];
  var jumlahProduk = Get.arguments[3];
  ProdukData dataP = Get.arguments[4];
  int subproduk = Get.arguments[5];
  late Map<String, dynamic> dataU;

  Map<String, dynamic> listTransaksi = {};

  // CHECKOUT
  RxInt totalongkir = 0.obs;
  RxInt biayapenanganan = 0.obs;
  RxInt total = 0.obs;
  RxString etd = "".obs;

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

    final data = await users.doc(email).collection("belanja");
    return data.get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> dataProduk(
      String email, id_toko) async {
    CollectionReference users = firestore.collection("users");

    final data = await users
        .doc(email)
        .collection("belanja")
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

  // FUNGSI TRANSAKSI TUNGGAL
  Future transaksi() async {
    int id = 234920948 + Random().nextInt(234920949);

    try {
      await firestore
          .collection("users")
          .doc(dataU["email"])
          .collection("transaksi")
          .doc("${id}")
          .set({
        "waktupesan": DateTime.now().toIso8601String(),
        "id_produk": listTransaksi["id_produk"],
        "nama_produk": listTransaksi["nama_produk"],
        "emailtoko": listTransaksi["emailtoko"],
        "nama_toko": listTransaksi["nama_toko"],
        "berat": listTransaksi["berat"],
        "harga": listTransaksi["harga"],
        "jumlah": listTransaksi["jumlah"],
        "size": listTransaksi["size"],
      });

      await firestore
          .collection("users")
          .doc(dataU["email"])
          .collection("belanja")
          .doc(listTransaksi["emailtoko"])
          .collection("produk")
          .doc(id_produk)
          .delete();

      await firestore
          .collection("users")
          .doc(dataU["email"])
          .collection("belanja")
          .doc(listTransaksi["emailtoko"])
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }

  // FUNGSI PESANAN
  Future<Map<String, dynamic>> pesanan() async {
    CollectionReference users = firestore.collection("users");
    var est = etd.value.replaceAll("HARI", "");
    try {
      int id = 982734281 + Random().nextInt(982734282);
      var doc = await firestore
          .collection("users")
          .doc(dataU["email"])
          .collection("pesanan")
          .doc("${id}")
          .set({
        "waktupesan": DateTime.now().toIso8601String(),
        "id_produk": listTransaksi["id_produk"],
        "id_pemesanan": id,
        "nama_produk": listTransaksi["nama_produk"],
        "emailtoko": listTransaksi["emailtoko"],
        "nama_toko": listTransaksi["nama_toko"],
        "berat": listTransaksi["berat"],
        "harga": listTransaksi["harga"],
        "jumlah": listTransaksi["jumlah"],
        "size": listTransaksi["size"],
        "etd": est,
      });

      return {"error": false, "message": "Berhasil"};
    } catch (e) {
      print(e);
      return {
        "error": true,
        "message": e.toString(),
      };
    }
  }

  // FUNGSI PESANANTOKO
  Future<Map<String, dynamic>> pesanantoko() async {
    CollectionReference toko = firestore.collection("toko");
    int id = 812398 + Random().nextInt(812399);

    try {
      await toko
          .doc(listTransaksi["emailtoko"])
          .collection("pesanan")
          .doc("${id}")
          .set({
        "waktupesan": DateTime.now().toIso8601String(),
        "id_pemesanan": id.toString(),
        "id_produk": listTransaksi["id_produk"],
        "nama_produk": listTransaksi["nama_produk"],
        "pemesan": listTransaksi["pemesan"],
        "alamat": listTransaksi["alamat"],
        "berat": listTransaksi["berat"],
        "harga": listTransaksi["harga"],
        "jumlah": listTransaksi["jumlah"],
        "size": listTransaksi["size"],
      });

      return {"error": false, "message": "Berhasil"};
    } catch (e) {
      print(e);
      return {
        "error": true,
        "message": e.toString(),
      };
    }
  }

  // TOTAL ONGKIR
  void totalOngkir(
    String asalKota,
    String kotatujuan,
    String berat,
    String kurir,
  ) async {
    try {
      final response = await http
          .post(Uri.parse("https://api.rajaongkir.com/starter/cost"), headers: {
        "key": "7e29ffa20c825c9d734d5b79ced0316b"
      }, body: {
        "origin": asalKota,
        "destination": kotatujuan,
        "weight": berat,
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
