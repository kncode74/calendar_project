import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_controller.dart';

class AddDataScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddDataScreenVM>(
      () => AddDataScreenVM(),
    );
  }
}

class AddDataScreenVM extends BaseController {
  final Rx<TextEditingController> nameController = TextEditingController().obs;
  final Rx<TextEditingController> lastnameController =
      TextEditingController().obs;
  final Rx<TextEditingController> provinceController =
      TextEditingController().obs;

  Widget saveData() {
    return ElevatedButton(
      onPressed: () {
        Map<String, dynamic> result = {
          'name': nameController.value.text,
          'lastName': lastnameController.value.text
        };

        Get.back(result: result);
      },
      child: const Text('save'),
    );
  }
}
