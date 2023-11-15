import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_view.dart';
import 'package:getx_mvvm_boilerplate/models/user_model.dart';
import 'package:getx_mvvm_boilerplate/ui/AddData/AddData_view.dart';
import 'package:getx_mvvm_boilerplate/ui/AddData/AddData_vm.dart';
import 'package:getx_mvvm_boilerplate/ui/homepage/Detail/detail_User/detail_user_view.dart';
import 'package:getx_mvvm_boilerplate/ui/homepage/Detail/detail_User/detail_user_vm.dart';
import 'package:getx_mvvm_boilerplate/ui/homepage/Detail/detail_province/detail_province_view.dart';
import 'package:getx_mvvm_boilerplate/ui/homepage/Detail/detail_province/detail_province_vm.dart';
import 'package:getx_mvvm_boilerplate/ui/homepage/homepage_vm.dart';

class HompageView extends BaseView<HomepageScreenVM> {
  @override
  void onInit() async {
    controller.init();
  }

  @override
  Widget render(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ข้อมูลลูกค้า'),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await controller.deleteDataFromFirebase();
                controller.loadDataForeFirebase();
              },
              child: const Icon(Icons.delete),
            ),
          ],
        ),
        body: DefaultTabController(
          length: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_tabBar(), _tabbarView()],
          ),
        ),
        floatingActionButton: _floatingButton());
  }

  Widget _tabBar() {
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
            ),
          ),
        ),
      ],
    );
  }

  Widget _firstTab() {
    return Scaffold(body: Obx(() {
      return Center(
        child: controller.isLoading
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: controller.userList.length,
                itemBuilder: (BuildContext context, index) {
                  final user = controller.userList[index];
                  print('kkkkkk :$user');
                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Get.to(
                              DetailUserView(),
                              binding: DetailUserBinding(),
                              arguments: {'user': user.id},
                            )?.then((_) {
                              controller.loadDataForeFirebase();
                            });
                          },
                          title: Row(
                            children: [
                              Text(user.name),
                              Text(user.lastName),
                            ],
                          ),
                          subtitle: Text(user.province),
                          trailing: Checkbox(
                            value: controller.selectedUsersList.contains(user),
                            onChanged: (value) {
                              controller.selectedDelete(user);
                              print(
                                  'object ${controller.selectedUsersList.contains(user)}');
                            },
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
                  );
                },
              ),
      );
    }));
  }

  Widget _secoundTab() {
    return Obx(
      () => Scaffold(
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
                child: ListTile(title: Text("จังหวัด : $province")));
          },
        ),
      ),
    );
  }

  Future<String?> _dailog(BuildContext context, int index) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('delete ?'),
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

  Widget _floatingButton() {
    return FloatingActionButton(
      onPressed: (() async {
        await Get.to(() => AddDataView(), binding: AddDataScreenBinding());
        controller.loadDataForeFirebase();
      }),
      child: const Icon(Icons.add),
    );
  }

  Widget _tabbarView() {
    return Expanded(
      child: TabBarView(children: [_firstTab(), _secoundTab()]),
    );
  }
}
