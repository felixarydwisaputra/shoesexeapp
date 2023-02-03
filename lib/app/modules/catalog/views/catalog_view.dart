import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesexe/app/modules/homescreen/controllers/homescreen_controller.dart';
import 'package:shoesexe/app/routes/app_pages.dart';
import 'package:shoesexe/warna.dart';

import '../controllers/catalog_controller.dart';

class CatalogView extends GetView<CatalogController> {
  final homeC = Get.find<HomescreenController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Container(
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: keempat,
                size: 30,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Our Catalog',
            style: GoogleFonts.poppins(
              color: keempat,
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              child: Image.asset(
                "assets/images/background4.png",
                fit: BoxFit.cover,
              ),
            ),
            controller.dataP.length <= 5
                ? ListView.builder(
                    itemCount: controller.dataP.length,
                    itemBuilder: (context, index) => FutureBuilder<
                            DocumentSnapshot<Map<String, dynamic>>>(
                        future: controller
                            .dataToko1(controller.dataP[index].emailToko!),
                        builder: (context, snap) {
                          var dataT = snap.data?.data();
                          return Container(
                            height: Get.height * 0.3,
                            width: 200,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(
                                  Routes.DETAILPRODUK,
                                  arguments: controller.dataP[index],
                                );
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                elevation: 10,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                      color: keempat,
                                      width: 3,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: Get.height * 0.2,
                                        // UNTUK LOGO FOTO NAMA
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 15, top: 10),
                                              height: 30,
                                              width: double.infinity,
                                              child: Image.network(
                                                  "${dataT?["logoUrl"]}"),
                                              alignment: Alignment.centerLeft,
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                              ),
                                              height: 120,
                                              width: double.infinity,
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 50),
                                                height: 100,
                                                child: Image.network(
                                                  "${controller.dataP[index].photoUrl}",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // UNTUK ASAL DAN HARGA
                                      Expanded(
                                          child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: Get.width * 0.5,
                                              child: Text(
                                                "${controller.dataP[index].namaProduk}",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w700),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "${homeC.rupiah.format(controller.dataP[index].harga)}",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 10,
                      childAspectRatio: 3 / 3.4,
                    ),
                    itemCount: controller.dataP.length,
                    itemBuilder: (context, index) {
                      return FutureBuilder<
                              DocumentSnapshot<Map<String, dynamic>>>(
                          future: controller
                              .dataToko1(controller.dataP[index].emailToko!),
                          builder: (context, snap) {
                            var dataT = snap.data?.data();
                            return Container(
                              margin: (index % 2 == 0)
                                  ? EdgeInsets.only(left: 20)
                                  : EdgeInsets.only(right: 20),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(
                                    Routes.DETAILPRODUK,
                                    arguments: controller.dataP[index],
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  elevation: 10,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                        color: keempat,
                                        width: 3,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: Get.height * 0.2,
                                          // UNTUK LOGO FOTO NAMA
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: 15, top: 10),
                                                height: 30,
                                                width: double.infinity,
                                                child: Image.network(
                                                    "${dataT?["logoUrl"]}"),
                                                alignment: Alignment.centerLeft,
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: 0,
                                                    left: 10,
                                                    right: 10),
                                                height: 90,
                                                width: double.infinity,
                                                child: Image.network(
                                                  "${controller.dataP[index].photoUrl}",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Expanded(
                                                  child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                height: 90,
                                                width: double.infinity,
                                                child: Text(
                                                  "${controller.dataP[index].namaProduk}",
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ))
                                            ],
                                          ),
                                        ),
                                        // UNTUK ASAL DAN HARGA
                                        Expanded(
                                            child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Kota ${dataT?["alamat"]["kota"]}",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 11),
                                              ),
                                              Text(
                                                "${controller.dataP[index].harga.toString().substring(0, 3)}K",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )
                                            ],
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    }),
          ],
        ));
  }
}
