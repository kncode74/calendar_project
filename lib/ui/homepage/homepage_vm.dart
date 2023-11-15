import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_controller.dart';
import 'package:getx_mvvm_boilerplate/models/user_model.dart';

class HompageScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomepageScreenVM>(
      () => HomepageScreenVM(),
    );
  }
}

class HomepageScreenVM extends BaseController {
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("user");

  final RxList<User> userList = <User>[].obs;

  final RxSet<String> province = <String>{}.obs;

  final RxList selectedUsersList = [].obs;
  
  var isLoading = false;

  selectedDelete(User user) {
    if (selectedUsersList.contains(user)) {
      selectedUsersList.remove(user);
    } else {
      selectedUsersList.add(user);
    }
    userList.refresh();
  }

  deleteDataFromFirebase() {
    for (var user in selectedUsersList.toList()) {
      userCollection.doc(user.id).delete().then((_) {}).catchError((error) {});
    }
    selectedUsersList.clear();
  }

  delete(int index) {
    userList.removeAt(index);
  }

  updateData(User newUser) {
    userList.value = userList.map((User userItem) {
      if (newUser.name == userItem.name) {
        return newUser; // เฉพาะ item ที่อัพเดตเท่านั้น
      }
      return userItem; // คืนค่า item ที่ไม่ได้อัพเดต
    }).toList();
  }

  getData() async {
    try {
      QuerySnapshot userGet =
          await FirebaseFirestore.instance.collection('user').get();
      userList.clear();
      for (var user in userGet.docs) {
        List<String> phoneNumbers = (user['phone_number'] as List<dynamic>)
            .map((dynamic number) => number.toString())
            .toList();
        List<String> fileList = (user['files'] as List<dynamic>)
            .map((dynamic number) => number.toString())
            .toList();
        userList.add(
          User(
            user['name'],
            user['lastName'],
            user['province'],
            phoneNumbers,
            fileList,
            user.id,
          ),
        );
        province.add(user['province']);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }
  // deleteSelectedUsers() {
  //   for (var user in selectedUsersList.toList()) {
  //     userList.remove(user);
  //   }
  //   selectedUsersList.clear();
  // }

  // // แสดงข้อมูลใน masterList
  // showData(List<User> userList) {
  //   for (var user in userList) {
  //     print(
  //         'Name: ${user.name}, Lastname: ${user.lastName},province: ${user.province}, Tel: ${user.phoneNumbers}');
  //   }
  // }
}
