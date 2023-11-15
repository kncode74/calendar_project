import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_controller.dart';
import 'package:getx_mvvm_boilerplate/models/user_model.dart';

class RxNullable<T> {
  Rx<T> setNull() => (null as T).obs;
}

class EditDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditDataViewModel>(
      () => EditDataViewModel(),
    );
  }
}

class EditDataViewModel extends BaseController {
  final Rx<User?> result = RxNullable<User?>().setNull();
  init() {
    result.value = Get.arguments['user'];
  }

  editData(String name, String lastname, String province) async {
    try {
      String userId = result.value!.id;
      CollectionReference users = FirebaseFirestore.instance.collection('user');
      await users.doc(userId).update(
        {
          'name': name,
          'lastName': lastname,
          'province': province,
        },
      );

      Get.back();
    } catch (e) {
      print('error: $e');
    }
  }
}
