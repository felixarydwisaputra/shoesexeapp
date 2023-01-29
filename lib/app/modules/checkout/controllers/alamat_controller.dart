import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoesexe/app/data/models/user_model.dart';

import '../../../controllers/auth_controller.dart';

class AlamatController extends GetxController {
  final authC = Get.find<AuthController>();
  RxBool isLoadingc = false.obs;
  // UBAH ALAMAT
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // provinsi asal
  late String idprovasal = "";
  late String provasal = "";
  // kota asal
  late String idcityasal = "";
  late String cityasal = "";
  TextEditingController phoneC = TextEditingController();
  TextEditingController alamatC = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    phoneC.text = Get.arguments[0].toString();
    idprovasal = Get.arguments[1];
    provasal = Get.arguments[2];
    idcityasal = Get.arguments[3];
    cityasal = Get.arguments[4];
    alamatC.text = Get.arguments[5];
    super.onInit();
  }

  Future<Map<String, dynamic>> ubahAlamat(
      String phone, idProv, prov, idKota, kota, address) async {
    CollectionReference users = firestore.collection("users");

    try {
      await users.doc(authC.auth.currentUser!.email).update({
        "phone": phone,
        "alamat": {
          "idProv": idProv,
          "prov": prov,
          "idKota": idKota,
          "kota": kota,
          "address": address,
        }
      });

      return {
        "error": false,
        "message": "Berhasil mengubah alamat",
      };
    } catch (e) {
      return {
        "error": true,
        "message": e,
      };
    }
  }
}
