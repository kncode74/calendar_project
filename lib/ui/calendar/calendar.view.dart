import 'package:flutter/material.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_view.dart';
import 'package:getx_mvvm_boilerplate/ui/_style/text_styles.dart';
import 'package:getx_mvvm_boilerplate/ui/calendar/calendar.vm.dart';

class CalendarView extends BaseView<CalendarVM> {
  @override
  Widget render(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: Stack(
        children: [
          Center(
            child: Text('test', style: TextStyles(context).textLargeBold),
          ),
        ],
      ),
    );
  }
}
