import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_view.dart';
import 'package:getx_mvvm_boilerplate/models/user_model.dart';
import 'package:getx_mvvm_boilerplate/ui/homepage/Detail/detail_User/detail_user_vm.dart';

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
        User? user = controller.received.value;
        return Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Get.back(result: user);
              },
              child: const Icon(Icons.arrow_back),
            ),
            title: Text(user?.name ?? ''),
          ),
          body: Form(
            key: formKey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
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
                    _rowShowData('name', user?.name ?? ''),
                    _rowShowData('name', user?.lastName ?? ''),
                    _rowShowData('name', user?.province ?? ''),
                    _rowShowData('name', user?.phoneNumbers ?? ''),
                    Expanded(child: _listViewPhoneNUmber(user)),
                    Expanded(child: _listViewImage(user))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _listViewPhoneNUmber(User? user) {
    return ListView.builder(
      itemCount: user?.phoneNumbers?.length ?? 0,
      itemBuilder: (context, index) {
        return ListTile(
          subtitle: Text(user?.phoneNumbers?[index].toString() ?? ''),
          trailing: InkWell(
              onTap: () {
                controller.deletePhonNumber(index);
              },
              child: const Icon(Icons.delete)),
        );
      },
    );
  }

  Widget _listViewImage(User? user) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: user?.documentFiles?.length ?? 0,
      itemBuilder: (context, index) {
        String? filePath = user?.documentFiles?[index];
        String? lastnameFile = filePath?.split('.').last;
        String? nameFile = filePath?.split('/').last;

        if (lastnameFile == 'png' && lastnameFile == 'jpg') {
          return Image.file(File(filePath!));
        }
        return Container(
          margin: const EdgeInsets.only(left: 10),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(nameFile!),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _rowShowData(String name, var data) {
    return Row(
      children: [
        Text('$name : $data'),
      ],
    );
  }
}
