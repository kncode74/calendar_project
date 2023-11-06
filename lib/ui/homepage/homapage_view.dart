import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_view.dart';
import 'package:getx_mvvm_boilerplate/ui/AddData/AddData_view.dart';
import 'package:getx_mvvm_boilerplate/ui/AddData/AddData_vm.dart';
import 'package:getx_mvvm_boilerplate/ui/homepage/Detail/detailUser_view.dart';
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
    return Scaffold(
        body: Obx(() => ListView.builder(
            itemCount: controller.userList.length,
            itemBuilder: ((context, index) {
              User user = controller.userList[index];
              return InkWell(
                onTap: () {
                  Get.to(
                    const DetailUserView(),
                    arguments: {'user': user},
                  );
                },
                child: ListTile(
                    title: Text(
                      user.name,
                    ),
                    subtitle: Text(user.lastName),
                    trailing: InkWell(
                      onTap: () => dailog(context, index),
                      child: const Icon(Icons.delete),
                    )),
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
                      title: Text(controller.province.toList()[index])));
            },
          ),
        ));
  }

//ข้อมูลผู้ใช้ที่ดูจากจังหวัด
  Widget detailUserInProvinces(int index, List<User> user) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [Text(user[index].name), Text(user[index].lastName)],
            )
          ],
        ),
      ),
    );
  }

//ลิสต์ผู็ใช้ในจังหวัด
  Widget detailProvince(int index, List<User> userList) {
    //
    List<User> usersInProvince = userList
        .where((user) => user.province == controller.province.toList()[index])
        .toList();

    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text(controller.province.toList()[index]),
          ),
          body: ListView.builder(
            itemCount: usersInProvince.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () =>
                    Get.to(detailUserInProvinces(index, usersInProvince)),
                child: ListTile(
                  title: Text(usersInProvince[index].name),
                  subtitle: Text(usersInProvince[index].lastName),
                ),
              );
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
            onPressed: () => controller.delete(index),
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
        controller.addUser(result);
        // ignore: avoid_print
        print('result $result');
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
