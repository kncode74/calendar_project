import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/ui/AddData/firebase.dart';
import 'package:getx_mvvm_boilerplate/ui/AddData/firebase_vm.dart';
import 'package:getx_mvvm_boilerplate/ui/homepage/Detail/detail_User/detail_user_view.dart';
import 'package:getx_mvvm_boilerplate/ui/homepage/Detail/detail_User/detail_user_vm.dart';
import 'package:getx_mvvm_boilerplate/ui/homepage/homapage_view.dart';
import 'package:getx_mvvm_boilerplate/ui/homepage/homepage_vm.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splashScreen;

  static final routes = [
    GetPage(
      name: _Paths.splashScreen,
      page: () => HompageView(),
      binding: HompageScreenBinding()
    ),
    // GetPage(
    //   name: _Paths.detailUser,
    //   page: () => DetailUserView(),
    //   binding: DetailUserBinding(),
    // ),
  ];
}
