import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesexe/app/controllers/auth_controller.dart';
import 'package:shoesexe/app/data/models/user_model.dart';
import 'package:shoesexe/app/modules/homescreen/controllers/homescreen_controller.dart';
import 'package:shoesexe/app/routes/app_pages.dart';
import 'package:shoesexe/warna.dart';

import '../controllers/user_controller.dart';

class UserView extends GetView<HomescreenController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    final user = Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Hallo ${authC.userM.nama?.toLowerCase()}',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 20),
        ),
      ),
    );

    final button_keranjang = Container(
      margin: const EdgeInsets.only(right: 40, left: 40),
      child: ElevatedButton(
        onPressed: () {
          Get.toNamed(Routes.KERANJANG);
        },
        child: Text('Keranjang Saya',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, fontSize: 16, color: kedua)),
        style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            backgroundColor: ketiga,
            padding: EdgeInsets.only(top: 12, bottom: 12)),
      ),
    );

    final button_favorite = Container(
      margin: const EdgeInsets.only(right: 40, left: 40),
      child: ElevatedButton(
        onPressed: () {
          Get.toNamed(Routes.FAVORITE);
        },
        child: Text('Favorite Saya',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, fontSize: 16, color: kedua)),
        style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            backgroundColor: ketiga,
            padding: EdgeInsets.only(top: 12, bottom: 12)),
      ),
    );

    final button_pesanan = Container(
      margin: const EdgeInsets.only(right: 40, left: 40),
      child: ElevatedButton(
        onPressed: () {
          Get.toNamed(Routes.PESANANSAYA);
        },
        child: Text('Pesanan Saya',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, fontSize: 16, color: kedua)),
        style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            backgroundColor: ketiga,
            padding: EdgeInsets.only(top: 12, bottom: 12)),
      ),
    );

    final button_about = Container(
      margin: const EdgeInsets.only(right: 75, left: 75),
      child: ElevatedButton(
        onPressed: () {},
        child: Text('Tentang Shoes+.exe',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700, fontSize: 10, color: ketiga)),
        style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            backgroundColor: kedua,
            padding: EdgeInsets.only(top: 12, bottom: 12)),
      ),
    );

    // final profile =

    // final body = ListView(
    //   children: <Widget>[
    //     SizedBox(
    //       height: 10,
    //     ),
    //     profile,
    //     SizedBox(
    //       height: 20,
    //     ),
    //     user,
    //     SizedBox(
    //       height: 20,
    //     ),
    //     button_keranjang,
    //     SizedBox(
    //       height: 20,
    //     ),
    //     button_favorite,
    //     SizedBox(
    //       height: 20,
    //     ),
    //     button_pesanan,
    //     SizedBox(
    //       height: 20,
    //     ),
    //     button_settting,
    //     SizedBox(
    //       height: 100,
    //     ),
    //     button_about,
    //     SizedBox(
    //       height: 20,
    //     ),
    //   ],
    // );

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(right: 20, left: 20, top: 10),
        child: Stack(
          children: <Widget>[
            Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  leading: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset(
                      "assets/logo/home.png",
                      color: ketiga,
                    ),
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        authC.logout();
                      },
                      child: GestureDetector(
                        onTap: () {
                          authC.logout();
                        },
                        child: Image.asset(
                          "assets/logo/logout.png",
                          color: ketiga,
                        ),
                      ),
                    ),
                  ],
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                ),
                body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>?>(
                    stream: controller.dataUser(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        var dataUser =
                            UserModels.fromJson(snapshot.data!.data()!);
                        return ListView(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Center(
                                child: Container(
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(80),
                                    ),
                                    child: GetBuilder<HomescreenController>(
                                      builder: (c) => dataUser.photoUrl != "" &&
                                              dataUser.photoUrl != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(80),
                                              child: Image.network(
                                                  "${dataUser.photoUrl}"))
                                          : Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Image.asset(
                                                  "assets/images/profile.png"),
                                              alignment: Alignment.center,
                                            ),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            user,
                            SizedBox(
                              height: 20,
                            ),
                            button_keranjang,
                            SizedBox(
                              height: 20,
                            ),
                            button_favorite,
                            SizedBox(
                              height: 20,
                            ),
                            button_pesanan,
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(right: 40, left: 40),
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.defaultDialog(
                                    titlePadding: EdgeInsets.only(
                                        top: 20,
                                        right: 10,
                                        left: 10,
                                        bottom: 10),
                                    title: "Upload Image",
                                    titleStyle: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600),
                                    content: Container(
                                      height: 250,
                                      child: Column(
                                        children: [
                                          GetBuilder<HomescreenController>(
                                              builder: (c) => dataUser
                                                              .photoUrl ==
                                                          "" ||
                                                      dataUser.photoUrl == null
                                                  ? c.image == null
                                                      ? Stack(
                                                          children: [
                                                            Container(
                                                              height: 150,
                                                              width: 150,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .grey[300],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            80),
                                                              ),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                "no image",
                                                                style: GoogleFonts
                                                                    .poppins(),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Stack(children: [
                                                          Container(
                                                            height: 150,
                                                            width: 150,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                            .grey[
                                                                        200],
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            80),
                                                                    image:
                                                                        DecorationImage(
                                                                      image: FileImage(File(c
                                                                          .image!
                                                                          .path)),
                                                                    )),
                                                          ),
                                                          Container(
                                                              height: 50,
                                                              width: 50,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .grey[300],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            80),
                                                              ),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Center(
                                                                child:
                                                                    IconButton(
                                                                  icon: Icon(Icons
                                                                      .delete),
                                                                  onPressed:
                                                                      () {
                                                                    controller
                                                                        .resetGambar();
                                                                  },
                                                                ),
                                                              )),
                                                        ])
                                                  : Stack(children: [
                                                      Container(
                                                        height: 150,
                                                        width: 150,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .grey[200],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            80),
                                                                image:
                                                                    DecorationImage(
                                                                  image: NetworkImage(
                                                                      "${dataUser.photoUrl}"),
                                                                )),
                                                      ),
                                                      Container(
                                                          height: 50,
                                                          width: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .grey[300],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        80),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Center(
                                                            child: IconButton(
                                                              icon: Icon(
                                                                  Icons.delete),
                                                              onPressed:
                                                                  () async {
                                                                controller
                                                                    .resetGambar();
                                                                await controller
                                                                    .hapusGambar();

                                                                Get.back();
                                                              },
                                                            ),
                                                          )),
                                                    ])),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              controller.pilihGambar();
                                            },
                                            child: Text(
                                              "Pilih gambar",
                                              style: GoogleFonts.poppins(),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              if (controller.image != null) {
                                                await controller.uploadGamabr(
                                                    authC.auth.currentUser!
                                                        .email!);
                                                Get.back();
                                                Get.snackbar("Berhasil upload",
                                                    "Gambar berhasil diupload");
                                              } else {
                                                controller.hapusGambar();
                                              }
                                            },
                                            child: Text(
                                              "Upload gambar",
                                              style: GoogleFonts.poppins(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                  controller.image = null;
                                },
                                child: Text('Settings',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: kedua)),
                                style: ElevatedButton.styleFrom(
                                    shape: StadiumBorder(),
                                    backgroundColor: ketiga,
                                    padding:
                                        EdgeInsets.only(top: 12, bottom: 12)),
                              ),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            button_about,
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        );
                      }
                      return SizedBox(
                        height: 12,
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
