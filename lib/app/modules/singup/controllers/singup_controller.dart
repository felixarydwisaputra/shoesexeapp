import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SingupController extends GetxController {
  RxBool seepass = true.obs;

  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController lastN = TextEditingController();
  TextEditingController firstN = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController alamatC = TextEditingController();
}
