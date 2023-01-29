import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesexe/app/controllers/auth_controller.dart';
import 'package:shoesexe/app/data/models/data_produk.dart';
import 'package:shoesexe/warna.dart';

import '../controllers/tambahbarang_controller.dart';

class TambahbarangView extends GetView<TambahbarangController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: putih,
        appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.keyboard_arrow_left_outlined,
              size: 30,
              color: keempat,
            ),
          ),
          title: Text(
            'Tambah Produk',
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 65, vertical: 5),
                  height: Get.height * 0.235,
                  child: GetBuilder<TambahbarangController>(
                    builder: (c) => c.image != null
                        ? Column(
                            children: [
                              Container(
                                height: 120,
                                width: 200,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image:
                                      FileImage(File(controller.image!.path)),
                                  fit: BoxFit.cover,
                                )),
                              ),
                              TextButton(
                                  onPressed: () {
                                    controller.resetImage();
                                  },
                                  child: Text("Hapus image"))
                            ],
                          )
                        : Container(
                            height: 200,
                            width: 250,
                            color: Colors.grey[300],
                            child: Center(
                              child: Text(
                                "no produk image",
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                            // Image.asset("assets/produk/6.png")
                          ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 45, vertical: 5),
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
                            controller: controller.namaP,
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
                            controller: controller.warna,
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
                            controller: controller.desc,
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
                            controller: controller.bahan,
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
                            controller: controller.harga,
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
                            controller: controller.berat,
                            cursorColor: hitam,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                suffix: Text("gram",
                                    style: TextStyle(color: Colors.grey[400])),
                                hintText: "Berat produk (gram)",
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
                            controller: controller.stok,
                            keyboardType: TextInputType.number,
                            cursorColor: hitam,
                            decoration: InputDecoration(
                                suffix: Text(
                                  "pcs",
                                  style: TextStyle(color: Colors.grey[400]),
                                ),
                                hintText: "Stok produk (pcs)",
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
                          Card(
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
                              child: GetBuilder<TambahbarangController>(
                                builder: (c) => c.image != null
                                    ? Text(
                                        "${c.image!.name}",
                                        style: GoogleFonts.poppins(fontSize: 8),
                                      )
                                    : Text(
                                        "no image",
                                        style:
                                            GoogleFonts.poppins(fontSize: 12),
                                      ),
                              ),
                              width: 200,
                              height: 40,
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
                                  : "Tambah produk",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600),
                            ),
                            onPressed: () async {
                              if (controller.isLoading.isFalse) {
                                if (controller.image == null) {
                                  Get.snackbar("Gambar produk",
                                      "Gambar produk harus diisi");
                                }
                                if (controller.namaP.text.isNotEmpty &&
                                    controller.bahan.text.isNotEmpty &&
                                    controller.berat.text.isNotEmpty &&
                                    controller.desc.text.isNotEmpty &&
                                    controller.harga.text.isNotEmpty &&
                                    controller.stok.text.isNotEmpty &&
                                    controller.warna.text.isNotEmpty) {
                                  controller.isLoading(true);
                                  // jalankan fungsi
                                  Map<String, dynamic> hasil =
                                      await controller.tambahBarang(
                                    controller.namaP.text,
                                    controller.bahan.text,
                                    controller.berat.text,
                                    controller.desc.text,
                                    controller.harga.text,
                                    controller.stok.text,
                                    controller.warna.text,
                                  );
                                  controller.isLoading(false);

                                  if (hasil["error"]) {
                                    Get.snackbar("Gagal menambah barang",
                                        hasil["message"]);
                                  } else {
                                    Get.back();
                                    Get.snackbar("Berhasil menambah produk",
                                        hasil["message"]);
                                  }
                                } else {
                                  Get.snackbar("Gagal menambah barang",
                                      "Data tidak boleh kosong");
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
