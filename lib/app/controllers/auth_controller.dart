import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shoesexe/app/data/models/toko.dart';
import 'package:shoesexe/app/data/models/user_model.dart';
import 'package:shoesexe/app/routes/app_pages.dart';

class AuthController extends GetxController {
  RxBool isRemember = false.obs;
  var isSkipIntro = true.obs;
  var isAuth = false.obs;
  UserModels userM = UserModels();
  TokoModels tokoM = TokoModels();
  var tokoaja = TokoModels().obs;

  late FirebaseAuth auth;
  late UserCredential usercredential;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // MENGECEK AKTIVITAS AKUN
  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  // FUNGSI AUTOLOGIN DAN SKIP
  Future<void> pertamaBuka() async {
    CollectionReference users = firestore.collection("users");

    final datauser = await users.doc(auth.currentUser!.email).get();
    final currDataUser = datauser.data() as Map<String, dynamic>;

    userM = (UserModels.fromJson(currDataUser));
    final box = GetStorage();
    if (box.read("auth") == true) {
      isAuth.value == true;
    }

    await autoLogin().then((value) {
      isAuth.value = value;
    });

    await skipIntro().then((value) {
      isSkipIntro.value = true;
    });
  }

  Future<bool> skipIntro() async {
    final box = GetStorage();
    if (box.read("skipIntro") != null && box.read("skipIntro") == true) {
      return true;
    }
    return false;
  }

  Future<bool> autoLogin() async {
    CollectionReference users = firestore.collection("users");
    final inilogin = await _googlesignin.isSignedIn();
    if (inilogin) {
      await _googlesignin
          .signInSilently()
          .then((value) => _currentUser = value);

      final googleAuth = await _currentUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) => usercredential = value);

      final datauser = await users.doc(auth.currentUser!.email).get();
      final currDataUser = datauser.data() as Map<String, dynamic>;

      userM = (UserModels.fromJson(currDataUser));

