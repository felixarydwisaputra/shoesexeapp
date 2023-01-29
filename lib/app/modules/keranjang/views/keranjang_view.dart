import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shoesexe/app/modules/homescreen/controllers/homescreen_controller.dart';

import '../../../../warna.dart';
import '../controllers/keranjang_controller.dart';

class KeranjangView extends GetView<KeranjangController> {
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
          "Your Cart",
          style: GoogleFonts.poppins(
              color: keempat, fontWeight: FontWeight.w600, fontSize: 25),
        ),
      ),
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
          Container(
            height: 250,
            width: 180,
            child: Column(
              children: [
                Container(child: Lottie.asset("assets/lotties/cart.json")),
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
          )
          // ListView.builder(
          //   itemCount: homeC.keranjang.length,
          //   itemBuilder: (context, index) => Container(
          //     padding: EdgeInsets.all(15),
          //     margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          //     width: Get.width * 0.3,
          //     decoration: BoxDecoration(
          //       color: Color.fromARGB(50, 128, 128, 128),
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Container(
          //           padding: EdgeInsets.symmetric(horizontal: 5),
          //           width: double.infinity,
          //           margin: EdgeInsets.symmetric(horizontal: 10),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                 "${homeC.keranjang[index]["toko"]}",
          //                 style: GoogleFonts.poppins(
          //                     fontWeight: FontWeight.w600,
          //                     fontSize: 18,
          //                     color: ketiga),
          //               ),
          //             ],
          //           ),
          //         ),
          //         SizedBox(
          //           height: 15,
          //         ),
          //         Column(
          //           children: [
          //             for (var anak in homeC.keranjang[index]["cart"])
          //               Container(
          //                 margin:
          //                     EdgeInsets.only(bottom: 10, left: 10, right: 10),
          //                 height: Get.height * 0.16,
          //                 child: Row(
          //                   children: [
          //                     // foto produk
          //                     Expanded(
          //                       flex: 2,
          //                       child: Container(
          //                         child: Center(
          //                           child: Container(
          //                             padding: EdgeInsets.all(5),
          //                             height: Get.height * 0.12,
          //                             width: Get.width,
          //                             decoration: BoxDecoration(
          //                               color: kesatu,
          //                               borderRadius: BorderRadius.circular(20),
          //                             ),
          //                             child: Image.asset("${anak["foto"]}"),
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //                     // nama produk
          //                     Expanded(
          //                       flex: 3,
          //                       child: Container(
          //                         padding: EdgeInsets.only(
          //                             left: 10, bottom: 15, top: 15, right: 15),
          //                         child: Column(
          //                           mainAxisAlignment:
          //                               MainAxisAlignment.spaceEvenly,
          //                           crossAxisAlignment:
          //                               CrossAxisAlignment.start,
          //                           children: [
          //                             Text(
          //                               "${anak["produk"]}${index + 1}",
          //                               style: GoogleFonts.poppins(
          //                                   fontWeight: FontWeight.w600),
          //                             ),
          //                             SizedBox(
          //                               height: 5,
          //                             ),
          //                             Text(
          //                               "${homeC.rupiah.format(anak["harga"])}",
          //                               style: GoogleFonts.poppins(
          //                                 color: keempat,
          //                                 fontWeight: FontWeight.w500,
          //                                 fontSize: 12,
          //                               ),
          //                             ),
          //                             SizedBox(
          //                               height: 5,
          //                             ),
          //                             Text(
          //                               "Jumlah : 1",
          //                               style: GoogleFonts.poppins(
          //                                   color: Colors.grey[500],
          //                                   fontWeight: FontWeight.w500,
          //                                   fontSize: 12),
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                     ),
          //                     // checkbox barang
          //                     Expanded(
          //                         child: GestureDetector(
          //                       onTap: () {},
          //                       child: Container(
          //                         child: Text(
          //                           "Hapus",
          //                           style: GoogleFonts.poppins(fontSize: 12),
          //                         ),
          //                       ),
          //                     )),
          //                   ],
          //                 ),
          //               ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
          height: Get.height * 0.08,
          child: Row(
            children: [
              Container(
                width: 200,
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Rp 0,00",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  child: Text(
                    "Checkout",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ketiga,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
