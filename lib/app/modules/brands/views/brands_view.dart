import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesexe/app/modules/homescreen/controllers/homescreen_controller.dart';
import 'package:shoesexe/app/routes/app_pages.dart';
import '../controllers/brands_controller.dart';

import 'package:shoesexe/warna.dart';

class BrandsView extends GetView<BrandsController> {
  final HomescreenController brandC = Get.put(HomescreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 249, 249, 249),
          elevation: 0,
          leading: Container(
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.keyboard_arrow_left,
                  size: 30,
                  color: keempat,
                )),
          ),
          title: Text(
            'Popular Brands',
            style: GoogleFonts.poppins(
                color: keempat, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              child: Image.asset(
                "assets/images/background3.png",
                fit: BoxFit.cover,
              ),
            ),
            FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                future: controller.brands(),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.done) {
                    List dataT = snap.data!.docs;

                    return ListView.builder(
                      itemCount: dataT.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.STORE, arguments: dataT[index]);
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: 10, left: 20, right: 20, top: 5),
                          width: double.infinity,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 10,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              decoration: BoxDecoration(
                                color: (index % 2 == 0) ? kesatu : kedua,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: keempat, width: 3),
                              ),
                              height: Get.height * 0.4,
                              child: Center(
                                child: Container(
                                  height: Get.height * 0.25,
                                  width: Get.width * 0.5,
                                  child: Image.network(
                                      "${dataT[index]["logoUrl"]}"),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return SizedBox(
                      height: 1,
                    );
                  }
                }),
          ],
        ));
  }
}
