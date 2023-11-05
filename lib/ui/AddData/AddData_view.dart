import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_view.dart';
import 'package:getx_mvvm_boilerplate/ui/AddData/AddData_vm.dart';

class AddDataView extends BaseView<AddDataScreenVM> {
  final formKey = GlobalKey<FormState>();
  final loginVM = Get.put(AddDataScreenVM());

  @override
  Widget render(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ข้อมูลลูกค้า'),
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: loginVM.nameController.value,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: loginVM.lastnameController.value,
                  decoration: const InputDecoration(labelText: 'lastName'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                    return null;
                  },
                ),
                controller.saveData()
              ],
            ),
          ),
        ));
  }
}
