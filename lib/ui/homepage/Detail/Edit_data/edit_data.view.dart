import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_view.dart';
import 'package:getx_mvvm_boilerplate/ui/homepage/Detail/Edit_data/edit_data.vm.dart';

class EditDataView extends BaseView<EditDataViewModel> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController provinceController = TextEditingController();

  @override
  void onInit() {
    controller.init();
  }

  @override
  Widget render(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
              onPressed: () {
                controller.editData(nameController.text, lastController.text,
                    provinceController.text);
              },
              child: const Text('Done'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () {
            nameController =
                TextEditingController(text: controller.result.value?.name);
            lastController =
                TextEditingController(text: controller.result.value?.lastName);
            provinceController =
                TextEditingController(text: controller.result.value?.province);
            return Column(
              children: [
                _textFormFieldCustom(nameController, 'name'),
                _textFormFieldCustom(lastController, 'lastname'),
                _textFormFieldCustom(provinceController, 'province')
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _textFormFieldCustom(
      TextEditingController dataController, String labelText) {
    return TextFormField(
      controller: dataController,
      decoration: InputDecoration(labelText: labelText),
    );
  }
}
