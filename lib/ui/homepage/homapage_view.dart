import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_view.dart';
import 'package:getx_mvvm_boilerplate/ui/AddData/AddData_view.dart';
import 'package:getx_mvvm_boilerplate/ui/AddData/AddData_vm.dart';
import 'package:getx_mvvm_boilerplate/ui/homepage/Detail/detail_User/detailUser_view.dart';
import 'package:getx_mvvm_boilerplate/ui/homepage/Detail/detail_User/detailUser_vm.dart';
import 'package:getx_mvvm_boilerplate/ui/homepage/Detail/detail_province/detailProvince_view.dart';
import 'package:getx_mvvm_boilerplate/ui/homepage/Detail/detail_province/detailProvince_vm.dart';
import 'package:getx_mvvm_boilerplate/ui/homepage/homepage_vm.dart';

class HompageView extends BaseView<HomepageScreenController> {
  @override
  Widget render(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ข้อมูลลูกค้า'),
        ),
        body: DefaultTabController(
          length: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [tabBar(), tabbarView()],
          ),
        ),
        floatingActionButton: clickCreate());
  }

  Widget tabBar() {
    return const TabBar(
      tabs: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Tab(
            icon: Icon(
              Icons.people,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Tab(
              icon: Icon(
            Icons.card_giftcard,
            color: Colors.black,
          )),
        ),
      ],
    );
  }

  Widget first() {
    controller.showData(controller.userList);

    return Scaffold(
        body: Obx(() => ListView.builder(
            itemCount: controller.userList.length,
            itemBuilder: ((context, index) {
              User user = controller.userList[index];
              return InkWell(
                onTap: () async {
                  var backData = await Get.to(DetailUserView(),
                      arguments: {'user': user}, binding: DetailUserBinding());
                  controller.updateData(backData);
                },
                child: Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text('User : '),
                            Text(user.name),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(user.lastName),
                            InkWell(
                                onTap: () {
                                  dailog(context, index);
                                },
                                child: const Icon(Icons.delete))
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: user.phoneNumbers!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(user.phoneNumbers![index]),
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
            }))));
  }

  Widget secound() {
    return Obx(() => Scaffold(
          body: ListView.builder(
            itemCount: controller.province.length,
            itemBuilder: (context, index) {
              final province = controller.province.toList()[index];
              List<User> user = controller.userList.toList();
              return InkWell(
                  onTap: () {
                    Get.to(DetailprovinceView(),
                        arguments: {'province': province, 'user': user},
                        binding: DetailProvinceBinding());
                  },
                  child: ListTile(
                      title: Text(
                          "จังหวัด : ${controller.province.toList()[index]}")));
            },
          ),
        ));
  }

  Future<String?> dailog(BuildContext context, int index) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('delete ?'),
        //content: const Text(''),
        actions: <Widget>[
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.delete(index);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget clickCreate() {
    return FloatingActionButton(
      onPressed: (() async {
        Map<String, dynamic> result =
            await Get.to(() => AddDataView(), binding: AddDataScreenBinding());
        print('result $result');
        controller.addUser(result);
        // ignore: avoid_print
      }),
      child: const Icon(Icons.add),
    );
  }

  Widget tabbarView() {
    return Expanded(
      child: TabBarView(children: [first(), secound()]),
    );
  }
}
