import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_controller.dart';
import 'package:getx_mvvm_boilerplate/data/repositories/api_repository.dart';
import 'package:getx_mvvm_boilerplate/models/user_model.dart';

class RxNullable<T> {
  Rx<T?> setNull() => Rx<T?>(null);
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
  Rx<User?> userDetails = RxNullable<User>().setNull();

  String received = Get.arguments['user'];
  ApiRepository repository = ApiRepository();
  init() {
    loadDetailUser();
  }

  loadDetailUser() async {
    userDetails.value = await repository.getDetailUser(received);
    print(userDetails.value);
  }

  Future<void> addPhone(String number, String userId) async {
    List<String> phoneNum = userDetails.value?.phoneNumbers ?? [];
    phoneNum.add(number);
    try {
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('user').doc(userId);

      await userDocRef.update(
        {
          'phone_number': phoneNum,
        },
      );
    } catch (e) {
      print('Error adding phone number: $e');
    }
  }

  Future<void> deletePhoneByIndex(int index, String userId) async {
    List<String> phoneNum = userDetails.value?.phoneNumbers ?? [];
    phoneNum.removeAt(index);
    try {
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('user').doc(userId);
      await userDocRef.update(
        {
          'phone_number': phoneNum,
        },
      );
    } catch (e) {
      print('Error deleting phone number: $e');
    }
  }

  // addPhoneNumber(String phone) {
  //   String newPhoneNumber = phone;
  //   List<String> phoneList = received.value?.phoneNumbers ?? [];
  //   phoneList.add(newPhoneNumber);
  //   received.value?.phoneNumbers = phoneList;
  //   received.trigger(received.value);

  //   print('addPhoneNumber$received');
  // }

  // delete(int index) {
  //   received.value?.phoneNumbers?.removeAt(index);
  //   //Update data .trigger()
  //   received.trigger(received.value);
  //   print('deletePhonNumbe ${received.value?.phoneNumbers}');
  // }
}
