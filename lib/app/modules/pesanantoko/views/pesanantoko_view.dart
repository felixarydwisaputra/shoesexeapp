import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesexe/app/data/models/data_produk.dart';
import 'package:shoesexe/app/modules/homescreen/controllers/homescreen_controller.dart';

import '../../../../warna.dart';
import '../../../routes/app_pages.dart';
import '../controllers/pesanantoko_controller.dart';

class PesanantokoView extends GetView<PesanantokoController> {
  HomescreenController homeC = Get.put(HomescreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: putih,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: keempat,
          ),
        ),
        title: Text(
          'Pesanan',
          style: GoogleFonts.poppins(
              color: keempat, fontWeight: FontWeight.w600, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Stack(children: [
        Container(
          width: double.infinity,
          child: Image.asset(
            "assets/images/background1.png",
            fit: BoxFit.cover,
          ),
        ),
        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.pesanan(),
          builder: (context, snapshotpesanan) {
            if (snapshotpesanan.connectionState == ConnectionState.active) {
              List pesanan = snapshotpesanan.data!.docs;
              if (pesanan.length == 0) {
                return Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 80),
                    height: 150,
                    width: 150,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/logo/keranjang.png",
                          color: Colors.grey[900],
                          height: 100,
                          width: 100,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Expanded(
                            child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Belum Ada Pesanan",
                            style: GoogleFonts.poppins(),
                          ),
                        ))
                      ],
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: pesanan.length,
                    itemBuilder: (context, index) =>
                        FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                          future: controller
                              .detailProduk(pesanan[index]["id_produk"]),
                          builder: (context, snapshotdetail) {
                            if (snapshotdetail.connectionState ==
                                ConnectionState.done) {
                              ProdukData produk = ProdukData.fromJson(
                                  snapshotdetail.data!.data()!);
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                height: Get.height * 0.22,
                                width: double.infinity,
                                child: InkWell(
                                  onTap: () {
                                    Get.defaultDialog(
                                        title: "Pesanan",
                                        titleStyle: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                        content: Container(
                                          height: Get.height * 0.6,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 0),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 25),
                                          decoration: BoxDecoration(
                                              color: putih,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: Get.height * 0.2,
                                                width: double.infinity,
                                                child: Image.network(
                                                  "${produk.photoUrl}",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Container(
                                                height: Get.height * 0.1,
                                                child: Text(
                                                  "${produk.namaProduk} asbdasbdjasdbhjbjhbj",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Container(
                                                height: Get.height * 0.2,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                        child: Container(
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Nama",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                      fontSize:
                                                                          10),
                                                            ),
                                                            Text("Alamat",
                                                                style: GoogleFonts
                                                                    .poppins(
                                                                        fontSize:
                                                                            10)),
                                                            Text("Jumlah",
                                                                style: GoogleFonts
                                                                    .poppins(
                                                                        fontSize:
                                                                            10)),
                                                            Text("Size",
                                                                style: GoogleFonts
                                                                    .poppins(
                                                                        fontSize:
                                                                            10)),
                                                            Text("Harga",
                                                                style: GoogleFonts
                                                                    .poppins(
                                                                        fontSize:
                                                                            10)),
                                                          ]),
                                                    )),
                                                    Expanded(
                                                        child: Container(
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                                "${pesanan[index]["pemesan"]}",
                                                                style: GoogleFonts
                                                                    .poppins(
                                                                        fontSize:
                                                                            10)),
                                                            Text(
                                                                "${pesanan[index]["alamat"]}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GoogleFonts
                                                                    .poppins(
                                                                        fontSize:
                                                                            10)),
                                                            Text(
                                                                "${pesanan[index]["jumlah"]}",
                                                                style: GoogleFonts
                                                                    .poppins(
                                                                        fontSize:
                                                                            10)),
                                                            Text(
                                                                "${pesanan[index]["size"]}",
                                                                style: GoogleFonts
                                                                    .poppins(
                                                                        fontSize:
                                                                            10)),
                                                            Text(
                                                                "${homeC.rupiah.format(pesanan[index]["harga"])}",
                                                                style: GoogleFonts
                                                                    .poppins(
                                                                        fontSize:
                                                                            10)),
                                                          ]),
                                                    )),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                height: Get.height * 0.1,
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    if (controller
                                                        .isLoading.isFalse) {
                                                      controller
                                                          .isLoading(true);
                                                      await Future.delayed(
                                                          Duration(seconds: 3));
                                                      Get.back();
                                                      Get.back();
                                                      Map<String, dynamic>
                                                          hasil =
                                                          await controller
                                                              .kirimpesan(pesanan[
                                                                      index][
                                                                  "id_pemesanan"]);

                                                      controller
                                                          .isLoading(false);
                                                      if (hasil["error"]) {
                                                        Get.back();
                                                      } else {
                                                        Get.snackbar("Berhasil",
                                                            hasil["message"]);
                                                      }
                                                    }
                                                  },
                                                  child: Obx(
                                                    () => Text(
                                                      controller
                                                              .isLoading.isTrue
                                                          ? "Loading"
                                                          : "Kirim pesanan",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                  ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: ketiga,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ));
                                  },
                                  child: Card(
                                    elevation: 7,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(
                                            color: keempat, width: 2),
                                      ),
                                      child: Row(
                                        children: [
                                          // foto produk
                                          Expanded(
                                              flex: 2,
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(left: 20),
                                                child: Image.network(
                                                    "${produk.photoUrl}"),
                                              )),
                                          //nama produk
                                          Expanded(
                                              flex: 3,
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${produk.namaProduk}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text(
                                                      "${homeC.rupiah.format(produk.harga)}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ],
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return SizedBox(
                              height: 1,
                            );
                          },
                        ));
              }
            }
            return SizedBox(
              height: 1,
            );
          },
        )
      ]),
      bottomNavigationBar: Container(
        height: 70,
        child: Text(
          "Shoes+.exe",
          style: GoogleFonts.poppins(
              color: keempat, fontWeight: FontWeight.w500, fontSize: 16),
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
