import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_controller.dart';

class HompageScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomepageScreenController>(
      () => HomepageScreenController(),
    );
  }
}

class User {
  final String name;
  final String lastName;
  final String province;
  User(this.name, this.lastName, this.province);
}

class HomepageScreenController extends BaseController {
  RxList<User> usersInProvince = <User>[].obs;

  final RxList<User> userList = <User>[].obs;

  //สร้าง set เก็บข้อมูล จังหวัดที่ไม่แสดงไม่ซ้ำกัน
  final RxSet<String> province = <String>{}.obs;

//เพิ่มข้อมูล Map ใส่ไว้ในลิสต์
  addUser(Map<String, dynamic> user) {
    userList.add(
      User(user['name'], user['lastName'], user['province']),
    );
    province.add(user['province']);
    // ignore: avoid_print
    print(userList.value);
  }

  // whereUser(List<User> userlist, int index) {
  //   usersInProvince = userList
  //       .where((user) => user.province == province.toList()[index])
  //       .toList();
  // }

//สร้างปุ่มลบข้อมูล
//โดยรับค่า index
//.removeAt
  delete(int index) async {
    userList.removeAt(index);
    Get.back();
  }
}
