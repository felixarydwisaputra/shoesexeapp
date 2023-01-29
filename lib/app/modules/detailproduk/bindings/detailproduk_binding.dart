import 'package:get/get.dart';

import '../controllers/detailproduk_controller.dart';

class DetailprodukBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailprodukController>(
      () => DetailprodukController(),
    );
  }
}
