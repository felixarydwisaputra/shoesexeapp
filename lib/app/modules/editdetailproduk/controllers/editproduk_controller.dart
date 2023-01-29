import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoesexe/app/controllers/auth_controller.dart';
import 'package:shoesexe/app/data/models/data_produk.dart';

class EditprodukController extends GetxController {
  AuthController authC = Get.find<AuthController>();
  RxBool isLoading = false.obs;
  ProdukData produk = Get.arguments;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late String photoUrl;

  // texcontroller
  TextEditingController namaC = TextEditingController();
  TextEditingController warnaC = TextEditingController();
  TextEditingController descC = TextEditingController();
  TextEditingController bahanC = TextEditingController();
  TextEditingController hargaC = TextEditingController();
  TextEditingController beratC = TextEditingController();
  TextEditingController stokC = TextEditingController();

  @override
  void onInit() {
    namaC.text = produk.namaProduk!;
    warnaC.text = produk.warna!;
    descC.text = produk.deskripsi!;
    bahanC.text = produk.bahan!;
    hargaC.text = produk.harga!.toString();
    beratC.text = produk.berat!.toString();
    stokC.text = produk.stok!.toString();
    // TODO: implement onInit
    super.onInit();
  }

  Future<Map<String, dynamic>> editProduk(
      String namaC, warnaC, descC, bahanC, hargaC, beratC, stokC, idP) async {
    CollectionReference docproduk = firestore.collection("produk");

    // UPLOAD IMAGE
    File file = File(image!.path);
    Reference storageRef =
        storage.ref("${authC.auth.currentUser!.email}/produk/${idP}.png");

    try {
      await storageRef.putFile(file);
      photoUrl = await storageRef.getDownloadURL();
    } catch (e) {}
    // UPLOAD IMAGE

    try {
      await docproduk.doc(produk.idProduk).update({
        "bahan": bahanC,
        "berat": int.parse(beratC),
        "updateAt": DateTime.now().toIso8601String(),
        "deskripsi": descC,
        "harga": int.parse(hargaC),
        "nama_produk": namaC,
        "stok": int.parse(stokC),
        "photoUrl": photoUrl,
        "warna": warnaC,
      });

      return {
        "error": false,
        "message": "Produk berhasil diedit",
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Gagal mengedit produk",
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
