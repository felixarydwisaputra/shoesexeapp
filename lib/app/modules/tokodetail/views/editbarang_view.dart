import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesexe/app/modules/homescreen/controllers/homescreen_controller.dart';
import 'package:shoesexe/app/modules/homestore/controllers/homestore_controller.dart';
import 'package:shoesexe/app/routes/app_pages.dart';

import '../../../../warna.dart';
import '../../../data/models/data_produk.dart';
import '../controllers/editbarang_controller.dart';

class EditbarangView extends GetView<EditbarangController> {
  HomescreenController homeC = Get.find<HomescreenController>();
  HomestoreController storeC = Get.find<HomestoreController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: kelima,
        leading: Container(
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.keyboard_arrow_left_rounded,
              size: 30,
            ),
          ),
        ),
        title: Text(
          '${controller.produk.namaProduk}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
          ),
          Container(
              child: ListView(
            children: [
              // foto produk
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
                  height: Get.height * 0.35,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage("assets/images/backgorud5.png"),
                        alignment: Alignment.topCenter),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage("${controller.produk.photoUrl}"),
                      ),
                    ),
                  )),
              // nama produk & toko
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${controller.produk.namaProduk} ",
                            style: GoogleFonts.poppins(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 30,
                          child: Text(
                            "${homeC.rupiah.format(controller.produk.harga)}",
                            style: GoogleFonts.poppins(),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              // description produk
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                height: Get.height * 0.35,
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      height: 20,
                      width: double.infinity,
                      child: Text(
                        "DESCRIPTION PRODUCT",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Merk"),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Tipe pengikat"),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Warna"),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Bahan"),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Stok"),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Berat"),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Dikirim dari"),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${storeC.namatoko.value}"),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Tali"),
                              SizedBox(
                                height: 5,
                              ),
                              Text("${controller.produk.warna}"),
                              SizedBox(
                                height: 5,
                              ),
                              Text("${controller.produk.bahan}"),
                              SizedBox(
                                height: 5,
                              ),
                              Text("${controller.produk.stok}"),
                              SizedBox(
                                height: 5,
                              ),
                              Text("${controller.produk.berat} gram"),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Kota ${controller.kota}"),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              // size options

              // details produk
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                height: Get.height * 0.3,
                width: double.infinity,
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    height: 25,
                    width: double.infinity,
                    child: Text(
                      "DETAILS PRODUCT",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsa vel nulla voluptate porro maxime doloribus quas mollitia fuga necessitatibus quaerat eaque debitis neque ipsam, totam facilis aut facere deserunt modi quo veritatis quam dolorem vero possimus! Dolorum illum hic temporibus numquam libero itaque dolor dicta, quo ab explicabo harum vitae.",
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                  ))
                ]),
              ),
            ],
          ))
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(15),
        child: Container(
          height: Get.height * 0.07,
          child: Row(children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.EDITPRODUK, arguments: controller.produk);
                },
                child: Text(
                  "Edit produk",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      fontSize: 13,
                      color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: keempat,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 10,
                  minimumSize: Size(10, 50),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Get.dialog(Container(
                    decoration: BoxDecoration(
                        color: kelima, borderRadius: BorderRadius.circular(20)),
                    margin: EdgeInsets.symmetric(
                        vertical: Get.height * 0.2, horizontal: 30),
                    child: Container(
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: keempat, width: 2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 170,
                            width: 170,
                            child: Image.asset("assets/logo/logosepatu.png"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Text(
                              "Ingin menghapus produk ini?",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: 16, color: keempat),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(
                                  "tidak",
                                  style: GoogleFonts.poppins(
                                      fontSize: 10, color: keempat),
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: putih,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    minimumSize: Size(80, 30)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    if (controller.isLoading.isFalse) {
                                      Map<String, dynamic> hasil =
                                          await controller.hapusProduk(
                                              controller.produk.idProduk!);
                                      if (hasil["error"]) {
                                        Get.snackbar("Gagal", hasil["message"]);
                                      }
                                      Get.back();
                                      Get.back();
                                      Get.snackbar(
                                          "Berhasil", hasil["message"]);
                                    }
                                  },
                                  child: Text("iya, hapus",
                                      style: GoogleFonts.poppins(fontSize: 10)),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: keempat,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      minimumSize: Size(80, 30)))
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Shoes.exe",
                            style: GoogleFonts.poppins(
                                color: keempat, fontSize: 10),
                          )
                        ],
                      ),
                    ),
                  ));
                },
                child: Text(
                  "Delete produk",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      fontSize: 13,
                      color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ketiga,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 10,
                  minimumSize: Size(10, 50),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
