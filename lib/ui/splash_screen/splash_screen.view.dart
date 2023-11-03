import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/ui/splash_screen/splash_screen.vm.dart';

import '../../application/base/base_view.dart';
import '../_style/text_styles.dart';

class SplashScreenView extends BaseView<SplashScreenController> {
  @override
  Widget render(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: InkWell(
              onTap: () {
                controller.setString('ffe');
                
              },
              child: Text('test', style: TextStyles(context).textLargeBold)),
          ),
          Obx(() => Text(controller.str.string,style: TextStyles(context).textLargeBold))
        ],
      ),
    );
  }
}
