import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesexe/app/modules/checkout/controllers/alamat_controller.dart';

import '../../../../warna.dart';
import '../../../data/models/kota_model.dart';
import '../../../data/models/provinsi_model.dart';
import '../controllers/checkout_controller.dart';

class AlamatView extends GetView<AlamatController> {
  AlamatController alamatC = Get.put(AlamatController());
  var apiKey = "7e29ffa20c825c9d734d5b79ced0316b";

  @override
  Widget build(BuildContext context) {
    alamatC.phoneC.text = Get.arguments[0];
    alamatC.alamatC.text = Get.arguments[5];
    final comp_regist = Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Ubah Alamat',
          style: GoogleFonts.poppins(
              fontSize: 35, color: ketiga, fontWeight: FontWeight.w700),
        ),
      ),
    );

    final deskripsi2 = Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
        child: Text(
          'pastikan alamat yang anda masukkan sudah benar',
          textAlign: TextAlign.center,
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
              "key": apiKey,
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
            label: Get.arguments[2] == ""
                ? Text(
                    "Choose your province",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: hitam,
                        fontWeight: FontWeight.w500),
                  )
                : Text(
                    "${Get.arguments[2]}",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: hitam,
                        fontWeight: FontWeight.w500),
                  ),
          ),
        ),
        onChanged: (value) {
          alamatC.provasal = value?.province ?? "";
          alamatC.idprovasal = value?.provinceId ?? "";
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
          var response = await Dio().get(
            "https://api.rajaongkir.com/starter/city?province=${controller.idprovasal}",
            queryParameters: {
              "key": apiKey,
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
            label: Get.arguments[4] == ""
                ? Text(
                    "Choose your city",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: hitam,
                        fontWeight: FontWeight.w500),
                  )
                : Text(
                    "${Get.arguments[4]}",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: hitam,
                        fontWeight: FontWeight.w500),
                  ),
          ),
        ),
        onChanged: (value) {
          alamatC.idcityasal = value?.cityId ?? "";
          alamatC.cityasal = value?.cityName ?? "";
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

    final phone = Container(
      margin: const EdgeInsets.only(right: 40, left: 40),
      child: TextFormField(
        controller: controller.phoneC,
        cursorColor: Colors.grey.shade800,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          focusColor: Colors.black,
          fillColor: Colors.grey.shade300,
          filled: true,
          label: Center(
              child: Text(
            'Enter your phone number',
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
            Icons.phone,
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
          if (controller.isLoadingc.isFalse) {
            if (alamatC.alamatC.text.isNotEmpty &&
                alamatC.phoneC.text.isNotEmpty) {
              alamatC.isLoadingc(true);
              // jalanin fungsi
              Map<String, dynamic> hasil = await alamatC.ubahAlamat(
                  alamatC.phoneC.text,
                  alamatC.idprovasal,
                  alamatC.provasal,
                  alamatC.idcityasal,
                  alamatC.cityasal,
                  alamatC.alamatC.text);
              alamatC.isLoadingc(false);
              Get.back();
              if (hasil["error"]) {
                Get.snackbar("Gagal", hasil["message"]);
              }
              Get.snackbar("Berhasil", hasil["message"]);
            } else {
              Get.snackbar("Gagal", "Data tidak boleh kosong");
            }
          }
        },
        child: Text(alamatC.isLoadingc.isTrue ? "Loading " : 'Ubah Alamat',
            style: GoogleFonts.poppins(
                fontSize: 16, color: putih, fontWeight: FontWeight.w600)),
        style: ElevatedButton.styleFrom(
            elevation: 10,
            shape: StadiumBorder(),
            backgroundColor: ketiga,
            padding: EdgeInsets.only(top: 10, bottom: 10)),
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
        phone,
        SizedBox(
          height: 15,
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
          height: 15,
        ),
        button_regist,
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
