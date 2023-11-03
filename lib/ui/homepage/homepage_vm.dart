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

class HomepageScreenController extends BaseController {
  final RxList<User> userList = <User>[].obs;
addUser(Map<String,dynamic> user) {
  userList.add(User(user['name'], user['lastName']),);
  print(userList.value);
}

}

class User {
  final String name;
  final String lastName;
User(this.name, this.lastName);

}