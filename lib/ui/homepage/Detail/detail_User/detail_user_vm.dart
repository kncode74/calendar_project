import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_controller.dart';
import 'package:getx_mvvm_boilerplate/models/user_model.dart';

class RxNullable<T> {
  Rx<T> setNull() => (null as T).obs;
}

class DetailUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailUserViewModel>(
      () => DetailUserViewModel(),
    );
  }
}

class DetailUserViewModel extends BaseController {
  final Rx<User?> received = RxNullable<User?>().setNull();

  init() {
    received.value = Get.arguments['user'] as User;
  }

  addPhoneNumber(String phone) {
    String newPhoneNumber = phone;
    List<String> phoneList = received.value?.phoneNumbers ?? [];
    phoneList.add(newPhoneNumber);
    received.value?.phoneNumbers = phoneList;
    received.trigger(received.value);

    print('addPhoneNumber$received');
  }

  deletePhonNumber(int index) {
    received.value?.phoneNumbers?.removeAt(index);
    //Update data .trigger()
    received.trigger(received.value);
    print('deletePhonNumbe ${received.value?.phoneNumbers}');
  }
}
