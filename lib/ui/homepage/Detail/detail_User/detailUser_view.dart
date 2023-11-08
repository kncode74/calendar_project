import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_view.dart';
import 'package:getx_mvvm_boilerplate/models/user_model.dart';
import 'package:getx_mvvm_boilerplate/ui/homepage/Detail/detail_User/detailUser_vm.dart';

class DetailUserView extends BaseView<DetailUserViewModel> {
  @override
  void onInit() {
    controller.init();
  }

  TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget render(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            // automaticallyImplyLeading: false,
            leading: InkWell(
              onTap: () {
                User? userList = controller.received.value;
                print('tttttt ${controller.received.value}');
                Get.back(result: userList);
              },
              child: Icon(Icons.back_hand),
            ),
            // BackButton(
            //     onPressed: () {
            //       User? userList = controller.received.value;
            //       print('tttttt ${controller.received.value}');
            //       Get.back(result: userList);
            //       // Navigator.pop(context);
            //     },
            //     color: Colors.black),
            title: Text(controller.received.value?.name ?? ''),
          ),
          body: Form(
            key: formKey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        User? userList = controller.received.value;
                        print('tttttt ${controller.received.value}');
                        Get.back(result: userList);
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                    TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                          labelText: 'กรอกเบอร์มือถือเพิ่ม'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกข้อมูล';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            controller.addPhoneNumber(phoneController.text);
                          }
                        },
                        child: const Text('บันทึก')),
                    Row(
                      children: [
                        Text('name : ${controller.received.value?.name ?? ''}'),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                            'lastname : ${controller.received.value?.lastName ?? ''}'),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                            'province : ${controller.received.value?.province ?? ''}'),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                            'phoneNumber : ${controller.received.value?.phoneNumbers ?? ''}'),
                      ],
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount:
                          controller.received.value?.phoneNumbers?.length ?? 0,
                      itemBuilder: (context, index) {
                        return ListTile(
                          subtitle: Text(controller
                                  .received.value?.phoneNumbers?[index]
                                  .toString() ??
                              ''),
                          trailing: InkWell(
                              onTap: () {
                                controller.deletePhonNumber(index);
                              },
                              child: const Icon(Icons.delete)),
                        );
                      },
                    ))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
