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
            child: const Text('Save'),
          )
        ],
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _textFormField(nameController, 'Name', 'กรุณากรอกข้อมูล'),
              _textFormField(lastnameController, 'LastName', 'กรุณากรอกข้อมูล'),
              _textFormField(provinceController, 'Province', 'กรุณากรอกข้อมูล'),
              _textFormField(phoneNumberController, 'phone', 'กรุณากรอกข้อมูล'),
              InkWell(
                onTap: () {
                  _showActionSheet(context);
                },
                child: const ListTile(
                  title: Text('Upload '),
                  leading: Icon(Icons.file_copy),
                ),
              ),
              Obx(
                () => Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.filesList.length,
                    itemBuilder: (context, index) {
                      String files = controller.filesList[index].path;
                      String lastnameFile = files.split('.').last;
                      String nameFile = files.split('/').last;

                      if (lastnameFile != 'png' && lastnameFile != 'jpg') {
                        return Container(
                          margin: const EdgeInsets.only(left: 10),
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(nameFile),
                            ],
                          ),
                        );
                      } else {
                        return Image.file(File(files));
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFormField(
      TextEditingController controller, String label, String warning) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return warning;
        }
        return null;
      },
    );
  }

  CupertinoActionSheetAction cupertinoSheet(
      IconData icon, String text, void Function() onPressed) {
    return CupertinoActionSheetAction(
      onPressed: () {
        onPressed.call();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(icon), Text(text)],
      ),
    );
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          cupertinoSheet(
            Icons.camera,
            '  Take photo',
            () {
              controller.pickcamaraImage();
            },
          ),
          cupertinoSheet(
            Icons.photo,
            '  Upload Photos',
            () {
              controller.pickGallaryImage();
            },
          ),
          cupertinoSheet(
            Icons.file_copy,
            '  Upload File',
            () {
              controller.attachFile();
            },
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
