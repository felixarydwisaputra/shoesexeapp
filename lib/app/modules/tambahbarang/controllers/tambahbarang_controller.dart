import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoesexe/app/controllers/auth_controller.dart';
import 'package:shoesexe/app/data/models/data_produk.dart';
import 'package:shoesexe/app/data/models/toko.dart';

class TambahbarangController extends GetxController {
  RxBool isLoading = false.obs;
  bool buatProduk = false;
  TextEditingController namaP = TextEditingController();
  TextEditingController bahan = TextEditingController();
  TextEditingController berat = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController harga = TextEditingController();
  TextEditingController stok = TextEditingController();
  TextEditingController warna = TextEditingController();

  // =======================================================
  AuthController authC = Get.find<AuthController>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var tokoM = TokoModels().obs;
  late String photoUrl;

  Future<Map<String, dynamic>> tambahBarang(
      String namaP, bahan, berat, deskripsi, harga, stok, warna) async {
    try {
      CollectionReference produk = firestore.collection("produk");
      CollectionReference toko = firestore.collection("toko");

      final docProduk = await toko
          .doc(authC.auth.currentUser!.email)
          .collection("produk")
          .get();

      final docToko = await toko.doc(authC.auth.currentUser!.email).get();

      // kondisi pertama (belum ada produk sama sekali)
      // kondisi kedua (sudah ada produk)
      // UPLOAD IMAGE

      final produkBaru = await produk.add({
        "nama_produk": namaP,
        "emailToko": docToko["email"],
        "bahan": bahan,
        "berat": int.parse(berat),
        "deskripsi": deskripsi,
        "harga": int.parse(harga),
        "stok": int.parse(stok),
        "warna": warna,
        "createdAt": DateTime.now().toIso8601String(),
        "updateAt": DateTime.now().toIso8601String(),
      });

      // UPLOAD IMAGE
      File file = File(image!.path);
      Reference storageRef = storage
          .ref("${authC.auth.currentUser!.email}/produk/${produkBaru.id}.png");

      try {
        await storageRef.putFile(file);
        photoUrl = await storageRef.getDownloadURL();
      } catch (e) {}
      // UPLOAD IMAGE

      await produk.doc(produkBaru.id).update({
        "photoUrl": photoUrl,
        "id_produk": produkBaru.id,
      });

      await toko
          .doc(authC.auth.currentUser!.email)
          .collection("produk")
          .doc(produkBaru.id)
          .set({
        "id_produk": produkBaru.id,
        "createdAt": DateTime.now().toIso8601String()
      });

      final listProduk = await toko
          .doc(authC.auth.currentUser!.email)
          .collection("produk")
          .get();

      if (listProduk.docs.length != 0) {
        List<Produk> dataListProduk = [];
        listProduk.docs.forEach((element) {
          var dataDocProduk = element.data();
          var dataDocProdukId = element.id;
          dataListProduk.add(Produk(
            idProduk: dataDocProdukId,
            createdAt: dataDocProduk["createdAt"],
          ));
        });
        tokoM.update((tokoaja) {
          tokoaja!.produk = dataListProduk;
        });
      } else {
        tokoM.update((tokoaja) {
          tokoaja!.produk = [];
        });
      }
      ;

      tokoM.refresh();

      return {
        "error": false,
        "message": "Produk berhasil ditambahkan",
      };
    } catch (e) {
      return {
        "error": true,
        "message": e,
      };
    }
  }

  // IMAGE PICKER
  late ImagePicker imagepicker = ImagePicker();
  XFile? image = null;
  FirebaseStorage storage = FirebaseStorage.instance;

  void resetImage() {
    image = null;
    update();
  }

  void pilihGambar() async {
    try {
      final dataimage =
          await imagepicker.pickImage(source: ImageSource.gallery);

      if (dataimage != null) {
        print(dataimage.name);
        print(dataimage.path);
        image = dataimage;
      }
      update();
    } catch (e) {
      print(e);
      image = null;
      update();
    }
  }
}
