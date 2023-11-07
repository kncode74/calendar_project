import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_controller.dart';

class AddDataScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddDataScreenVM>(
      () => AddDataScreenVM(),
    );
  }
}

class AddDataScreenVM extends BaseController {
  saveData(String name, String lastname, String province, String phone) {
    Map<String, dynamic> result = {
      'name': name,
      'lastName': lastname,
      'province': province,
      'phone_number': phone
    };
    print('dddddddddddddddd $result');
    Get.back(result: result);
  }
}
