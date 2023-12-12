import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesexe/app/controllers/auth_controller.dart';
import 'package:shoesexe/app/routes/app_pages.dart';
import 'package:shoesexe/warna.dart';

import '../controllers/singup_controller.dart';

class SingupView extends GetView<SingupController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    final signup_label = Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Sign Up',
            style: GoogleFonts.poppins(
                fontSize: 35, color: ketiga, fontWeight: FontWeight.w700)),
      ),
    );

    final deskripsi = Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Please fill all the data!',
          style: GoogleFonts.poppins(
              fontSize: 16, color: ketiga, fontWeight: FontWeight.w500),
        ),
      ),
    );

    final first_name = Expanded(
      child: TextFormField(
        controller: controller.firstN,
        cursorColor: Colors.grey.shade800,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          focusColor: Colors.black,
          fillColor: Colors.grey.shade300,
          filled: true,
          label: Center(
              child: Text(
            'First name',
            style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500),
          )),
          contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.grey.shade800)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.grey.shade800)),
        ),
      ),
    );

    final last_name = Expanded(
      child: TextFormField(
        controller: controller.lastN,
        cursorColor: Colors.grey.shade800,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          focusColor: Colors.black,
          fillColor: Colors.grey.shade300,
          filled: true,
          label: Center(
              child: Text(
            'Last name',
            style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500),
          )),
          contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.grey.shade800)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.grey.shade800)),
        ),
      ),
    );
    final phone_number = Container(
      margin: const EdgeInsets.only(right: 40, left: 40),
      child: TextFormField(
        controller: controller.phoneC,
        cursorColor: Colors.grey.shade800,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          focusColor: Colors.black,
          fillColor: Colors.grey.shade300,
          filled: true,
          label: Center(
              child: Text(
            'Enter Your Phone Number',
            style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500),
          )),
          contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey.shade800)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey.shade800)),
          prefixIcon: Icon(
            Icons.phone,
            color: ketiga,
          ),
        ),
      ),
    );

    final email = Container(
      margin: const EdgeInsets.only(right: 40, left: 40),
      child: TextFormField(
        controller: controller.emailC,
        cursorColor: Colors.grey.shade800,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          focusColor: Colors.black,
          fillColor: Colors.grey.shade300,
          filled: true,
          label: Center(
              child: Text(
            'Enter Your Email',
            style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500),
          )),
          contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey.shade800)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey.shade800)),
          prefixIcon: Icon(
            Icons.mail_sharp,
            color: ketiga,
          ),
        ),
      ),
    );

    final pass = Container(
      margin: const EdgeInsets.only(right: 40, left: 40),
      child: Obx(
        () => TextFormField(
          controller: controller.passC,
          cursorColor: Colors.grey.shade800,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            fillColor: Colors.grey.shade300,
            filled: true,
            label: Center(
                child: Text(
              'Enter Your Password',
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500),
            )),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.grey.shade800)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.grey.shade800)),
            prefixIcon: Icon(
              Icons.vpn_key_rounded,
              color: ketiga,
            ),
          ),
          obscureText: controller.seepass.value,
        ),
      ),
    );

    final button_continue = Container(
      margin: const EdgeInsets.only(right: 40, left: 40),
      child: ElevatedButton(
        onPressed: () {
          if (controller.firstN.text.isNotEmpty &&
              controller.lastN.text.isNotEmpty &&
              controller.phoneC.text.isNotEmpty &&
              controller.emailC.text.isNotEmpty &&
              controller.passC.text.isNotEmpty) {
            Get.toNamed(Routes.COMPLETEUSER, arguments: {
              "firstN": controller.firstN.text,
              "lastN": controller.lastN.text,
              "phone": controller.phoneC.text,
              "email": controller.emailC.text,
              "pass": controller.passC.text,
            });
          } else {
            Get.snackbar(
                "Data tidak boleh kosong", "Lengkapilah data terlebih dahulu");
          }
        },
        child: Text(
          'Continue',
          style: GoogleFonts.poppins(
              fontSize: 16, color: putih, fontWeight: FontWeight.w500),
        ),
        style: ElevatedButton.styleFrom(
            elevation: 5,
            shape: StadiumBorder(),
            backgroundColor: ketiga,
            padding: EdgeInsets.only(top: 10, bottom: 10)),
      ),
    );

    final regist = Text(
      "Already have an account ? ",
      style: GoogleFonts.poppins(
          fontSize: 12, color: Colors.grey[700], fontWeight: FontWeight.w500),
    );

    final signin = GestureDetector(
      onTap: () {
        Get.offAllNamed(Routes.LOGIN);
      },
      child: Text(
        'Login',
        style: GoogleFonts.poppins(
            fontSize: 14, color: hitam, fontWeight: FontWeight.w500),
      ),
    );

    final body = ListView(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        signup_label,
        SizedBox(
          height: 30,
        ),
        deskripsi,
        SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.only(right: 40, left: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              first_name,
              SizedBox(
                width: 15,
              ),
              last_name
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        phone_number,
        SizedBox(
          height: 20,
        ),
        email,
        SizedBox(
          height: 20,
        ),
        pass,
        SizedBox(
          height: 60,
        ),
        button_continue,
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [regist, signin],
        ),
        SizedBox(
          height: 40,
        )
      ],
    );

    return Scaffold(
      body: body,
    );
  }
}
