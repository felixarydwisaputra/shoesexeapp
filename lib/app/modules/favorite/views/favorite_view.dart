import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shoesexe/app/data/models/data_produk.dart';
import 'package:shoesexe/app/modules/homescreen/controllers/homescreen_controller.dart';
import 'package:shoesexe/app/routes/app_pages.dart';

import '../../../../warna.dart';
import '../controllers/favorite_controller.dart';

class FavoriteView extends GetView<FavoriteController> {
  final homeC = Get.put(HomescreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: keempat,
              size: 30,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          backgroundColor: putih,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Your Favorite",
            style: GoogleFonts.poppins(
                color: keempat, fontWeight: FontWeight.w600, fontSize: 25),
          ),
        ),
        backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: double.infinity,
              child: Image.asset(
                "assets/images/background3.png",
                fit: BoxFit.contain,
              ),
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: controller.favorite(),
              builder: (context, snapshot) {
                List data = snapshot.data!.docs;
                var produk = snapshot.data?.docs
                    .map((e) => ProdukData.fromJson(e.data()))
                    .toList();
                if (data.length == 0) {
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
                    itemCount: data.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.DETAILPRODUK,
                            arguments: produk?[index]);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            bottom: 15, left: 50, right: 50, top: 10),
                        width: double.infinity,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 10,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: Get.height * 0.33,
                            child: Column(
                              children: [
                                Expanded(
                                    child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        child: Image.network(
                                            "${data[index]["logo_toko"]}"),
                                      ),
                                      Container(
                                        height: 40,
                                        child: Text(
                                            "${homeC.rupiah.format(data[index]["harga"])}"),
                                        alignment: Alignment.centerRight,
                                      )
                                    ],
                                  ),
                                )),
                                Expanded(
                                    flex: 7,
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            bottom: 12, top: 15),
                                        width: double.infinity,
                                        child: Center(
                                          child: Container(
                                            width: 180,
                                            child: Image.network(
                                              "${data[index]["photoUrl"]}",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ))),
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      width: double.infinity,
                                      child: Text(
                                        "${data[index]["nama_produk"]}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )),
                                Expanded(
                                    child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Size : ${data[index]["size"]}",
                                        style:
                                            GoogleFonts.poppins(fontSize: 12),
                                      ),
                                      Container(
                                        width: 40,
                                        child: Image.asset(
                                          "assets/logo/love.png",
                                          color:
                                              Color.fromARGB(255, 255, 17, 0),
                                        ),
                                        alignment: Alignment.topRight,
                                      ),
                                    ],
                                  ),
                                )),
                              ],
                            ),
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
            )
          ],
        ));
  }
}
