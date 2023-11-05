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
              return InkWell(
                onTap: () => Get.to(detail(index)),
                child: ListTile(
                    title: Text(
                      controller.userList[index].name,
                    ),
                    subtitle: Text(controller.userList[index].lastName),
                    trailing: InkWell(
                      onTap: () => controller.delete(index),
                      child: const Icon(Icons.delete),
                    )),
              );
            }))));
  }

  Widget detail(int indexList) {
    return Obx(() => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(controller.userList[indexList].name),
                  ],
                ),
                Row(
                  children: [Text(controller.userList[indexList].lastName)],
                )
              ],
            ),
          ),
        ));
  }

  Widget secound() {
    return const Scaffold(
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
