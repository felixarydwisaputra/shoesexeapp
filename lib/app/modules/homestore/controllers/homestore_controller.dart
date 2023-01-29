import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoesexe/app/controllers/auth_controller.dart';
import 'package:shoesexe/app/modules/detailproduk/bindings/detailproduk_binding.dart';

class HomestoreController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late String photoUrl;

  Stream<QuerySnapshot<Map<String, dynamic>>> produkStream(String email) {
    return firestore
        .collection("toko")
        .doc(email)
        .collection("produk")
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> detailProduk(
      String id_produk) async* {
    yield* firestore.collection("produk").doc(id_produk).snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> tokoStream(String email) {
    return firestore.collection("toko").doc(email).snapshots();
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

  // UPLOAD GAMBAR
  Future uploadGamabr(String email) async {
    CollectionReference toko = firestore.collection("toko");

    File file = File(image!.path);
    Reference storageRef = storage.ref("$email/poster/${email}.png");

    try {
      await storageRef.putFile(file);
      photoUrl = await storageRef.getDownloadURL();
    } catch (e) {}

    await toko.doc(email).update({
      "photoUrl": photoUrl,
    });
  }
}
