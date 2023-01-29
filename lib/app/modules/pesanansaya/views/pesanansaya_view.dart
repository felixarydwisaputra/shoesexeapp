import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesexe/warna.dart';

import '../controllers/pesanansaya_controller.dart';

class PesanansayaView extends GetView<PesanansayaController> {
  const PesanansayaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Container(
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.keyboard_arrow_left_rounded,
                size: 30,
                color: keempat,
              ),
            ),
          ),
          title: Text(
            'Pesanan Saya',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, fontSize: 18, color: keempat),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              child: Image.asset(
                "assets/images/background7.png",
                fit: BoxFit.cover,
              ),
            ),
            ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                width: Get.width * 0.3,
                height: 240,
                decoration: BoxDecoration(
                  color: Color.fromARGB(70, 128, 128, 128),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 30,
                      width: double.infinity,
                      child: Text(
                        "Nike Store",
                        style: GoogleFonts.poppins(
                            color: ketiga,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                color: kesatu,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Image.asset("assets/produk/6.png"),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              width: 160,
                              child: Column(
                                children: [
                                  Container(
                                    height: 50,
                                    child: Text(
                                      "NIKE Air Jordan Low Vol 1.4",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 30,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Rp 582.000,00",
                                            style: GoogleFonts.poppins(
                                              color: ketiga,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Container(
                                              child: Text("1 pcs",
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ))),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                    Container(
                      alignment: Alignment.bottomRight,
                      height: 40,
                      width: double.infinity,
                      child: Container(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Terima pesanan",
                              style: GoogleFonts.poppins(
                                  fontSize: 12, fontWeight: FontWeight.w600)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ketiga,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
