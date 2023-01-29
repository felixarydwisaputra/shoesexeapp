import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesexe/app/controllers/auth_controller.dart';
import 'package:shoesexe/app/data/models/kota_model.dart';
import 'package:shoesexe/app/data/models/provinsi_model.dart';
import 'package:shoesexe/app/modules/singup/controllers/complete_controller.dart';

import '../../../../warna.dart';
import '../../../routes/app_pages.dart';

class CompleteuserView extends GetView<CompleteController> {
  final comC = Get.put(CompleteController());
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    final comp_regist = Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Complete Profile',
          style: GoogleFonts.poppins(
              fontSize: 35, color: ketiga, fontWeight: FontWeight.w700),
        ),
      ),
    );

    final deskripsi2 = Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Please fill all the data!',
          style: GoogleFonts.poppins(
              fontSize: 16, color: ketiga, fontWeight: FontWeight.w500),
        ),
      ),
    );

    final drwn_1 = Container(
      margin: const EdgeInsets.only(right: 40, left: 40),
      child: DropdownSearch<Provinsi>(
        popupProps: PopupProps.dialog(
          showSearchBox: true,
          itemBuilder: (context, item, isSelected) => ListTile(
            title: Text("Provinsi ${item.province}"),
          ),
        ),
        asyncItems: (text) async {
          var response = await Dio().get(
            "https://api.rajaongkir.com/starter/province",
            queryParameters: {
              "key": controller.apiKey,
            },
          );

          return Provinsi.fromJsonList(response.data["rajaongkir"]["results"]);
        },
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            fillColor: Colors.grey.shade300,
            filled: true,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.grey.shade800)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.grey.shade800)),
            label: Text(
              "Choose your province",
              style: GoogleFonts.poppins(
                  fontSize: 14, color: hitam, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        onChanged: (value) {
          controller.provasal.value = value?.province ?? "";
          controller.idprovasal.value = value?.provinceId ?? "";
        },
        clearButtonProps: ClearButtonProps(isVisible: true),
      ),
    );

    final drwn_2 = Container(
      margin: const EdgeInsets.only(right: 40, left: 40),
      child: DropdownSearch<Kota>(
        popupProps: PopupProps.dialog(
          itemBuilder: (context, item, isSelected) => ListTile(
            title: Text("${item.type} ${item.cityName}"),
          ),
        ),
        asyncItems: (text) async {
          print(controller.provasal);
          var response = await Dio().get(
            "https://api.rajaongkir.com/starter/city?province=${controller.idprovasal}",
            queryParameters: {
              "key": controller.apiKey,
            },
          );

          return Kota.fromJsonList(response.data["rajaongkir"]["results"]);
        },
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            fillColor: Colors.grey.shade300,
            filled: true,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.grey.shade800)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.grey.shade800)),
            label: Text(
              "Choose your city",
              style: GoogleFonts.poppins(
                  fontSize: 14, color: hitam, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        onChanged: (value) {
          controller.idcityasal.value = value?.cityId ?? "";
          controller.cityasal.value = value?.cityName ?? "";
        },
        clearButtonProps: ClearButtonProps(isVisible: true),
      ),
    );

    final alamat = Container(
      margin: const EdgeInsets.only(right: 40, left: 40),
      child: TextFormField(
        controller: controller.alamatC,
        cursorColor: Colors.grey.shade800,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          focusColor: Colors.black,
          fillColor: Colors.grey.shade300,
          filled: true,
          label: Center(
              child: Text(
            'Enter your address',
            style: GoogleFonts.poppins(
                fontSize: 14, color: hitam, fontWeight: FontWeight.w500),
          )),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey.shade800)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey.shade800)),
          prefixIcon: Icon(
            Icons.home_outlined,
            color: ketiga,
            size: 30,
          ),
        ),
      ),
    );

    final button_regist = Container(
      margin: const EdgeInsets.only(right: 40, left: 40),
      child: ElevatedButton(
        onPressed: () async {
          if (controller.alamatC.text.isNotEmpty) {
            Map<String, dynamic> hasil = await authC.signin(
                Get.arguments?["firstN"],
                Get.arguments?["lastN"],
                Get.arguments?["phone"],
                Get.arguments?["email"],
                controller.idprovasal.value,
                controller.provasal.value,
                controller.idcityasal.value,
                controller.cityasal.value,
                controller.alamatC.text,
                Get.arguments?["pass"]);
            if (hasil["error"] == true) {
              Get.snackbar("Error", hasil["message"]);
            } else {
              Get.snackbar("Registrasi berhasil", "Silahkan melakukan login");
              Get.offAllNamed(Routes.LOGIN);
            }
          }
        },
        child: Text('Register',
            style: GoogleFonts.poppins(
                fontSize: 16, color: putih, fontWeight: FontWeight.w600)),
        style: ElevatedButton.styleFrom(
            elevation: 10,
            shape: StadiumBorder(),
            backgroundColor: ketiga,
            padding: EdgeInsets.only(top: 10, bottom: 10)),
      ),
    );

    final regist = Center(
      child: Padding(
        padding: EdgeInsets.all(0.0),
        child: Text(
          "Already have an account ? ",
          style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500),
        ),
      ),
    );

    final signin = GestureDetector(
      onTap: () {
        Get.offAllNamed(Routes.LOGIN);
      },
      child: Text(
        'Login',
        style: GoogleFonts.poppins(
            fontSize: 14, color: hitam, fontWeight: FontWeight.w600),
      ),
    );

    final body = ListView(
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        comp_regist,
        SizedBox(
          height: 10,
        ),
        deskripsi2,
        SizedBox(
          height: 60,
        ),
        drwn_1,
        SizedBox(
          height: 15,
        ),
        drwn_2,
        SizedBox(
          height: 15,
        ),
        alamat,
        SizedBox(
          height: 100,
        ),
        button_regist,
        SizedBox(
          height: 60,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [regist, signin],
        ),
        SizedBox(
          height: 60,
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: putih,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            size: 30,
            color: ketiga,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: body,
    );
  }
}
