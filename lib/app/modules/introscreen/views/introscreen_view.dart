import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shoesexe/app/routes/app_pages.dart';
import 'package:shoesexe/warna.dart';

import '../controllers/introscreen_controller.dart';

class IntroscreenView extends GetView<IntroscreenController> {
  const IntroscreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Selamat Datang di ",
          body: "Shoes+.exe",
          image: Center(
            child: Lottie.asset("assets/lotties/sepatu.json"),
          ),
          decoration: PageDecoration(
            titlePadding: EdgeInsets.only(bottom: 26),
            bodyTextStyle: GoogleFonts.poppins(fontSize: 20),
            titleTextStyle:
                GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.w800),
          ),
        ),
        PageViewModel(
          title: "Berbelanja dengan mudah",
          body: "Belanja sepatu yang anda inginkan tanpa perlu keluar rumah. ",
          image: Container(
            width: Get.width * 0.5,
            height: Get.height * 0.4,
            child: Lottie.asset("assets/lotties/mudah.json"),
          ),
          decoration: PageDecoration(
            titlePadding: EdgeInsets.only(bottom: 26),
            titleTextStyle:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w800),
          ),
        ),
        PageViewModel(
          title: "Kualitas dan harga terbaik",
          body: "Temukan sepatu berkualitas baik, dengan harga yang lebih baik",
          image: Container(
            width: Get.width * 0.5,
            height: Get.height * 0.4,
            child: Lottie.asset("assets/lotties/price.json"),
          ),
          decoration: PageDecoration(
            titlePadding: EdgeInsets.only(bottom: 26),
            titleTextStyle:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w800),
          ),
        ),
        PageViewModel(
          title: "Daftar sekarang juga",
          body:
              "Dan jadi bagian dari kami untuk menemukan penawaran terbaik dari kami",
          image: Container(
            width: Get.width * 0.5,
            height: Get.height * 0.4,
            child: Lottie.asset("assets/lotties/daftar.json"),
          ),
          decoration: PageDecoration(
            titlePadding: EdgeInsets.only(bottom: 26),
            titleTextStyle:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          footer: ElevatedButton(
            onPressed: () {
              Get.offAllNamed(Routes.LOGIN);
            },
            child: Text(
              "Get Started",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
                minimumSize: Size(300, 40), backgroundColor: keempat),
          ),
        ),
      ],
      showSkipButton: true,
      skip: Text("Skip",
          style:
              GoogleFonts.poppins(color: keempat, fontWeight: FontWeight.w600)),
      next: Text("Next",
          style:
              GoogleFonts.poppins(color: keempat, fontWeight: FontWeight.w600)),
      done: Text(
        "",
      ),
      onDone: () {
        // On Done button pressed
      },
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: keempat,
        color: Colors.grey,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    ));
  }
}
