import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_controller.dart';
import 'package:getx_mvvm_boilerplate/models/calendar_response.dart';
import 'package:getx_mvvm_boilerplate/models/flowy_calendar.dart';

class CalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CalendarVM>(
      () => CalendarVM(),
    );
  }
}

class CalendarVM extends BaseController {
  RxList<CalendarResponse> mockData = <CalendarResponse>[].obs;

  final Rx<AppCalendarDataSource> calendarDataSource =
      AppCalendarDataSource([]).obs;

  init() {
    mockData.value = CalendarResponse().getCalendarData();
    print(mockData.value);
  }
}
