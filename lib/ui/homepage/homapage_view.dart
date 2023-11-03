import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_view.dart';
import 'package:getx_mvvm_boilerplate/ui/AddData/AddData_view.dart';
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
              return ListTile(
                  title: Text(
                    controller.userList[index].name,
                  ),
                  subtitle: Text(controller.userList[index].lastName));
            }))));
  }

  Widget secound() {
    return Scaffold(
      body: Center(
        child: Text('data'),
      ),
    );
  }

  Widget clickCreate() {
    return FloatingActionButton(
      onPressed: (() async {
        Map<String, dynamic> result = await Get.to(
          () => AddDataView(),
        );
        controller.addUser(result);
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
