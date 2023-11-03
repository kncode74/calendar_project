import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_view.dart';
import 'package:getx_mvvm_boilerplate/ui/AddData/AddData_vm.dart';

class AddDataView extends BaseView<AddDataScreenVM> {
 
 final formKey = GlobalKey<FormState>();
final loginVM = Get.put(AddDataScreenVM()) ;
  @override
  void onInit(){
    super.onInit();
    

  }
  @override
  Widget render(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ข้อมูลลูกค้า'),
      ),
      body: Form(
        key: formKey,
        child: Column(children: [
          TextFormField(
          controller: loginVM.nameController.value,
            
            decoration:const InputDecoration(
              labelText: 'Name'
              
            ),validator:(value) {
              if(value == null || value.isEmpty){
                return 'กรุณากรอกข้อมูล';
              }
            },
          ),
          TextFormField(
            controller: loginVM.lastnameController.value,
            decoration: const InputDecoration(
              labelText: 'lastName'
            ),validator:(value) {
              if(value == null || value.isEmpty){
                return 'กรุณากรอกข้อมูล';
              }
            },
          ),
          controller.saveData()
        ],),
      ) 
    );
  }
}