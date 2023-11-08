import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_controller.dart';
import 'package:getx_mvvm_boilerplate/models/user_model.dart';


class DetailProvinceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailProvinceViewModel>(
      () => DetailProvinceViewModel(),
    );
  }
}

class DetailProvinceViewModel extends BaseController {
  final province = Get.arguments['province'];
  List<User> userList = Get.arguments['user'];

  whereUser() {
    List<User> usersInProvince =
        userList.where((user) => user.province == province).toList();
    return usersInProvince;
  }
}
