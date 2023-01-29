import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  RxInt tabindex = 0.obs;
  RxBool seepass = true.obs;

  var emailC = TextEditingController();
  var passC = TextEditingController();
}
