import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_view.dart';
import 'package:getx_mvvm_boilerplate/models/user_model.dart';
import 'package:getx_mvvm_boilerplate/ui/homepage/Detail/detail_province/detailProvince_vm.dart';
import 'package:getx_mvvm_boilerplate/ui/homepage/Detail/inprovine.dart';

class DetailprovinceView extends BaseView<DetailProvinceViewModel> {
  @override
  Widget render(BuildContext context) {
    //ประกาศใช้
    List<User> usersInProvince = controller.whereUser();
    return Scaffold(
        appBar: AppBar(
          title: Text(controller.province),
        ),
        body: ListView.builder(
          itemCount: usersInProvince.length,
          itemBuilder: (context, index) {
            final user = usersInProvince[index];
            return InkWell(
              onTap: () {
                Get.to(const Inprovince(), arguments: {'user': user});
              },
              child: ListTile(
                title: Text(
                  user.name,
                ),
                subtitle: Text(user.lastName),
              ),
            );
          },
        ));
  }
}
