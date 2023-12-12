import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shoesexe/app/data/models/data_produk.dart';
import 'package:shoesexe/app/modules/homescreen/controllers/homescreen_controller.dart';
import 'package:shoesexe/warna.dart';

import '../../../routes/app_pages.dart';

class Bagian2View extends GetView<HomescreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            child: Image.asset(
              "assets/images/background2.png",
              fit: BoxFit.cover,
            ),
          ),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: controller.dataKeranjang(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.active) {
                  List dataToko = [];
                  snap.data!.docs.forEach((e) {
                    dataToko.add(e);
                  });

                  num sub = 0;
                  dataToko.forEach((element) {
                    sub += element["total"];
                  });
                  controller.total = sub.toInt();

                  if (dataToko.length == 0) {
                    return Container(
                      height: 250,
                      width: 180,
                      child: Column(
                        children: [
                          Container(
                              child: Lottie.asset("assets/lotties/cart.json")),
                          Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: Text(
                              "Belum Ada Produk",
                              style: GoogleFonts.poppins(),
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: dataToko.length,
                      itemBuilder: (context, index) => Container(
                        padding: EdgeInsets.all(15),
                        margin:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        width: Get.width * 0.3,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(50, 128, 128, 128),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child:
                            StreamBuilder<
                                    DocumentSnapshot<Map<String, dynamic>>>(
                                stream: controller
                                    .dataT(dataToko[index]["id_toko"]),
                                builder: (context, snapshottoko) {
                                  if (snapshottoko.connectionState ==
                                      ConnectionState.active) {
                                    var dataT = snapshottoko.data?.data();
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          width: double.infinity,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${dataT?["nama"]}",
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                    color: ketiga),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Column(
                                          children: [
                                            StreamBuilder<
                                                    QuerySnapshot<
                                                        Map<String, dynamic>>>(
                                                stream: controller.produkdata(
                                                    dataToko[index]["id_toko"]),
                                                builder:
                                                    (context, snapshotproduk) {
                                                  if (snapshotproduk
                                                          .connectionState ==
                                                      ConnectionState.active) {
                                                    List dataProduk =
                                                        snapshotproduk
                                                            .data!.docs;

                                                    num harga = 0;
                                                    num beratproduk = 0;
                                                    dataProduk
                                                        .forEach((element) {
                                                      harga += element["harga"];
                                                      beratproduk +=
                                                          element["berat"];
                                                    });
                                                    int subproduk =
                                                        beratproduk.toInt();
                                                    int subtotal =
                                                        harga.toInt();
                                                    return ListView.builder(
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          dataProduk.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return StreamBuilder<
                                                            DocumentSnapshot<
                                                                Map<String,
                                                                    dynamic>>>(
                                                          stream: controller
                                                              .detailProduk(
                                                                  dataProduk[
                                                                          index]
                                                                      [
                                                                      "id_produk"]),
                                                          builder: (context,
                                                              snapshotdetail) {
                                                            if (snapshotdetail
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .active) {
                                                              ProdukData
                                                                  detail =
                                                                  ProdukData.fromJson(
                                                                      snapshotdetail
                                                                          .data!
                                                                          .data()!);

                                                              return GestureDetector(
                                                                onTap: () {
                                                                  Get.toNamed(
                                                                      Routes
                                                                          .DETAILPRODUK,
                                                                      arguments:
                                                                          detail);
                                                                },
                                                                child:
                                                                    Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          bottom:
                                                                              10,
                                                                          left:
                                                                              10,
                                                                          right:
                                                                              10),
                                                                  height:
                                                                      Get.height *
                                                                          0.16,
                                                                  child: Row(
                                                                    children: [
                                                                      // foto produk
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child:
                                                                            Container(
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Container(
                                                                              padding: EdgeInsets.all(5),
                                                                              height: Get.height * 0.12,
                                                                              width: Get.width,
                                                                              decoration: BoxDecoration(
                                                                                color: kesatu,
                                                                                borderRadius: BorderRadius.circular(20),
                                                                              ),
                                                                              child: Image.network("${detail.photoUrl}"),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      // nama produk
                                                                      Expanded(
                                                                        flex: 3,
                                                                        child:
                                                                            Container(
                                                                          padding: EdgeInsets.only(
                                                                              left: 10,
                                                                              bottom: 5,
                                                                              top: 15,
                                                                              right: 15),
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                "${detail.namaProduk}",
                                                                                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                                                                                maxLines: 2,
                                                                                overflow: TextOverflow.ellipsis,
                                                                              ),
                                                                              Text(
                                                                                "Jumlah : ${dataProduk[index]["jumlah"]}",
                                                                                style: GoogleFonts.poppins(
                                                                                  color: Colors.grey[500],
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontSize: 10,
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                "${controller.rupiah.format(detail.harga)}",
                                                                                style: GoogleFonts.poppins(
                                                                                  color: keempat,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontSize: 10,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      // checkbox barang
                                                                      Expanded(
                                                                          child:
                                                                              GestureDetector(
                                                                        onTap:
                                                                            () async {
                                                                          await controller.hapus(
                                                                              dataProduk[index]["id_produk"],
                                                                              dataProduk[index]["id_toko"],
                                                                              subtotal,
                                                                              beratproduk);

                                                                          controller
                                                                              .up();
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          child:
                                                                              Text(
                                                                            "Hapus",
                                                                            style:
                                                                                GoogleFonts.poppins(fontSize: 10),
                                                                          ),
                                                                        ),
                                                                      )),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                            return SizedBox(
                                                              height: 1,
                                                            );
                                                          },
                                                        );
                                                      },
                                                    );
                                                  }
                                                  return SizedBox(
                                                    height: 1,
                                                  );
                                                })
                                          ],
                                        ),
                                      ],
                                    );
                                  }
                                  return SizedBox(
                                    height: 1,
                                  );
                                }),
                      ),
                    );
                  }
                }
                return SizedBox(
                  height: 1,
                );
              })
        ],
      ),
      bottomNavigationBar: StreamBuilder<
              DocumentSnapshot<Map<String, dynamic>>>(
          stream: controller.totalKeranjang(),
          builder: (context, snapshotkeranjang) {
            if (snapshotkeranjang.connectionState == ConnectionState.active) {
              var totalK = snapshotkeranjang.data?.data();
              return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Container(
                    height: Get.height * 0.08,
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14),
                                      ),
                                      GetBuilder<HomescreenController>(
                                          builder: (c) {
                                        return Text(
                                          "${controller.rupiah.format(totalK?["totalkeranjang"])}",
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14),
                                        );
                                      })
                                    ],
                                  ),
                                ),
                              ),
                              StreamBuilder(
                                stream: controller.dataKeranjang(),
                                builder: (context, snapshotker) {
                                  if (snapshotker.connectionState ==
                                      ConnectionState.active) {
                                    List data = snapshotker.data!.docs;
                                    return Container(
                                      width: Get.width * 0.3,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (data.length != 0) {
                                            Get.toNamed(
                                                Routes.CHECKOUTKERANJANG,
                                                arguments: [
                                                  totalK?["totalkeranjang"],
                                                  data[0]["idKota"],
                                                  totalK?["totalberatproduk"],
                                                ]);
                                          } else {
                                            Get.snackbar("Belum ada produk",
                                                "Ayo tambahkan produk ke keranjang");
                                          }
                                        },
                                        child: Text(
                                          "Checkout",
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(100, 40),
                                          backgroundColor: ketiga,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return SizedBox(
                                    height: 1,
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
            }
            return SizedBox(
              height: 1,
            );
          }),
    );
  }
}
