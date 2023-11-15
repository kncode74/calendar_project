import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/models/user_model.dart';
import 'package:getx_mvvm_boilerplate/ui/homepage/homepage_vm.dart';

class GetDataPublic {
  Future<List<User>> fetchData() async {
    HomepageScreenVM homepageController = Get.find();
    await homepageController.getData();
    return homepageController.userList;
    
  }
}
