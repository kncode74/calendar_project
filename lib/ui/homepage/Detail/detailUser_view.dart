import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/ui/homepage/homepage_vm.dart';

class DetailUserView extends StatelessWidget {
  const DetailUserView({super.key});

  @override
  Widget build(BuildContext context) {
    User received = Get.arguments['user'] as User;
    final name = received.name.toString();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Row(
          children: [
            Text('name : $name'),
          ],
        ),
      ),
    );
  }
}
