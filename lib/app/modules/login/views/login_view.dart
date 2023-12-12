import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesexe/app/controllers/auth_controller.dart';
import 'package:shoesexe/app/modules/homescreen/views/homescreen_view.dart';
import 'package:shoesexe/app/routes/app_pages.dart';

import '../../../../warna.dart';
import '../../homescreen/controllers/homescreen_controller.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final authC = Get.find<AuthController>();
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    if (box.read("remember") != null) {
      controller.emailC.text = box.read("remember")["email"];
    }
    final login = Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Login',
            style: GoogleFonts.poppins(
                color: ketiga, fontSize: 35, fontWeight: FontWeight.w700)),
      ),
    );

    final deskripsi = Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Please login here!',
          style: GoogleFonts.poppins(
              color: ketiga, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );

    final email = Container(
      margin: const EdgeInsets.only(right: 40, left: 40),
      child: TextFormField(
        validator: (val) => val!.isEmpty ? 'Enter Email' : null,
        controller: controller.emailC,
        cursorColor: Colors.grey.shade800,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          focusColor: Colors.black,
          fillColor: Colors.grey.shade300,
          filled: true,
          label: Text(
            'Enter Your Email',
            textAlign: TextAlign.start,
            style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500),
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
          validator: (val) => val!.isEmpty ? 'Enter Pass' : null,
          controller: controller.passC,
          cursorColor: Colors.grey.shade800,
          keyboardType: TextInputType.visiblePassword,
          obscureText: controller.seepass.value,
          decoration: InputDecoration(
            fillColor: Colors.grey.shade300,
            filled: true,
            label: Text(
              'Enter Your Pass',
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500),
            ),
            suffixIcon: Container(
              height: 10,
              width: 10,
              margin: EdgeInsets.only(right: 10),
              child: InkWell(
                child: Image.asset(controller.seepass.isTrue
                    ? "assets/logo/eyeclose.png"
                    : "assets/logo/eye.png"),
                onTap: () {
                  controller.seepass.toggle();
                },
              ),
            ),
            contentPadding:
                EdgeInsets.only(left: 40.0, top: 10.0, bottom: 10.0),
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
        ),
      ),
    );

    final checkbox = Container(
      padding: EdgeInsets.only(left: 20),
      child: Obx(
        () => CheckboxListTile(
          value: authC.isRemember.value,
          onChanged: (value) {
            authC.isRemember.toggle();
          },
          title: Text(
            "Remember me",
            style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500),
          ),
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ),
    );

    final button_G = ElevatedButton(
      onPressed: () {
        authC.loginGoogle();
      },
      child: Row(
        children: [
          Text(
            "+ with Google",
            style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            width: 5,
          ),
          Image.asset("assets/logo/google.png")
        ],
      ),
      style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          elevation: 5,
          backgroundColor: Colors.white,
          padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10)),
    );

    final button_L = ElevatedButton(
      onPressed: () async {
        print(authC.userM.nama);
        if (controller.emailC.text.isNotEmpty &&
            controller.passC.text.isNotEmpty) {
          Map<String, dynamic> hasil =
              await authC.login(controller.emailC.text, controller.passC.text);
          if (hasil["error"] == true) {
            Get.snackbar("Login gagal", hasil["message"]);
          } else {
            if (authC.userM.status == "admin") {
              await authC.buatToko(controller.emailC.text);
              Get.snackbar("Login berhasil", hasil["message"]);
              Get.offAllNamed(Routes.HOMESTORE);
            } else {
              Get.snackbar("Login berhasil", hasil["message"]);
              Get.offAllNamed(Routes.HOMESCREEN);
            }
          }
        }
      },
      child: Text(
        'Login',
        style: GoogleFonts.poppins(
            fontSize: 14, color: putih, fontWeight: FontWeight.w500),
      ),
      style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          elevation: 5,
          backgroundColor: ketiga,
          padding: EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10)),
    );

    final regist = Center(
      child: Padding(
        padding: EdgeInsets.all(0.0),
        child: Text(
          "Don't have an account ? ",
          style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500),
        ),
      ),
    );

    final signup = GestureDetector(
      onTap: () {
        Get.toNamed(Routes.SINGUP);
      },
      child: Text(
        'Sign up',
        style: GoogleFonts.poppins(
            fontSize: 14, color: hitam, fontWeight: FontWeight.w500),
      ),
    );

    final body = ListView(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        login,
        SizedBox(
          height: 10,
        ),
        deskripsi,
        SizedBox(
          height: 30,
        ),
        email,
        SizedBox(
          height: 20,
        ),
        pass,
        SizedBox(
          height: 20,
        ),
        checkbox,
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            button_G,
            SizedBox(
              width: 15,
            ),
            button_L
          ],
        ),
        SizedBox(
          height: 70,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [regist, signup],
        )
      ],
    );

    return Scaffold(
      body: body,
    );
  }
}
