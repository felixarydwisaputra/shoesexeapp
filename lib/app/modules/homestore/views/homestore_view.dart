import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesexe/app/controllers/auth_controller.dart';
import 'package:shoesexe/app/data/models/data_produk.dart';
import 'package:shoesexe/app/data/models/toko.dart';
import 'package:shoesexe/app/modules/pesanantoko/controllers/pesanantoko_controller.dart';
import 'package:shoesexe/app/routes/app_pages.dart';
import 'package:shoesexe/warna.dart';

import '../../homescreen/controllers/homescreen_controller.dart';
import '../controllers/homestore_controller.dart';

class HomestoreView extends GetView<HomestoreController> {
  final homC = Get.put(HomestoreController());
  final authC = Get.find<AuthController>();
  final pesananC = Get.put(PesanantokoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          padding: EdgeInsets.all(10),
          child: Text(
            "Shoesexe",
            style: TextStyle(color: hitam, fontSize: 16),
          ),
        ),
        actions: [
          Row(
            children: [
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: pesananC.pesanan(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    List pesanan = snapshot.data!.docs;
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.PESANANTOKO);
                      },
                      child: pesanan.length != 0
                          ? Stack(
                              children: [
                                Image.asset("assets/logo/lonceng.png"),
                                Container(
                                  alignment: Alignment.center,
                                  width: 13,
                                  height: 13,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    "${pesanan.length}",
                                    style: GoogleFonts.poppins(fontSize: 10),
                                  ),
                                )
                              ],
                            )
                          : Stack(
                              children: [
                                Image.asset("assets/logo/lonceng.png"),
                              ],
                            ),
                    );
                  }
                  return SizedBox(
                    height: 1,
                  );
                },
              ),
              IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.TAMBAHBARANG);
                  },
                  icon: Icon(
                    Icons.add,
                    size: 30,
                    color: hitam,
                  ))
            ],
          )
        ],
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.tokoStream(authC.auth.currentUser!.email!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var dataT = snapshot.data?.data()!;
            controller.namatoko.value = dataT?["nama"];
            return ListView(children: [
              Column(
                children: [
                  Container(
                    height: Get.height * 0.4,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              dataT?["logoUrl"] != ""
                                  ? Container(
                                      height: 50,
                                      width: 50,
                                      padding: EdgeInsets.all(10),
                                      child: Image.network(
                                        "${dataT?["logoUrl"]}",
                                      ),
                                    )
                                  : Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text("logo"),
                                    ),
                              Text(
                                "${dataT?["nama"]}",
                                style: GoogleFonts.poppins(
                                    color: hitam,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.defaultDialog(
                              titlePadding: EdgeInsets.only(
                                  top: 20, right: 10, left: 10, bottom: 10),
                              title: "Upload Poster Image",
                              titleStyle: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600),
                              content: Container(
                                height: 270,
                                child: Column(
                                  children: [
                                    GetBuilder<HomestoreController>(
                                        builder: (c) => dataT?["photoUrl"] != ""
                                            ? Container(
                                                height: 170,
                                                color: Colors.grey[200],
                                                alignment: Alignment.center,
                                                child: Image.network(
                                                    "${dataT?["photoUrl"]}"),
                                              )
                                            : c.image == null
                                                ? Container(
                                                    height: 150,
                                                    color: Colors.grey[200],
                                                    alignment: Alignment.center,
                                                    child: Text("no image"),
                                                  )
                                                : Container(
                                                    height: 150,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        image: DecorationImage(
                                                          image: FileImage(
                                                            File(controller
                                                                .image!.path),
                                                          ),
                                                        )),
                                                  )),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            controller.pilihGambar();
                                          },
                                          child: Container(
                                            child: Text(
                                              "Pilih gambar",
                                              style: GoogleFonts.poppins(
                                                  color: keempat),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            if (controller.image != null) {
                                              await controller.uploadGamabr(
                                                  authC.auth.currentUser!
                                                      .email!);
                                              Get.back();
                                              Get.snackbar("Berhasil upload",
                                                  "Poster berhasil diupload");
                                            }
                                          },
                                          child: Container(
                                            child: Text(
                                              "Upload gambar",
                                              style: GoogleFonts.poppins(
                                                color: keempat,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          child: dataT?["photoUrl"] == ""
                              ? Container(
                                  height: Get.height * 0.2,
                                  color: Colors.grey[200],
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child: Text("no poster image"))
                              : Container(
                                  height: Get.height * 0.3,
                                  width: double.infinity,
                                  child: Image.network(
                                    "${dataT?["photoUrl"]}",
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "CATALOG",
                      style: GoogleFonts.poppins(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream:
                        controller.produkStream(authC.auth.currentUser!.email!),
                    builder: (context, snapshot1) {
                      if (snapshot1.connectionState == ConnectionState.active) {
                        List<DocumentSnapshot> listDocsToko = [];
                        var dataToko = snapshot1.data!.docs;
                        dataToko.forEach((element) {
                          listDocsToko.add(element);
                        });
                        if (dataToko.length == 0) {
                          return Container(
                            margin: EdgeInsets.only(top: Get.height * 0.1),
                            height: 170,
                            width: 170,
                            child: Column(
                              children: [
                                Container(
                                  height: 140,
                                  child: Image.asset(
                                    "assets/logo/nodata.png",
                                    color: Colors.grey[400],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Belum Ada Produk",
                                      style: GoogleFonts.poppins(
                                          color: Colors.grey[400]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 5,
                                    childAspectRatio: 3 / 3.5),
                            itemCount: dataToko.length,
                            itemBuilder: (context, index) {
                              return StreamBuilder<
                                  DocumentSnapshot<Map<String, dynamic>>>(
                                stream: controller
                                    .detailProduk(dataToko[index]["id_produk"]),
                                builder: (context, snapshot2) {
                                  if (snapshot2.connectionState ==
                                      ConnectionState.active) {
                                    ProdukData dataP = ProdukData.fromJson(
                                        snapshot2.data!.data()!);

                                    return Container(
                                      margin: index % 2 == 0
                                          ? EdgeInsets.only(
                                              left: 25,
                                              top: 10,
                                              right: 5,
                                              bottom: 5)
                                          : EdgeInsets.only(
                                              left: 5,
                                              top: 10,
                                              right: 25,
                                              bottom: 5),
                                      child: InkWell(
                                        onTap: () {
                                          Get.toNamed(Routes.EDITBARANG,
                                              arguments: [
                                                dataP,
                                                dataT?["alamat"]["idKota"],
                                                dataT?["alamat"]["kota"],
                                              ]);
                                        },
                                        child: Card(
                                          elevation: 10,
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 25,
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.all(2),
                                                      child: Image.network(
                                                          "${dataT?["logoUrl"]}")),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                ),
                                                Container(
                                                  height: Get.height * 0.10,
                                                  child: Container(
                                                    height: 90,
                                                    width: 120,
                                                    child: Image.network(
                                                      "${dataP.photoUrl}",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  alignment: Alignment.center,
                                                ),
                                                Container(
                                                  height: Get.height * 0.065,
                                                  child: Text(
                                                    "${dataP.namaProduk}",
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 10),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 70,
                                                          padding:
                                                              EdgeInsets.all(2),
                                                          child: Text(
                                                            "Kota ${dataT?["alamat"]["kota"]}",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        10),
                                                          ),
                                                          alignment: Alignment
                                                              .centerLeft,
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 15),
                                                            child: Text(
                                                              "${dataP.harga.toString().substring(0, 4)}K",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                      fontSize:
                                                                          10),
                                                            ),
                                                            alignment: Alignment
                                                                .centerRight,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              );
                            });
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ],
              ),
            ]);
          }
          return SizedBox(
            height: 12,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          authC.logout();
        },
        child: Icon(Icons.logout_rounded),
        backgroundColor: ketiga,
      ),
    );
  }
}
