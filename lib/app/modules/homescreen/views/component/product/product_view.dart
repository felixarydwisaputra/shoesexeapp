import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:shoesexe/app/controllers/auth_controller.dart';
import 'package:shoesexe/app/data/models/data_produk.dart';
import 'package:shoesexe/app/modules/homescreen/controllers/homescreen_controller.dart';
import 'package:shoesexe/app/routes/app_pages.dart';
import 'package:shoesexe/warna.dart';

class ProductView extends GetView<HomescreenController> {
  final homeC = Get.find<HomescreenController>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.dataProduk(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<ProdukData> dataP = [];
          snap.data.forEach((e) {
            dataP.add(e);
          });
          print(dataP);

          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: dataP.length >= 5 ? 5 : dataP.length,
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.only(
                  left: 20, bottom: 0, top: index == 0 ? 15 : 5, right: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              height: Get.height * 0.12,
              width: double.infinity,
              child: InkWell(
                onTap: () {
                  Get.toNamed(Routes.DETAILPRODUK, arguments: dataP[index]);
                },
                child: Card(
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: keempat, width: 2),
                    ),
                    child: Row(
                      children: [
                        // foto produk
                        Expanded(
                            flex: 2,
                            child: Container(
                              child: Image.network("${dataP[index].photoUrl}"),
                            )),
                        //nama produk
                        Expanded(
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "${dataP[index].namaProduk}",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700),
                              ),
                            )),
                        //harga produk
                        Expanded(
                            flex: 2,
                            child: Container(
                              child: Text(
                                "${homeC.rupiah.format(dataP[index].harga)}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600, fontSize: 10),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
