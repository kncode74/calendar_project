
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_controller.dart';
import 'package:getx_mvvm_boilerplate/application/life_circle.dart';

abstract class BaseView<Controller extends BaseController>

    extends GetView<Controller> implements LifeCycleListener{

  Widget render(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return render(context);
  }

  Widget showMessageDialog(String message) {
    return Container();
  }

  void onInit() {}

  @override
  void onBuild() {}

  @override
  void onDispose() {}

  @override
  void onResume() {}

  @override
  void onPause() {}

  @override
  void onInactive() {}

  @override
  void onDetach() {}
  Widget loading() {
    return Container();
  }


}
