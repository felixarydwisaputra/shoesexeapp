import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesexe/app/controllers/auth_controller.dart';
import 'package:shoesexe/app/data/models/user_model.dart';
import 'package:shoesexe/app/modules/login/controllers/login_controller.dart';
import 'package:shoesexe/app/routes/app_pages.dart';

import 'package:shoesexe/warna.dart';

import '../controllers/homescreen_controller.dart';
import 'bagian1_view.dart';
import 'bagian2_view.dart';
import 'bagian3_view.dart';

class HomescreenView extends GetView<HomescreenController> {
  final homeC = Get.find<HomescreenController>();
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: controller.dataUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var dataUser = UserModels.fromJson(snapshot.data!.data()!);
            return Obx(
              () => Scaffold(
                backgroundColor: Colors.white,
                appBar: (controller.tabindex.value == 0)
                    ? AppBar(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        actions: [
                          Container(
                            padding: EdgeInsets.only(right: 15),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey[400],
                                  child: dataUser.photoUrl != "" &&
                                          dataUser.photoUrl != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                              "${dataUser.photoUrl}"))
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.asset(
                                            "assets/logo/user.png",
                                            color: hitam,
                                          )),
                                ),
                              ],
                            ),
                          )
                        ],
                        title: Container(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            "Shoes.exe",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                        ),
                      )
                    : AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        centerTitle: true,
                        title: Container(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            "${controller.titleAppbar()}",
                            style: GoogleFonts.poppins(
                                color: keempat,
                                fontWeight: FontWeight.w600,
                                fontSize: 25),
                          ),
                        ),
                      ),
                body: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller.tabController,
                  children: [
                    Bagian1View(),
                    Bagian2View(),
                    Bagian3View(),
                    Text(""),
                  ],
                ),
                bottomNavigationBar: Padding(
                  padding:
                      EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 13),
                  child: Container(
                    height: Get.height * 0.08,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: ketiga,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: Get.height * 0.08,
                          child: TabBar(
                            indicator: UnderlineTabIndicator(
                              insets: EdgeInsets.fromLTRB(
                                53,
                                30,
                                53,
                                43,
                              ),
                            ),
                            physics: NeverScrollableScrollPhysics(),
                            onTap: (value) {
                              controller.tabindex.value = value;
                            },
                            controller: controller.tabController,
                            tabs: [
                              Tab(
                                child: Image.asset("assets/logo/home.png"),
                              ),
                              Tab(
                                child: Image.asset("assets/logo/cart.png"),
                              ),
                              Tab(
                                child: Image.asset("assets/logo/favorite.png"),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.USER);
                                },
                                child: Container(
                                  child: Image.asset("assets/logo/user.png"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return SizedBox(
            height: 10,
          );
          ;
        });
  }
}
