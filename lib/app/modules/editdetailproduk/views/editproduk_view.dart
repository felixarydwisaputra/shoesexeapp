import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../warna.dart';
import '../controllers/editproduk_controller.dart';

class EditprodukView extends GetView<EditprodukController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: putih,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.keyboard_arrow_left_outlined,
                size: 30,
                color: keempat,
              )),
          title: Text(
            'Edit Produk',
            style: GoogleFonts.poppins(
                color: keempat, fontWeight: FontWeight.w600, fontSize: 25),
          ),
          backgroundColor: putih,
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              child: Image.asset(
                "assets/images/background7.png",
                fit: BoxFit.fitWidth,
              ),
            ),
            ListView(
              children: [
                SizedBox(
                  height: 5,
                ),
                GetBuilder<EditprodukController>(
                  builder: (c) => c.image == null
                      ? Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 65, vertical: 15),
                          height: Get.height * 0.2,
                          child: Container(
                            child:
                                Image.network("${controller.produk.photoUrl}"),
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 65, vertical: 15),
                          height: Get.height * 0.2,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: FileImage(
                                File("${c.image!.path}"),
                              ),
                            )),
                          ),
                        ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                  height: Get.height * 0.66,
                  child: Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 10,
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: controller.namaC,
                            cursorColor: hitam,
                            decoration: InputDecoration(
                                hintText: "Nama produk",
                                hintStyle: GoogleFonts.poppins(
                                    color: keempat,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                                contentPadding: EdgeInsets.only(
                                    top: 10, bottom: 5, left: 15, right: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                )),
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 10,
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: controller.warnaC,
                            cursorColor: hitam,
                            decoration: InputDecoration(
                                hintText: "Warna produk",
                                hintStyle: GoogleFonts.poppins(
                                    color: keempat,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                                contentPadding: EdgeInsets.only(
                                    top: 10, bottom: 5, left: 15, right: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                )),
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 10,
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: controller.descC,
                            cursorColor: hitam,
                            decoration: InputDecoration(
                                hintText: "Deskripsi produk",
                                hintStyle: GoogleFonts.poppins(
                                    color: keempat,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                                contentPadding: EdgeInsets.only(
                                    top: 10, bottom: 5, left: 15, right: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                )),
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 10,
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: controller.bahanC,
                            cursorColor: hitam,
                            decoration: InputDecoration(
                                hintText: "Bahan produk",
                                hintStyle: GoogleFonts.poppins(
                                    color: keempat,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                                contentPadding: EdgeInsets.only(
                                    top: 10, bottom: 5, left: 15, right: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                )),
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 10,
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: controller.hargaC,
                            keyboardType: TextInputType.number,
                            cursorColor: hitam,
                            decoration: InputDecoration(
                                hintText: "Harga produk",
                                hintStyle: GoogleFonts.poppins(
                                    color: keempat,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                                contentPadding: EdgeInsets.only(
                                    top: 10, bottom: 5, left: 15, right: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                )),
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 10,
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: controller.beratC,
                            cursorColor: hitam,
                            decoration: InputDecoration(
                                hintText: "Berat produk",
                                hintStyle: GoogleFonts.poppins(
                                    color: keempat,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                                contentPadding: EdgeInsets.only(
                                    top: 10, bottom: 5, left: 15, right: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                )),
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 10,
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: controller.stokC,
                            cursorColor: hitam,
                            decoration: InputDecoration(
                                hintText: "Stok produk",
                                hintStyle: GoogleFonts.poppins(
                                    color: keempat,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                                contentPadding: EdgeInsets.only(
                                    top: 10, bottom: 5, left: 15, right: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          GetBuilder<EditprodukController>(
                            builder: (c) => c.image == null
                                ? Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "image_picker1216368666071444463.jpg",
                                        style: GoogleFonts.poppins(fontSize: 8),
                                      ),
                                      width: 200,
                                      height: 40,
                                    ),
                                  )
                                : Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${controller.image!.name}",
                                        style: GoogleFonts.poppins(fontSize: 8),
                                      ),
                                      width: 200,
                                      height: 40,
                                    ),
                                  ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              width: 200,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.pilihGambar();
                                },
                                child: Text(
                                  "FILE",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600),
                                ),
                                style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  backgroundColor: kelima,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 40,
                        child: Obx(
                          () => ElevatedButton(
                            child: Text(
                              controller.isLoading.isTrue
                                  ? "Loading"
                                  : "Edit produk",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600),
                            ),
                            onPressed: () async {
                              if (controller.isLoading.isFalse) {
                                if (controller.namaC.text.isNotEmpty &&
                                    controller.warnaC.text.isNotEmpty &&
                                    controller.descC.text.isNotEmpty &&
                                    controller.bahanC.text.isNotEmpty &&
                                    controller.hargaC.text.isNotEmpty &&
                                    controller.beratC.text.isNotEmpty &&
                                    controller.stokC.text.isNotEmpty) {
                                  controller.isLoading(true);
                                  // jalankan fungsi edit
                                  Map<String, dynamic> hasil =
                                      await controller.editProduk(
                                          controller.namaC.text,
                                          controller.warnaC.text,
                                          controller.descC.text,
                                          controller.bahanC.text,
                                          controller.hargaC.text,
                                          controller.beratC.text,
                                          controller.stokC.text,
                                          controller.produk.idProduk);
                                  controller.isLoading(false);
                                  if (hasil["error"]) {
                                    Get.snackbar(
                                        "Terjadi kesalahan", hasil["message"]);
                                  }
                                  Get.back();
                                  Get.back();
                                  Get.snackbar(
                                      "Edit berhasil", hasil["message"]);
                                  ;
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              backgroundColor: kelima,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              minimumSize: Size(200, 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    "Shoes+.exe",
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
