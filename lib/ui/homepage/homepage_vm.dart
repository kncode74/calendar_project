import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_controller.dart';
import 'package:getx_mvvm_boilerplate/data/repositories/api_repository.dart';
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
  ApiRepository respone = ApiRepository();
  init() {
    loadDataForeFirebase();
  }

  loadDataForeFirebase() async {
    userList.value = await respone.getUser();
  }
  
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
