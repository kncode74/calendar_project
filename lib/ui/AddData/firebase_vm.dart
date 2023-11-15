

import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_controller.dart';

class FirebaseBinding extends Bindings{
@override
void dependencies() {
    Get.lazyPut<FirebaseViewModel>(
      () => FirebaseViewModel(),
    );
  }
}
class FirebaseViewModel extends BaseController{

}