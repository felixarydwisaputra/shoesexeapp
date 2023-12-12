import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesexe/app/data/models/data_produk.dart';
import 'package:shoesexe/app/modules/homescreen/controllers/homescreen_controller.dart';
import 'package:shoesexe/app/routes/app_pages.dart';
import 'package:shoesexe/warna.dart';

class ProdukTitle extends GetView<HomescreenController> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.dataProduk(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.done) {
            List<ProdukData> data = [];
            snap.data.forEach((e) {
              data.add(e);
            });
            if (data.length != 0) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: Get.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "New Catalog",
                      style: GoogleFonts.poppins(
                          fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.CATALOG, arguments: data);
                        },
                        child: Row(
                          children: [
                            Text(
                              "see more",
                              style: GoogleFonts.poppins(color: keempat),
                            ),
                            Icon(
                              Icons.arrow_right,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
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
                          style: GoogleFonts.poppins(color: Colors.grey[400]),
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
        });
  }
}
