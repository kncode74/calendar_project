import 'dart:io';

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
              child: const Icon(Icons.back_hand),
            ),

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
                        Expanded(
                          child: Text(
                            'phoneNumber : ${controller.received.value?.phoneNumbers ?? ''}',
                            overflow: TextOverflow.clip,
                          ),
                        ),
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
                    )),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            controller.received.value?.documentFiles?.length ??
                                0,
                        itemBuilder: (context, index) {
                          String? filePath =
                              controller.received.value?.documentFiles?[index];
                          String? lastnameFile = filePath?.split('.').last;
                          String? nameFile = filePath?.split('/').last;

                          if (lastnameFile != 'png' && lastnameFile != 'jpg') {
                            return Container(
                                margin: const EdgeInsets.only(left: 10),
                                color: Colors.yellow,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(nameFile!),
                                  ],
                                ));
                          } else {
                            return Image.file(File(filePath!));
                          }
                        },
                      ),
                    )
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
