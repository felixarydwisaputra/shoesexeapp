import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shoesexe/app/data/models/toko.dart';
import 'package:shoesexe/app/modules/homescreen/controllers/homescreen_controller.dart';
import 'package:shoesexe/app/modules/homescreen/views/component/brands_view.dart';
import 'package:shoesexe/app/modules/homescreen/views/component/just_for_you_view.dart';
import 'package:shoesexe/app/modules/homescreen/views/component/product/product_view.dart';
import 'package:shoesexe/app/modules/homescreen/views/component/product/titleProduct.dart';

class Bagian1View extends GetView<HomescreenController> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              child: Image.asset(
                "assets/images/background1.png",
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                JustForYouView(),
                SizedBox(
                  height: 10,
                ),
                FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  future: controller.dataToko(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      List dataToko = snapshot.data!.docs;
                      return BrandsView(
                        dataToko: dataToko,
                      );
                    }
                  },
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        ProdukTitle(),
        ProductView(),
      ],
    );
  }
}
