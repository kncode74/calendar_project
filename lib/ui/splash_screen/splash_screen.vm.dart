import 'package:get/get.dart';

import '../../application/base/base_controller.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController>(
      () => SplashScreenController(),
    );
  }
}

class SplashScreenController extends BaseController {
  //
  final Rx<String>  str= 'hell'.obs;

  void setString(String name){
    str.value += ' unikwan';
  print(str.value);
  }
}
