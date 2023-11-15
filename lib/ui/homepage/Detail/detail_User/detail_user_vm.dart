import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_controller.dart';
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

  getUserDetails(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userGet =
          await FirebaseFirestore.instance.collection('user').doc(userId).get();

      if (userGet.exists) {
        List<String> phoneNumbers = (userGet['phone_number'] as List<dynamic>)
            .map((dynamic number) => number.toString())
            .toList();
        List<String> fileList = (userGet['files'] as List<dynamic>)
            .map((dynamic number) => number.toString())
            .toList();

        userDetails.value = User(
          userGet['name'],
          userGet['lastName'],
          userGet['province'],
          phoneNumbers,
          fileList,
          userId,
        );
        // print('ffffff $userDetails');
      }
    } catch (e) {
      print('${e.toString()}');
    }
    return userDetails;
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
