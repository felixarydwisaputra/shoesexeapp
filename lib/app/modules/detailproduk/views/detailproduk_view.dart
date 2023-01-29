import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesexe/app/data/models/toko.dart';
import 'package:shoesexe/app/modules/homescreen/controllers/homescreen_controller.dart';
import 'package:shoesexe/app/routes/app_pages.dart';
import 'package:shoesexe/warna.dart';

import '../controllers/detailproduk_controller.dart';

class DetailprodukView extends GetView<DetailprodukController> {
  final homeC = Get.put(HomescreenController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: controller.dataToko(controller.dataP.emailToko!),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.done) {
            Map<String, dynamic> dataT = snap.data!.data()!;

            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 10,
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
                actions: [
                  Obx(
                    () => Container(
                        child: GestureDetector(
                      onTap: () {
                        controller.love.toggle();
                      },
                      child: controller.love.isTrue
                          ? Image.asset(
                              "assets/logo/love.png",
                              color: Color.fromARGB(255, 255, 17, 0),
                            )
                          : Image.asset(
                              "assets/logo/favorite.png",
                              color: kedua,
                            ),
                    )),
                  ),
                ],
                title: Text(
                  'ShoesPlus',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700, fontSize: 25),
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 45, vertical: 20),
                          height: Get.height * 0.30,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image:
                                    AssetImage("assets/images/backgorud5.png"),
                                alignment: Alignment.topCenter),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "${controller.dataP.photoUrl}")
                                  // image: AssetImage("${controller.dataProduk.foto}"),
                                  ),
                            ),
                          )),
                      // nama produk & toko
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            width: double.infinity,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${controller.dataP.namaProduk}",
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
                                    "${homeC.rupiah.format(controller.dataP.harga)}",
                                    style: GoogleFonts.poppins(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // description produk
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        height: Get.height * 0.29,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Container(
                              height: 25,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "DESCRIPTION PRODUCT",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w700),
                                  ),
                                  ElevatedButton(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            padding: EdgeInsets.all(5),
                                            child: Image.network(
                                                "${dataT["logoUrl"]}")),
                                        Text(
                                          "${dataT["nama"]}",
                                          style: TextStyle(color: hitam),
                                        )
                                      ],
                                    ),
                                    onPressed: () {
                                      Get.toNamed(Routes.STORE,
                                          arguments: dataT);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: kedua),
                                  ),
                                ],
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Toko"),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("${dataT["nama"]}"),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Tali"),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("${controller.dataP.warna}"),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("${controller.dataP.bahan}"),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("${controller.dataP.stok}"),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("${controller.dataP.berat} gram"),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Kota ${dataT["alamat"]["kota"]}"),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      // size options
                      Container(
                        padding: EdgeInsets.only(
                            left: 30, right: 15, top: 5, bottom: 5),
                        height: Get.height * 0.115,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Container(
                              height: 20,
                              width: double.infinity,
                              child: Text(
                                "SIZE OPTIONS",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Expanded(
                                  child: Container(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 175,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 7,
                                        itemBuilder: (context, index) =>
                                            GestureDetector(
                                          onTap: () {
                                            controller.select.value = index;
                                            controller.size.value = index + 38;
                                            print(controller.size);
                                          },
                                          child: Obx(
                                            () => Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 2, horizontal: 2),
                                              decoration: BoxDecoration(
                                                color:
                                                    controller.select == index
                                                        ? Colors.grey[500]
                                                        : Colors.transparent,
                                                border: Border.all(
                                                    color: keempat, width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                "${index + 38}",
                                                style: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )),
                                              width: 40,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 2),
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Row(
                                            children: [
                                              // MINUS PRODUK
                                              GestureDetector(
                                                onTap: () {
                                                  controller.kurangProduk();
                                                },
                                                child: Expanded(
                                                    child: Container(
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                      left: 18,
                                                      right: 15,
                                                    ),
                                                    width: 10,
                                                    height: 3,
                                                    child: Image.asset(
                                                      "assets/logo/min.png",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                )),
                                              ),
                                              // JUMLAH PRODUK
                                              Obx(
                                                () => Expanded(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "${controller.jumlahProduk}",
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              // TAMBAH PRODUK
                                              Expanded(
                                                  child: GestureDetector(
                                                onTap: () {
                                                  controller.tambahProduk();
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 3),
                                                    width: 30,
                                                    height: 20,
                                                    child: Image.asset(
                                                      "assets/logo/add.png",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                            )
                          ],
                        ),
                      ),
                      // details produk
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        height: Get.height * 0.3,
                        width: double.infinity,
                        child: Column(children: [
                          Container(
                            height: 20,
                            width: double.infinity,
                            child: Text(
                              "DETAILS PRODUCT",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsa vel nulla voluptate porro maxime doloribus quas mollitia fuga necessitatibus quaerat eaque debitis neque ipsam, totam facilis aut facere deserunt modi quo veritatis quam dolorem vero possimus! Dolorum illum hic temporibus numquam libero itaque dolor dicta, quo ab explicabo harum vitae.",
                            style: GoogleFonts.poppins(fontSize: 12),
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
                          Get.toNamed(Routes.CHECKOUT, arguments: [
                            controller.dataP,
                            dataT,
                            controller.size,
                            controller.jumlahProduk,
                          ]);
                        },
                        child: Text(
                          "Buy now",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              fontSize: 16,
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
                        onPressed: () async {
                          Map<String, dynamic> hasil = await controller
                              .keranjang(controller.dataP.idProduk!);
                          if (hasil["error"]) {
                            Get.snackbar("Gagal", hasil["message"]);
                          } else {
                            Get.snackbar("Berhasil", hasil["message"]);
                          }
                        },
                        child: Text(
                          "Add to cart",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              fontSize: 16,
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
          return SizedBox(
            height: 1,
          );
        });
  }
}