      return true;
    }
    return false;
  }

  @override
  void onInit() {
    auth = FirebaseAuth.instance;
    // TODO: implement onInit
  }

  // FUNGSI UNTUK LOGIN DENGAN EMAIL
  Future<Map<String, dynamic>> login(String email, String pass) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );

      final box = GetStorage();
      if (isRemember.isTrue) {
        box.write("remember", {
          "email": email,
        });
      } else {
        box.remove("remember");
      }
      if (box.read("skipIntro") != null) {
        box.remove("skipIntro");
      }
      await box.write("skipIntro", true);
      isSkipIntro.value = true;
      CollectionReference users = firestore.collection("users");
      final checkuser = await users.doc(email).get();

      // cek apakah
      users.doc(email).update({
        "lastSignIn":
            auth.currentUser!.metadata.lastSignInTime!.toIso8601String(),
      });

      box.write("auth", true);
      isAuth.value = true;

      final datauser = await users.doc(email).get();
      final currDataUser = datauser.data() as Map<String, dynamic>;

      userM = (UserModels.fromJson(currDataUser));

      return {
        "error": false,
        "message": "Selamat datang di Shoesexe",
      };
    } on FirebaseAuthException catch (e) {
      return {
        "error": true,
        "message": "Email/password yang anda masukkan salah.",
      };
    } catch (e) {
      return {"error": true, "message": "tidak bisa login"};
    }
  }

  // FUNGSI MEMBUAT TOKO
  Future<Map<String, Object>> buatToko(String email) async {
    try {
      CollectionReference users = firestore.collection("users");
      final checkuser = await users.doc(email).get();
      final dataToko = checkuser.data() as Map<String, dynamic>;
      FirebaseStorage storage = FirebaseStorage.instance;

      CollectionReference toko = await firestore.collection("toko");
      final cektoko = await toko.doc(email).get();
      if (cektoko.data() == null) {
        await toko.doc(email).set({
          "uid": auth.currentUser!.uid,
          "nama": dataToko["nama"],
          "email": auth.currentUser!.email,
          "photoUrl": "",
          "logoUrl": "",
          "createdAt": DateTime.now().toIso8601String(),
          "updatedAt": DateTime.now().toIso8601String(),
          "alamat": {
            "idProv": dataToko["alamat"]["idProv"],
            "prov": dataToko["alamat"]["prov"],
            "idKota": dataToko["alamat"]["idKota"],
            "kota": dataToko["alamat"]["kota"],
            "address": dataToko["alamat"]["address"],
          }
          // nanti ada tambah produk list of mapping
        });

        await toko.doc(email).collection("produk");
      }

      final currToko = await toko.doc(email).get();
      final cureDataToko = currToko.data() as Map<String, dynamic>;

      tokoM = TokoModels.fromJson(cureDataToko);

      final listProduk = await toko.doc(email).collection("produk").get();

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
        tokoaja.update((tokoaja) {
          tokoaja!.produk = dataListProduk;
        });
      } else {
        tokoaja.update((tokoaja) {
          tokoaja!.produk = [];
        });
      }

      return {
        "error": false,
        "message": "berhasil",
      };
    } catch (e) {
      return {
        "error": true,
        "message": e,
      };
    }
  }

  // FUNGSI UNTUK REGISTRASI EMAIL DAN PASS
  Future<Map<String, dynamic>> signin(
      String firstN,
      String lastN,
      String phone,
      String email,
      String idProv,
      String prov,
      String idKota,
      String kota,
      String address,
      String pass) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      CollectionReference users = firestore.collection("users");
      await users.doc(email).set({
        "uid": auth.currentUser!.uid,
        "nama": firstN + lastN,
        "status": "",
        "phone": phone,
        "photoUrl": "",
        "email": email,
        "createdAt": DateTime.now().toIso8601String(),
        "lastSignIn":
            auth.currentUser!.metadata.lastSignInTime!.toIso8601String(),
        "updateAt": DateTime.now().toIso8601String(),
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
        "message": "Berhasil login",
      };
    } on FirebaseAuthException catch (e) {
      return {
        "error": true,
        "message": "${e.message}",
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Tidak dapat registrasi",
      };
    }
  }

  // FUNGSI UNTUK LOGIN GOOGLE
  GoogleSignIn _googlesignin = GoogleSignIn();
  GoogleSignInAccount? _currentUser;

  Future<void> loginGoogle() async {
    try {
      // mengatasi kebocoran data user sebelum login
      await _googlesignin.signOut();

      // untuk mendapatkan user dengan google
      await _googlesignin.signIn().then((value) => _currentUser = value);

      // ini untuk cek kondisi status login
      final isSignin = await _googlesignin.isSignedIn();

      if (isSignin) {
        // kondisi berhasil login
        print("Login berhasil");
        print(_currentUser);

        final googleAuth = await _currentUser!.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => usercredential = value);

        final box = GetStorage();
        if (box.read("skipIntro") != null) {
          box.remove("skipIntro");
        }
        box.write("skipIntro", true);
        print(_currentUser);

        // MEMASUKKAN AKUN KE FIRESTORE
        CollectionReference users = firestore.collection("users");

        // cek user
        final checkuser = await users.doc(_currentUser!.email).get();

        if (checkuser.data() == null) {
          await users.doc(_currentUser!.email).set({
            "uid": usercredential.user!.uid,
            "nama": _currentUser!.displayName,
            "status": "",
            "phone": usercredential.user!.phoneNumber ?? "",
            "photoUrl": _currentUser!.photoUrl ?? "",
            "email": _currentUser!.email,
            "createdAt": DateTime.now().toIso8601String(),
            "lastSignIn":
                usercredential.user!.metadata.lastSignInTime!.toIso8601String(),
            "updateAt": DateTime.now().toIso8601String(),
            "alamat": {
              "idProv": "",
              "prov": "",
              "idKota": "",
              "kota": "",
              "address": "",
            }
          });
        } else {
          await users.doc(_currentUser!.email).update({
            "photoUrl": _currentUser!.photoUrl,
            "lastSignIn":
                usercredential.user!.metadata.lastSignInTime!.toIso8601String(),
          });
        }

        final datauser = await users.doc(_currentUser!.email).get();
        final currDataUser = datauser.data() as Map<String, dynamic>;

        userM = UserModels.fromJson(currDataUser);

        isAuth.value = true;
        Get.snackbar("Login berhasil", "Selamat datang di shoesexe");
        Get.offAllNamed(Routes.HOMESCREEN);
      } else {
        // kondisi gagal login
        print("Gagal Login");
      }
    } catch (e) {
      print("gagal " + "${e}");
    }
  }

  // FUNGSI UNTUK LOGOUT
  void logout() {
    _googlesignin.signOut();
    _googlesignin.disconnect();
    auth.signOut();
    final box = GetStorage();
    box.remove("auth");
    Get.offAllNamed(Routes.LOGIN);
  }
}
