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

  //STREAM PRODUK
  Future dataProduk() async {
    final produk = await firestore.collection("produk").get();
    return produk.docs.map((e) => ProdukData.fromJson(e.data())).toList();
  }

  // STREAM BRANDS
  Future<QuerySnapshot<Map<String, dynamic>>> dataToko() async {
    final data = await firestore.collection("toko").get();
    return data;
  }

  // STREAM KERANJANG USER
  Stream<QuerySnapshot<Map<String, dynamic>>> keranjang() async* {
    yield* firestore
        .collection("users")
        .doc(authC.auth.currentUser!.email)
        .collection("keranjang")
        .snapshots();
  }

  Future detailP(String id_produk) async {
    final data = await firestore.collection("produk").doc(id_produk).get();
    return data.data();
  }

  // DUMMY DATA PERCOBAAN

  List<Map<String, dynamic>> favorite = [
    {
      "id": 1,
      "foto": "assets/produk/4.png",
      "produk": "NIKE Air Jordan High Retro",
      "harga": 532000,
      "size": 43,
    },
    {
      "id": 2,
      "foto": "assets/produk/8.png",
      "produk": "NIKE Air Running White",
      "harga": 712000,
      "size": 45,
    },
    {
      "id": 3,
      "foto": "assets/produk/7.png",
      "produk": "NIKE Jordan Vol 1.2",
      "harga": 520000,
      "size": 41,
    },
    {
      "id": 4,
      "foto": "assets/produk/13.png",
      "produk": "ADIDAS Shoes High Running",
      "harga": 443000,
      "size": 40,
    },
  ];

  List<String> fotoLogo = [
    "assets/logo/adidasa.png",
    "assets/logo/converse.png",
    "assets/logo/lgpuma.png",
    "assets/logo/nb.png",
    "assets/logo/reebok.png",
    "assets/logo/vans.png",
    "assets/logo/nike.png",
  ];

  List<String> poster = [
    "assets/images/poster1.png",
    "assets/images/poster2.jpg",
    "assets/images/poster3.png",
  ];

  List<Map<String, dynamic>> produk = [
    {
      "produk": "",
      "foto": "assets/produk/1.png",
      "harga": 500000,
      "asal": "Jakarta",
    },
    {
      "produk": "NIKE Air Jordan Ke ",
      "foto": "assets/produk/10.png",
      "harga": 440000,
      "asal": "Denpasar",
    },
    {
      "produk": "NIKE Air Jordan Ke ",
      "foto": "assets/produk/2.png",
      "harga": 545000,
      "asal": "Denpasar",
    },
    {
      "produk": "NIKE Air Jordan Ke ",
      "foto": "assets/produk/3.png",
      "harga": 702000,
      "asal": "Depok",
    },
    {
      "produk": "NIKE Air Jordan Ke ",
      "foto": "assets/produk/4.png",
      "harga": 620000,
      "asal": "Bekasi",
    },
    {
      "produk": "NIKE Air Jordan Ke ",
      "foto": "assets/produk/5.png",
      "harga": 500000,
      "asal": "Jakarta",
    },
    {
      "produk": "NIKE Air Jordan Ke ",
      "foto": "assets/produk/6.png",
      "harga": 500000,
      "asal": "Pontianak",
    },
    {
      "produk": "NIKE Air Jordan Ke ",
      "foto": "assets/produk/7.png",
      "harga": 500000,
      "asal": "Pontianak",
    },
    {
      "produk": "NIKE Air Jordan Ke ",
      "foto": "assets/produk/8.png",
      "harga": 500000,
      "asal": "Jember",
    },
    {
      "produk": "NIKE Air Jordan Ke ",
      "foto": "assets/produk/9.png",
      "harga": 500000,
      "asal": "Jakarta",
    },
    {
      "produk": "NIKE Air Jordan Ke ",
      "foto": "assets/produk/10.png",
      "harga": 500000,
      "asal": "Jakarta",
    },
    {
      "produk": "NIKE Air Jordan Ke ",
      "foto": "assets/produk/10.png",
      "harga": 500000,
      "asal": "Denpasar",
    },
    {
      "produk": "NIKE Air Jordan Ke ",
      "foto": "assets/produk/7.png",
      "harga": 500000,
      "asal": "Garut",
    },
    {
      "produk": "NIKE Air Jordan Ke ",
      "foto": "assets/produk/13.png",
      "harga": 500000,
      "asal": "Bekasi",
    },
  ] as List<Map<String, dynamic>>;

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
}
