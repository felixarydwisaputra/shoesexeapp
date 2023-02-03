import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shoesexe/app/controllers/auth_controller.dart';

class FavoriteController extends GetxController {
  AuthController authC = Get.find<AuthController>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> favorite() async* {
    final data = await firestore
        .collection("users")
        .doc(authC.auth.currentUser!.email)
        .collection("favorites");
    yield* data.snapshots();
  }
}
