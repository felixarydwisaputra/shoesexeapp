import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shoesexe/app/modules/homescreen/controllers/homescreen_controller.dart';

class Bagian3View extends GetView<HomescreenController> {
  const Bagian3View({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            //   itemCount: controller.favorite.length,
            //   itemBuilder: (context, index) => Container(
            //     margin:
            //         EdgeInsets.only(bottom: 15, left: 50, right: 50, top: 10),
            //     width: double.infinity,
            //     child: Card(
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(20),
            //       ),
            //       elevation: 10,
            //       child: Container(
            //         padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            //         decoration: BoxDecoration(
            //           color: Colors.grey[300],
            //           borderRadius: BorderRadius.circular(20),
            //         ),
            //         height: Get.height * 0.33,
            //         child: Column(
            //           children: [
            //             Expanded(
            //                 child: Container(
            //               padding: EdgeInsets.symmetric(horizontal: 20),
            //               width: double.infinity,
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   Container(
            //                     width: 40,
            //                     height: 40,
            //                     child: Image.asset("assets/logo/nike.png"),
            //                   ),
            //                   Container(
            //                     height: 40,
            //                     child: Text(
            //                         "${controller.rupiah.format(controller.favorite[index]["harga"])}"),
            //                     alignment: Alignment.centerRight,
            //                   )
            //                 ],
            //               ),
            //             )),
            //             Expanded(
            //                 flex: 5,
            //                 child: Container(
            //                     margin: EdgeInsets.only(bottom: 12),
            //                     width: double.infinity,
            //                     child: Center(
            //                       child: Container(
            //                         width: 180,
            //                         child: Image.asset(
            //                           "${controller.favorite[index]["foto"]}",
            //                           fit: BoxFit.cover,
            //                         ),
            //                       ),
            //                     ))),
            //             Expanded(
            //                 flex: 3,
            //                 child: Container(
            //                   padding: EdgeInsets.symmetric(
            //                       horizontal: 20, vertical: 5),
            //                   width: double.infinity,
            //                   child: Text(
            //                     "${controller.favorite[index]["produk"]}",
            //                     style: GoogleFonts.poppins(
            //                         fontSize: 18,
            //                         letterSpacing: 1,
            //                         fontWeight: FontWeight.w600),
            //                   ),
            //                 )),
            //             Expanded(
            //                 child: Container(
            //               padding: EdgeInsets.symmetric(horizontal: 20),
            //               width: double.infinity,
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   Text(
            //                     "Size : ${controller.favorite[index]["size"]}",
            //                     style: GoogleFonts.poppins(fontSize: 12),
            //                   ),
            //                   Container(
            //                     width: 40,
            //                     child: Image.asset(
            //                       "assets/logo/love.png",
            //                       color: Color.fromARGB(255, 255, 17, 0),
            //                     ),
            //                     alignment: Alignment.topRight,
            //                   ),
            //                 ],
            //               ),
            //             )),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ));
  }
}
