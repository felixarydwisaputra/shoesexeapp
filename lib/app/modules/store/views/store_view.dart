import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesexe/app/data/models/data_produk.dart';
import 'package:shoesexe/app/routes/app_pages.dart';
import 'package:shoesexe/warna.dart';

import '../controllers/store_controller.dart';

class StoreView extends GetView<StoreController> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.currToko(controller.dataToko["email"]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var toko = snapshot.data;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: Container(
                child: IconButton(
                    onPressed: () {
                      Get.offAllNamed(Routes.HOMESCREEN);
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_left_rounded,
                      size: 30,
                      color: hitam,
                    )),
              ),
              actions: [
                Image.asset(
                  "assets/logo/home.png",
                  color: Colors.black,
                ),
              ],
            ),
            body: ListView(children: [
              Column(
                children: [
                  Container(
                    height: Get.height * 0.32,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Image.network(
                                    "${controller.dataToko["logoUrl"]}"),
                              ),
                              Text(
                                "${controller.dataToko["nama"]}",
                                style: GoogleFonts.poppins(
                                    color: hitam,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                            child: Container(
                          width: double.infinity,
                          child: Image.network(
                            "${controller.dataToko["photoUrl"]}",
                            fit: BoxFit.fitWidth,
                          ),
                        ))
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "NEW CATALOG",
                      style: GoogleFonts.poppins(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                  FutureBuilder(
                    future: controller.dataProduk(toko["email"]),
                    builder: (context, snapshot1) {
                      if (snapshot1.connectionState == ConnectionState.done) {
                        List listToko = [];
                        var dataToko = snapshot1.data;
                        dataToko.forEach((e) {
                          listToko.add(e);
                        });
                        if (listToko.length != 0) {
                          return GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 5,
                                      childAspectRatio: 3 / 3.5),
                              itemCount: listToko.length,
                              itemBuilder: (context, index) {
                                return FutureBuilder(
                                  future: controller.detailProduk(
                                      listToko[index]["id_produk"]),
                                  builder: (context, snapshot2) {
                                    if (snapshot2.connectionState ==
                                        ConnectionState.done) {
                                      ProdukData dataP =
                                          ProdukData.fromJson(snapshot2.data);

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
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.toNamed(Routes.DETAILPRODUK,
                                                arguments: dataP);
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
                                                            "${controller.dataToko["logoUrl"]}")),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                  ),
                                                  Container(
                                                    height: Get.height * 0.12,
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
                                                    height: Get.height * 0.05,
                                                    child: Text(
                                                      "${dataP.namaProduk}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
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
                                                                EdgeInsets.all(
                                                                    2),
                                                            child: Text(
                                                              "Kota ${toko?["alamat"]["kota"]}",
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
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          15),
                                                              child: Text(
                                                                  "${dataP.harga.toString().substring(0, 3)}K"),
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
                                    return Container(
                                      margin: EdgeInsets.only(
                                          top: Get.height * 0.1),
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
                                  },
                                );
                              });
                        } else {
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
                      }
                      return SizedBox(
                        height: 1,
                      );
                    },
                  )
                ],
              ),
            ]),
          );
        }
        return SizedBox(
          height: 1,
        );
      },
    );
  }
}
