import 'package:get/get.dart';

import '../modules/brands/bindings/brands_binding.dart';
import '../modules/brands/views/brands_view.dart';
import '../modules/catalog/bindings/catalog_binding.dart';
import '../modules/catalog/views/catalog_view.dart';
import '../modules/checkout/bindings/checkout_binding.dart';
import '../modules/checkout/views/alamat_view.dart';
import '../modules/checkout/views/checkout_view.dart';
import '../modules/detailproduk/bindings/detailproduk_binding.dart';
import '../modules/detailproduk/views/detailproduk_view.dart';

import '../modules/tokodetail/bindings/editbarang_binding.dart';
import '../modules/tokodetail/views/editbarang_view.dart';
import '../modules/editdetailproduk/bindings/editproduk_binding.dart';
import '../modules/editdetailproduk/views/editproduk_view.dart';
import '../modules/favorite/bindings/favorite_binding.dart';
import '../modules/favorite/views/favorite_view.dart';
import '../modules/homescreen/bindings/homescreen_binding.dart';
import '../modules/homescreen/views/homescreen_view.dart';
import '../modules/homestore/bindings/homestore_binding.dart';
import '../modules/homestore/views/homestore_view.dart';
import '../modules/introscreen/bindings/introscreen_binding.dart';
import '../modules/introscreen/views/introscreen_view.dart';
import '../modules/keranjang/bindings/keranjang_binding.dart';
import '../modules/keranjang/views/keranjang_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/pesanansaya/bindings/pesanansaya_binding.dart';
import '../modules/pesanansaya/views/pesanansaya_view.dart';
import '../modules/pesanantoko/bindings/pesanantoko_binding.dart';
import '../modules/pesanantoko/views/pesanantoko_view.dart';
import '../modules/singup/bindings/singup_binding.dart';
import '../modules/singup/views/completeuser_view.dart';
import '../modules/singup/views/singup_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/store/bindings/store_binding.dart';
import '../modules/store/views/store_view.dart';
import '../modules/tambahbarang/bindings/tambahbarang_binding.dart';
import '../modules/tambahbarang/views/tambahbarang_view.dart';
import '../modules/user/bindings/user_binding.dart';
import '../modules/user/views/user_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.HOMESCREEN,
      page: () => HomescreenView(),
      binding: HomescreenBinding(),
    ),
    GetPage(
      name: _Paths.INTROSCREEN,
      page: () => IntroscreenView(),
      binding: IntroscreenBinding(),
    ),
    GetPage(
      name: _Paths.USER,
      page: () => UserView(),
      binding: UserBinding(),
    ),
    GetPage(
      name: _Paths.BRANDS,
      page: () => BrandsView(),
      binding: BrandsBinding(),
    ),
    GetPage(
      name: _Paths.CATALOG,
      page: () => CatalogView(),
      binding: CatalogBinding(),
    ),
    GetPage(
      name: _Paths.DETAILPRODUK,
      page: () => DetailprodukView(),
      binding: DetailprodukBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: _Paths.PESANANSAYA,
      page: () => PesanansayaView(),
      binding: PesanansayaBinding(),
    ),
    GetPage(
      name: _Paths.STORE,
      page: () => StoreView(),
      binding: StoreBinding(),
    ),
    GetPage(
      name: _Paths.HOMESTORE,
      page: () => HomestoreView(),
      binding: HomestoreBinding(),
    ),
    GetPage(
      name: _Paths.EDITBARANG,
      page: () => EditbarangView(),
      binding: EditbarangBinding(),
    ),
    GetPage(
      name: _Paths.PESANANTOKO,
      page: () => PesanantokoView(),
      binding: PesanantokoBinding(),
    ),
    GetPage(
      name: _Paths.SINGUP,
      page: () => SingupView(),
      binding: SingupBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAHBARANG,
      page: () => TambahbarangView(),
      binding: TambahbarangBinding(),
    ),
    GetPage(
      name: _Paths.EDITPRODUK,
      page: () => EditprodukView(),
      binding: EditprodukBinding(),
    ),
    GetPage(
      name: _Paths.COMPLETEUSER,
      page: () => CompleteuserView(),
    ),
    GetPage(
      name: _Paths.ALAMATCOMPLETE,
      page: () => AlamatView(),
    ),
    GetPage(
      name: _Paths.KERANJANG,
      page: () => KeranjangView(),
      binding: KeranjangBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITE,
      page: () => FavoriteView(),
      binding: FavoriteBinding(),
    ),
  ];
}
