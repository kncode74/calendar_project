import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_view.dart';
import 'package:getx_mvvm_boilerplate/ui/AddData/AddData_vm.dart';

class AddDataView extends BaseView<AddDataScreenVM> {
  final formKey = GlobalKey<FormState>();

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
              child: Obx(
                () => Column(
                  children: [
                    TextFormField(
                      controller: controller.nameController.value,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกข้อมูล';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: controller.lastnameController.value,
                      decoration: const InputDecoration(labelText: 'lastName'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกข้อมูล';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: controller.provinceController.value,
                      decoration: const InputDecoration(labelText: 'province'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกข้อมูล';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          controller.saveData();
                        },
                        child: const Text('Save'))
                  ],
                ),
              )),
        ));
  }
}
