import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

import 'package:get/get.dart';
import 'package:shoesexe/app/controllers/auth_controller.dart';
import 'package:shoesexe/app/modules/homescreen/controllers/homescreen_controller.dart';
import 'package:shoesexe/app/modules/homescreen/views/homescreen_view.dart';
import 'package:shoesexe/app/modules/homestore/views/homestore_view.dart';
import 'package:shoesexe/app/modules/introscreen/views/introscreen_view.dart';
import 'package:shoesexe/app/modules/login/controllers/login_controller.dart';
import 'package:shoesexe/app/routes/app_pages.dart';

import '../../login/views/login_view.dart';
import '../controllers/splash_controller.dart';
import 'package:shoesexe/warna.dart';

class SplashView extends GetView<SplashController> {
  final homeC = Get.put(HomescreenController());
  final loginC = Get.put(LoginController());
  final authC = Get.find<AuthController>();
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ketiga,
        body: FutureBuilder(
          future: authC.pertamaBuka(),
          builder: (context, snapshot) => FutureBuilder(
            future: Future.delayed(Duration(seconds: 5)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Container(
                    height: Get.height * 0.4,
                    width: Get.width * 0.6,
                    child: Image.asset("assets/logo/logosepatu.png"),
                  ),
                );
              }
              return box.read("skipIntro") != null && authC.isSkipIntro == true
                  ? authC.isAuth.isTrue || box.read("auth") != null
                      ? authC.userM.status == "admin" &&
                              box.read("auth") != null
                          ? HomestoreView()
                          : HomescreenView()
                      : LoginView()
                  : IntroscreenView();
            },
          ),
        ));
  }
}
