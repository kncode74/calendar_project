import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_view.dart';
import 'package:getx_mvvm_boilerplate/models/user_model.dart';
import 'package:getx_mvvm_boilerplate/ui/homepage/Detail/Edit_data/edit_data.view.dart';
import 'package:getx_mvvm_boilerplate/ui/homepage/Detail/Edit_data/edit_data.vm.dart';

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
    return Obx(() {
      User? detailUser = controller.userDetails.value;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            ElevatedButton(
                onPressed: () async {
                  await Get.to(EditDataView(),
                      binding: EditDataBinding(),
                      arguments: {'user': detailUser})?.then((_) {
                    controller.loadDetailUser();
                  });
                  ;
                },
                child: const Text('Edit Data'))
          ],
          title: Text(detailUser?.name ?? ''),
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
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await controller.addPhone(
                            phoneController.text, detailUser!.id);
                        controller.loadDetailUser();
                      }
                      phoneController.clear();
                    },
                    child: const Text('Add Phone Number'),
                  ),
                  _rowShowData('name', detailUser?.name),
                  _rowShowData('lastname', detailUser?.lastName),
                  _rowShowData('province', detailUser?.province),
                  _rowShowData('PhoneNumber', detailUser?.phoneNumbers),
                  Expanded(
                      child: _listViewPhoneNUmber(
                          detailUser, phoneController.text)),
                  Expanded(child: _listViewImage(detailUser))
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _listViewPhoneNUmber(User? user, String phone) {
    return ListView.builder(
      itemCount: user?.phoneNumbers?.length ?? 0,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(user?.phoneNumbers?[index].toString() ?? ''),
          trailing: Wrap(
            spacing: 12,
            children: [
              InkWell(onTap: () {}, child: const Icon(Icons.edit)),
              InkWell(
                  onTap: () {
                    controller.deletePhoneByIndex(index, user!.id).then((_) {
                      controller.loadDetailUser();
                    });
                  },
                  child: const Icon(Icons.delete)),
            ],
          ),
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

        String? cutFirst = filePath?.split('.').last;
        String? lastnameFile = cutFirst?.split('?').first;
//https://firebasestorage.googleapis.com/v0/b/intern-2-e73d8.appspot.com/o/images%2F0.docx?alt=media&token=00589e79-cebd-4e46-89a8-6ec8472a83bb
        String? cutNameFile = filePath?.split('%').last;
        String? nameFile = cutNameFile?.split('?').first;
        if (lastnameFile == 'png' || lastnameFile == 'jpg') {
          return Image.network(filePath!);
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
        Expanded(child: Text('$name : $data')),
      ],
    );
  }
}
