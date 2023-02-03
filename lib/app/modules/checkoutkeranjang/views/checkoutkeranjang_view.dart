import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../warna.dart';
import '../../../controllers/auth_controller.dart';
import '../../../data/models/data_produk.dart';
import '../../../routes/app_pages.dart';
import '../../homescreen/controllers/homescreen_controller.dart';
import '../controllers/checkout_controller.dart';

class CheckoutkeranjangView extends GetView<CheckoutkeranjangController> {
  final authC = Get.find<AuthController>();
  final homeC = Get.find<HomescreenController>();
  late int subproduk;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Container(
          child: IconButton(
            onPressed: () async {
              Get.back();
            },
            icon: Icon(
              Icons.keyboard_arrow_left,
              size: 30,
              color: keempat,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Shoes.exe | Checkout',
          style: GoogleFonts.poppins(
              color: keempat, fontWeight: FontWeight.w600, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            child: Image.asset(
              "assets/images/background6.png",
              fit: BoxFit.fitWidth,
            ),
          ),
          ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              // UNTUK ALAMAT
              StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: controller.dataUser(authC.auth.currentUser!.email!),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.active) {
                      controller.dataU = snap.data!.data()!;
                      return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 2),
                        height: Get.height * 0.15,
                        child: Card(
                          elevation: 15,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  height: Get.height,
                                  width: 220,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        height: 25,
                                        width: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                                "assets/logo/alamat.png"),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Alamat pengiriman",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 10),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          "${authC.userM.nama}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 10),
                                                    ),
                                                    controller.dataU["phone"] ==
                                                            ""
                                                        ? TextSpan(
                                                            text: " (-)",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        10),
                                                          )
                                                        : TextSpan(
                                                            text:
                                                                " (${controller.dataU["phone"]})",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        10),
                                                          ),
                                                  ],
                                                ),
                                              ),
                                              controller.dataU["alamat"]
                                                          ["address"] ==
                                                      ""
                                                  ? Text(
                                                      "Alamat belum dimasukkan",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10),
                                                    )
                                                  : Text(
                                                      "${controller.dataU["alamat"]["address"]}, ${controller.dataU["alamat"]["kota"]}, ${controller.dataU["alamat"]["prov"]}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10),
                                                    ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  child: TextButton(
                                    child: Text(
                                      "Ubah",
                                      style: GoogleFonts.poppins(
                                          color: keempat, fontSize: 10),
                                    ),
                                    onPressed: () {
                                      Get.toNamed(Routes.ALAMATCOMPLETE,
                                          arguments: [
                                            controller.dataU["phone"],
                                            controller.dataU["alamat"]
                                                ["idProv"],
                                            controller.dataU["alamat"]["prov"],
                                            controller.dataU["alamat"]
                                                ["idKota"],
                                            controller.dataU["alamat"]["kota"],
                                            controller.dataU["alamat"]
                                                ["address"],
                                          ]);
                                    },
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return SizedBox(
                      height: 1,
                    );
                  }),
              // UNTUK PRODUK YANG DIPESAN
              // MENGAMBIL DATA TOKO BERDASARKAN COLLECTION BELANJA
              FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  future: controller.dataBelanja(
                    authC.auth.currentUser!.email!,
                  ),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.done) {
                      List dataP = [];
                      snap.data?.docs.forEach((e) {
                        dataP.add(e);
                      });
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dataP.length,
                        itemBuilder: (context, index1) {
                          return Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: Card(
                                  elevation: 15,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 40,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(
                                                      "assets/logo/produk.png"),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text("Produk dipesan",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10))
                                                ],
                                              ),
                                              Text(
                                                "Jumlah",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 10),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // MENGAMBIL DATA PRODUK BERDASARKAN TOKO
                                        FutureBuilder<
                                                QuerySnapshot<
                                                    Map<String, dynamic>>>(
                                            future: controller.dataProduk(
                                                authC.auth.currentUser!.email!,
                                                dataP[index1]["id_toko"]),
                                            builder: (context, snappro) {
                                              if (snappro.connectionState ==
                                                  ConnectionState.done) {
                                                var data = snappro.data!.docs;
                                                return ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount: data.length,
                                                  itemBuilder:
                                                      (context, index2) {
                                                    // MENGAMBIL DETAIL PRODUK

                                                    return FutureBuilder(
                                                      future: controller
                                                          .detailProduk(data[
                                                                  index2]
                                                              ["id_produk"]),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .done) {
                                                          ProdukData produk =
                                                              ProdukData.fromJson(
                                                                  snapshot.data!
                                                                      .data()!);
                                                          controller.listproduk
                                                              .add({
                                                            "nama": produk
                                                                .namaProduk,
                                                            "namatoko":
                                                                dataP[index1]
                                                                    ["toko"],
                                                            "emailtoko":
                                                                dataP[index1]
                                                                    ["id_toko"],
                                                            "berat":
                                                                produk.berat,
                                                            "harga":
                                                                produk.harga,
                                                            "jumlah":
                                                                data[index2]
                                                                    ["jumlah"],
                                                            "id":
                                                                produk.idProduk,
                                                            "size": data[index2]
                                                                ["size"],
                                                            "pemesan":
                                                                controller
                                                                        .dataU[
                                                                    "email"],
                                                            "alamat":
                                                                "${controller.dataU["alamat"]["address"]} ${controller.dataU["alamat"]["kota"]} ${controller.dataU["alamat"]["prov"]}"
                                                          });

                                                          return Container(
                                                            height: 70,
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                    flex: 2,
                                                                    child:
                                                                        Container(
                                                                      child: Image
                                                                          .network(
                                                                              "${produk.photoUrl}"),
                                                                    )),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Expanded(
                                                                    flex: 2,
                                                                    child:
                                                                        Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            "${produk.namaProduk}",
                                                                            style:
                                                                                GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12),
                                                                          ),
                                                                          Text(
                                                                            "Size ${data[index2]["size"]}",
                                                                            style: GoogleFonts.poppins(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontSize: 10,
                                                                                color: Colors.grey),
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )),
                                                                Expanded(
                                                                    child:
                                                                        Container(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              5),
                                                                  child: Text(
                                                                      "${data[index2]["jumlah"]} pcs",
                                                                      style: GoogleFonts.poppins(
                                                                          fontSize:
                                                                              10)),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                )),
                                                              ],
                                                            ),
                                                          );
                                                        }
                                                        return SizedBox(
                                                          height: 1,
                                                        );
                                                      },
                                                    );
                                                  },
                                                );
                                              } else {}
                                              return SizedBox(
                                                height: 1,
                                              );
                                            }),
                                        Container(
                                          height: 30,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Text(
                                            "${homeC.rupiah.format(dataP[index1]["total"])}",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12),
                                          ),
                                          alignment: Alignment.centerRight,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      SizedBox(
                        height: 1,
                      );
                    }
                    return SizedBox(
                      height: 1,
                    );
                  }),

              // UNTUK OPSI PENGIRIMAN
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Card(
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownSearch<Map<String, dynamic>>(
                            onChanged: (value) async {
                              controller.kurir.value = value?["kode"];
                              controller.totalOngkir(
                                await controller.dataU["alamat"]["idKota"]
                                    .toString(),
                                value?["kode"],
                              );
                              await Future.delayed(Duration(seconds: 4));
                              if (value != null) {
                                controller.enableBank.value = true;
                              }
                            },
                            items: [
                              {
                                "kode": "jne",
                                "nama": "Jalur Nugraha Ekakurir (JNE)",
                                "logo": "assets/logo/jne.png"
                              },
                              {
                                "kode": "tiki",
                                "nama": "Titipan Kilat (TIKI)",
                                "logo": "assets/logo/tiki.png"
                              },
                              {
                                "kode": "pos",
                                "nama": "Perusahaan Opsional Surat (POS)",
                                "logo": "assets/logo/pos.png"
                              }
                            ],
                            popupProps: PopupProps.modalBottomSheet(
                              title: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                child: Text(
                                  "Pilih kurir pengiriman",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: hitam,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              itemBuilder: (context, item, isSelected) =>
                                  ListTile(
                                      title: Text(
                                        "${item["nama"]}",
                                        style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            color: hitam,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      trailing: Container(
                                        height: 50,
                                        width: 50,
                                        child: Image.asset("${item["logo"]}"),
                                      )),
                            ),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                fillColor: Colors.grey[400],
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade800)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade800)),
                                label: Row(
                                  children: [
                                    Image.asset("assets/logo/opsikirim.png"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Opsi kurir pengiriman",
                                      style: GoogleFonts.poppins(
                                          fontSize: 10,
                                          color: hitam,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            itemAsString: (item) => "${item["nama"]}",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // UNTUK OPSI PEMBAYARAN
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Card(
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => DropdownSearch<Map<String, dynamic>>(
                              enabled: controller.enableBank.value,
                              items: [
                                {
                                  "kode": "bca",
                                  "nama": "Bank Central Asia (BCA)",
                                  "value": 3000,
                                  "logo": "assets/logo/bca.png"
                                },
                                {
                                  "kode": "bni",
                                  "nama": "Bank Negari Indonesia (BNI)",
                                  "value": 2500,
                                  "logo": "assets/logo/bni.png"
                                },
                                {
                                  "kode": "mandiri",
                                  "nama": "Bank Mandiri",
                                  "value": 2000,
                                  "logo": "assets/logo/mandiri.png"
                                },
                                {
                                  "kode": "bri",
                                  "nama": "Bank Rakyat Indonesia (BRI)",
                                  "value": 3000,
                                  "logo": "assets/logo/bri.png"
                                },
                                {
                                  "kode": "bpd",
                                  "nama": "Bank Pembangunan Daerah (BPD)",
                                  "value": 2000,
                                  "logo": "assets/logo/bpd.png"
                                }
                              ],
                              popupProps: PopupProps.modalBottomSheet(
                                title: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  child: Text(
                                    "Pilih pembayaran (transfer bank)",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: hitam,
                                        fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                itemBuilder: (context, item, isSelected) =>
                                    ListTile(
                                        title: Text(
                                          "${item["nama"]}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              color: hitam,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        trailing: Container(
                                          height: 50,
                                          width: 50,
                                          child: Image.asset("${item["logo"]}"),
                                        )),
                              ),
                              onChanged: (value) {
                                controller.biayapenanganan.value =
                                    value?["value"];
                                controller.totalCheckout();
                              },
                              itemAsString: (item) => "${item["nama"]}",
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  fillColor: Colors.grey[400],
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade800)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade800)),
                                  label: Row(
                                    children: [
                                      Image.asset("assets/logo/opsibayar.png"),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Opsi pembayaran (transfer bank)",
                                        style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            color: hitam,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // UNTUK TOTAL PRODUK
              Container(
                padding: EdgeInsets.only(left: 40, right: 40, bottom: 5),
                height: Get.height * 0.35,
                child: Card(
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Subtotal produk",
                                          style: GoogleFonts.poppins(
                                              fontSize: 9,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text("Total ongkos kirim",
                                            style: GoogleFonts.poppins(
                                                fontSize: 9,
                                                fontWeight: FontWeight.w500)),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text("Biaya layanan",
                                            style: GoogleFonts.poppins(
                                                fontSize: 9,
                                                fontWeight: FontWeight.w500)),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text("Total pembayaran",
                                            style: GoogleFonts.poppins(
                                                fontSize: 9,
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Obx(
                                      () => Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "${homeC.rupiah.format(controller.subproduk)}",
                                            // "${homeC.rupiah.format(controller.subproduk)}",
                                            style: GoogleFonts.poppins(
                                                fontSize: 9,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              "${homeC.rupiah.format(controller.totalongkir.value)}",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              "${homeC.rupiah.format(controller.biayapenanganan.value)}",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              "${homeC.rupiah.format(controller.total.value)}",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Obx(
                                    () => Text(
                                      "${homeC.rupiah.format(controller.total.value)}",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12),
                                    ),
                                  ),
                                  alignment: Alignment.centerLeft,
                                )),
                                Obx(
                                  () => Expanded(
                                      child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: ElevatedButton(
                                      child: Text(
                                        controller.isloading.isTrue
                                            ? "Loading"
                                            : "Buat pesanan",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10),
                                      ),
                                      onPressed: () async {
                                        if (controller.totalongkir.value != 0 &&
                                            controller.biayapenanganan.value !=
                                                0) {
                                          controller.isloading.value = true;
                                          Map<String, dynamic> hasil =
                                              await controller.transaksi();
                                          Map<String, dynamic> pesan =
                                              await controller.pesanantoko();

                                          await Future.delayed(
                                              Duration(seconds: 3));

                                          Get.dialog(
                                              GestureDetector(
                                                onTap: () {
                                                  Get.back();
                                                  Get.back();
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: kelima,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  margin: EdgeInsets.symmetric(
                                                      vertical:
                                                          Get.height * 0.2,
                                                      horizontal: 30),
                                                  child: Container(
                                                    margin: EdgeInsets.all(20),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      border: Border.all(
                                                          color: keempat,
                                                          width: 2),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          height: 170,
                                                          width: 170,
                                                          child: Image.asset(
                                                              "assets/logo/logosepatu.png"),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Container(
                                                          child: Text("haalo"),
                                                        ),
                                                        SizedBox(
                                                          height: 40,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              barrierDismissible: false);

                                          controller.isloading(false);
                                        } else {
                                          Get.snackbar("Gagal",
                                              "Data transaksi tidak boleh kosong");
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ketiga,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                  )),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Shoes.exe",
                              style: GoogleFonts.poppins(
                                  color: keempat,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
