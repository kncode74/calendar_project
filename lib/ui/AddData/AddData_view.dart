import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_view.dart';
import 'package:getx_mvvm_boilerplate/ui/AddData/AddData_vm.dart';

class AddDataView extends BaseView<AddDataScreenVM> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  @override
  Widget render(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ข้อมูลลูกค้า'),
        actions: [
          ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  controller.saveData(
                    nameController.text,
                    lastnameController.text,
                    provinceController.text,
                    phoneNumberController.text,
                  );
                }
              },
              child: const Text('Save'))
        ],
      ),
      body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: lastnameController,
                  decoration: const InputDecoration(labelText: 'lastName'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: provinceController,
                  decoration: const InputDecoration(labelText: 'province'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: phoneNumberController,
                  decoration: const InputDecoration(labelText: 'Tell '),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                    return null;
                  },
                ),
                InkWell(
                  onTap: () {
                    _showActionSheet(context);
                  },
                  child: const ListTile(
                    title: Text('Upload '),
                    leading: Icon(Icons.file_copy),
                  ),
                ),
                Obx(() => Expanded(
                        child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.filesList.length,
                      itemBuilder: (context, index) {
                        return Image.file(
                            File(controller.filesList[index].path));
                      },
                    )))
              ],
            ),
          )),
    );
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
              //isDefaultAction: true,
              onPressed: () {
                controller.pickcamaraImage();
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.camera), Text('  Take photo')],
              )),
          CupertinoActionSheetAction(
              //isDefaultAction: true,
              onPressed: () {
                controller.pickGallaryImage();
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.photo), Text('  Upload Photos')],
              )),
          CupertinoActionSheetAction(
              onPressed: () {
                controller.attachFile();
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.file_copy), Text('  Upload File')],
              )),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
