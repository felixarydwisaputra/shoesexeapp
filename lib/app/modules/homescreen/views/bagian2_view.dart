import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shoesexe/app/modules/homescreen/controllers/homescreen_controller.dart';
import 'package:shoesexe/warna.dart';

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
          // Container(
          //   height: 250,
          //   width: 180,
          //   child: Column(
          //     children: [
          //       Container(child: Lottie.asset("assets/lotties/cart.json")),
          //       Container(
          //         height: 50,
          //         alignment: Alignment.center,
          //         child: Text(
          //           "Belum Ada Produk",
          //           style: GoogleFonts.poppins(),
          //         ),
          //       )
          //     ],
          //   ),
          // )
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: controller.keranjang(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.active) {
                  print(snap.data!.docs);
                  return ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) => Container(
                      padding: EdgeInsets.all(15),
                      margin:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      width: Get.width * 0.3,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(50, 128, 128, 128),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "",
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
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: 10, left: 10, right: 10),
                                height: Get.height * 0.16,
                                child: Row(
                                  children: [
                                    // foto produk
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        child: Center(
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            height: Get.height * 0.12,
                                            width: Get.width,
                                            decoration: BoxDecoration(
                                              color: kesatu,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Image.asset(""),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // nama produk
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 10,
                                            bottom: 15,
                                            top: 15,
                                            right: 15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              "",
                                              style: GoogleFonts.poppins(
                                                color: keempat,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10,
                                              ),
                                            ),
                                            Text(
                                              "Jumlah : 1",
                                              style: GoogleFonts.poppins(
                                                color: Colors.grey[500],
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
                                        child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        child: Text(
                                          "Hapus",
                                          style:
                                              GoogleFonts.poppins(fontSize: 10),
                                        ),
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return SizedBox(
                  height: 1,
                );
              })
        ],
      ),
    );
  }
}
