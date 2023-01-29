import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CompleteController extends GetxController {
  TextEditingController alamatC = TextEditingController();

  // apiKey
  var apiKey = "7e29ffa20c825c9d734d5b79ced0316b";
  // provinsi asal
  RxString idprovasal = "0".obs;
  RxString provasal = "".obs;
  // kota asal
  RxString idcityasal = "0".obs;
  RxString cityasal = "".obs;
}
