import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shoesexe/app/controllers/auth_controller.dart';
import 'package:shoesexe/app/data/models/data_produk.dart';
import 'package:shoesexe/app/data/models/toko.dart';
import 'package:shoesexe/app/data/models/user_model.dart';

class HomescreenController extends GetxController
    with SingleGetTickerProviderMixin {
  AuthController authC = Get.find<AuthController>();
  RxInt tabindex = 0.obs;
  var photoUrl;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late TabController tabController;
  var rupiah = NumberFormat.simpleCurrency(locale: "id_ID");
  var total = 0;

  void up() {
    total = total;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    tabController = TabController(length: 4, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    // TODO: implement onClose
    super.onClose();
  }

  // PILIH GAMBAR

  late ImagePicker imagepicker = ImagePicker();
  FirebaseStorage storage = FirebaseStorage.instance;
  XFile? image = null;
  void pilihGambar() async {
    try {
      final dataimage =
          await imagepicker.pickImage(source: ImageSource.gallery);

      if (dataimage != null) {
        image = dataimage;
      }
      update();
    } catch (e) {
      print(e);
      image = null;
      update();
    }
  }

  // UPLOAD GAMBAR
  Future uploadGamabr(String email) async {
    CollectionReference users = firestore.collection("users");

    File file = File(image!.path);
    Reference storageRef = storage.ref("$email/profile/${email}.png");

    try {
      await storageRef.putFile(file);
      photoUrl = await storageRef.getDownloadURL();
    } catch (e) {
      print(e);
    }

    await users.doc(email).update({
      "photoUrl": photoUrl,
    });
  }

  void resetGambar() {
    image = null;
    update();
  }

// hapus gambar
  Future hapusGambar() async {
    CollectionReference users = firestore.collection("users");

    await users.doc(authC.auth.currentUser!.email).update({
      "photoUrl": "",
    });
  }

  // STREAM USER
  Stream<DocumentSnapshot<Map<String, dynamic>>> dataUser() async* {
    yield* firestore
        .collection("users")
        .doc(authC.auth.currentUser?.email)
        .snapshots();
  }

  // STREAM BRANDS
  Future<QuerySnapshot<Map<String, dynamic>>> dataToko() async {
    final data = await firestore.collection("toko").get();
    return data;
  }

  //STREAM PRODUK
  Future dataProduk() async {
    final produk = await firestore.collection("produk").get();
    return produk.docs.map((e) => ProdukData.fromJson(e.data())).toList();
  }

  // STREAM KERANJANG USER
  Stream<QuerySnapshot<Map<String, dynamic>>> keranjang() async* {
    yield* firestore
        .collection("users")
        .doc(authC.auth.currentUser!.email)
        .collection("keranjang")
        .orderBy("updatedAt", descending: true)
        .snapshots();
  }

  Future detailP(String id_produk) async {
    final data = await firestore.collection("produk").doc(id_produk).get();
    return await data.data();
  }

  // MENGAMBIL DATA TOKO DARI COLLECTION KERANJANG
  Stream<QuerySnapshot<Map<String, dynamic>>> dataKeranjang() async* {
    CollectionReference users = firestore.collection("users");

    final data = await users
        .doc(authC.auth.currentUser!.email)
        .collection("keranjang")
        .orderBy("updatedAt", descending: true);
    yield* await data.snapshots();
  }

  // MENGAMBIL DATA TOKO BERDASARKAN COLLECTION KERANJANG
  Stream<DocumentSnapshot<Map<String, dynamic>>> dataT(String id_toko) async* {
    final data = await firestore.collection("toko").doc(id_toko);
    yield* await data.snapshots();
  }

  // MENGAMBIL DATA PRODUK BERDASARKAN TOKO
  Stream<QuerySnapshot<Map<String, dynamic>>> produkdata(
      String id_toko) async* {
    CollectionReference users = firestore.collection("users");

    final data = await users
        .doc(authC.auth.currentUser!.email)
        .collection("keranjang")
        .doc(id_toko)
        .collection("produk")
        .orderBy("createdAt", descending: true);
    yield* await data.snapshots();
  }

  // MENGAMBIL DETAIL PRODUK DARI PRODUK
  Stream<DocumentSnapshot<Map<String, dynamic>>> detailProduk(
      String id) async* {
    final data = await firestore.collection("produk").doc(id);
    yield* await data.snapshots();
  }

  // FUNGSI HAPUS KERANJANG
  Future hapus(String id_produk, id_toko, int subtotal, beratproduk) async {
    CollectionReference users = firestore.collection("users");
    final dataPrdk = await users
        .doc(authC.auth.currentUser!.email)
        .collection("keranjang")
        .doc(id_toko)
        .collection("produk")
        .doc(id_produk)
        .get();

    ProdukData produkD = ProdukData.fromJson(dataPrdk.data()!);

    var hasil = subtotal - produkD.harga!;
    var beratsubproduk = beratproduk - produkD.berat!;

    await users
        .doc(authC.auth.currentUser!.email)
        .collection("keranjang")
        .doc(id_toko)
        .update({
      "total": hasil,
      "updatedAt": DateTime.now().toIso8601String(),
      "berat": beratsubproduk
    });

    final dataUser = await users.doc(authC.auth.currentUser!.email).get();
    var keranjang = dataUser["totalkeranjang"] - produkD.harga;
    var totberatproduk = dataUser["totalberatproduk"] - produkD.berat;
    await users.doc(authC.auth.currentUser!.email).update({
      "totalkeranjang": keranjang,
      "totalberatproduk": totberatproduk,
    });

    await users
        .doc(authC.auth.currentUser!.email)
        .collection("keranjang")
        .doc(id_toko)
        .collection("produk")
        .doc(id_produk)
        .delete();

    final data = await users
        .doc(authC.auth.currentUser!.email)
        .collection("keranjang")
        .doc(id_toko)
        .collection("produk")
        .get();

    if (data.docs.length == 0) {
      await firestore
          .collection("users")
          .doc(authC.auth.currentUser!.email)
          .collection("keranjang")
          .doc(id_toko)
          .delete();
    }
  }

  // MEMANTAU HARGA KERANJANG
  Stream<DocumentSnapshot<Map<String, dynamic>>> totalKeranjang() async* {
    yield* firestore
        .collection("users")
        .doc(authC.auth.currentUser!.email)
        .snapshots();
  }

  // DUMMY DATA PERCOBAAN
  List<String> poster = [
    "assets/images/poster1.png",
    "assets/images/poster2.jpg",
    "assets/images/poster3.png",
  ];

// DINAMIS APPBAR JUDUl
  String titleAppbar() {
    String judulAppbar = "";
    var index = tabindex.value;
    if (tabindex == 1) {
      judulAppbar = "Your Cart";
    } else if (tabindex == 2) {
      judulAppbar = "Favorites";
    }
    return judulAppbar;
  }

  // FUNGSI FAVORITES
  Stream<QuerySnapshot<Map<String, dynamic>>> favorites() async* {
    yield* firestore
        .collection("users")
        .doc(authC.auth.currentUser!.email)
        .collection("favorites")
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> detailFav(
      String id_produk) async* {
    yield* firestore.collection("produk").doc(id_produk).snapshots();
  }
}
