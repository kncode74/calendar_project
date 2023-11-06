import 'package:get/get.dart';
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
      binding: HompageScreenBinding(),
    ),
  ];
}
