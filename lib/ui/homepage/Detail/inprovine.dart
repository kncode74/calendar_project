import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/ui/homepage/homepage_vm.dart';

class Inprovince extends StatelessWidget {
  const Inprovince({super.key});

  @override
  Widget build(BuildContext context) {
    User received = Get.arguments['user'] as User;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(received.name),
      ),
    );
  }
}
