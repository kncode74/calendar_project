import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_controller.dart';

class CalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CalendarVM>(
      () => CalendarVM(),
    );
  }
}

class CalendarVM extends BaseController {}
