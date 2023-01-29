import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../warna.dart';
import '../../../routes/app_pages.dart';
import '../controllers/pesanantoko_controller.dart';

class PesanantokoView extends GetView<PesanantokoController> {
  const PesanantokoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: putih,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: keempat,
          ),
        ),
        title: Text(
          'Pesanan',
          style: GoogleFonts.poppins(
              color: keempat, fontWeight: FontWeight.w600, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Stack(alignment: Alignment.center, children: [
        Container(
          width: double.infinity,
          child: Image.asset(
            "assets/images/background1.png",
            fit: BoxFit.cover,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 180),
          height: 180,
          width: 150,
          child: Column(
            children: [
              Image.asset(
                "assets/logo/keranjang.png",
                color: Colors.grey[900],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Belum Ada Pesanan",
                  style: GoogleFonts.poppins(),
                ),
              ))
            ],
          ),
        ),
        // ListView.builder(
        //   shrinkWrap: true,
        //   physics: NeverScrollableScrollPhysics(),
        //   itemCount: 5,
        //   itemBuilder: (context, index) => Container(
        //     margin: index != 0
        //         ? EdgeInsets.only(left: 20, bottom: 5, top: 0, right: 20)
        //         : EdgeInsets.only(left: 20, bottom: 5, top: 20, right: 20),
        //     decoration: BoxDecoration(
        //       color: Colors.transparent,
        //       borderRadius: BorderRadius.circular(25),
        //     ),
        //     height: Get.height * 0.12,
        //     width: double.infinity,
        //     child: InkWell(
        //       onTap: () {},
        //       child: Card(
        //         elevation: 7,
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(25),
        //         ),
        //         child: Container(
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(25),
        //             border: Border.all(color: keempat, width: 2),
        //           ),
        //           child: Row(
        //             children: [
        //               // foto produk
        //               Expanded(
        //                   flex: 2,
        //                   child: Container(
        //                     child: Image.asset("assets/produk/1.png"),
        //                   )),
        //               //nama produk
        //               Expanded(
        //                   flex: 3,
        //                   child: Container(
        //                     padding: EdgeInsets.only(left: 10),
        //                     child: Text(
        //                       "Sepatu ke ${index + 1}",
        //                       style: GoogleFonts.poppins(
        //                           fontWeight: FontWeight.w700),
        //                     ),
        //                   )),
        //               //harga produk
        //               Expanded(
        //                   flex: 2,
        //                   child: Container(
        //                     child: Text(
        //                       "520K",
        //                       style: GoogleFonts.poppins(
        //                           fontWeight: FontWeight.w600, fontSize: 12),
        //                     ),
        //                   )),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ]),
      bottomNavigationBar: Container(
        height: 70,
        child: Text(
          "Shoes+.exe",
          style: GoogleFonts.poppins(
              color: keempat, fontWeight: FontWeight.w500, fontSize: 16),
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
