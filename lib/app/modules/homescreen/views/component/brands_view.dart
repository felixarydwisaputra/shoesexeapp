import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesexe/app/data/models/toko.dart';
import 'package:shoesexe/app/modules/homescreen/controllers/homescreen_controller.dart';
import 'package:shoesexe/app/routes/app_pages.dart';
import 'package:shoesexe/warna.dart';

class BrandsView extends GetView<HomescreenController> {
  List dataToko;

  BrandsView({required this.dataToko});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.22,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            height: Get.height * 0.1,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Brands",
                  style: GoogleFonts.poppins(
                      fontSize: 25, fontWeight: FontWeight.w600),
                ),
                Container(
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.BRANDS);
                    },
                    child: Row(
                      children: [
                        Text(
                          "see more",
                          style: GoogleFonts.poppins(color: keempat),
                        ),
                        Icon(
                          Icons.arrow_right,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: EdgeInsets.only(left: 20, bottom: 0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: dataToko.length >= 6 ? 5 : dataToko.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.STORE, arguments: dataToko[index]);
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        width: dataToko.length >= 5
                            ? Get.width * 0.24
                            : Get.width * 0.47,
                        decoration: BoxDecoration(
                          border: Border.all(color: ketiga, width: 2),
                          color: Color.fromARGB(255, 239, 239, 239),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.network("${dataToko[index]["logoUrl"]}"),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
