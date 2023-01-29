import 'package:get/get.dart';

import 'package:shoesexe/app/modules/singup/controllers/complete_controller.dart';

import '../controllers/singup_controller.dart';

class SingupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompleteController>(
      () => CompleteController(),
    );
    Get.lazyPut<SingupController>(
      () => SingupController(),
    );
  }
}
