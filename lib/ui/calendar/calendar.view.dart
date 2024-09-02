import 'package:flutter/material.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_view.dart';
import 'package:getx_mvvm_boilerplate/ui/calendar/calendar.vm.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarAppView extends BaseView<CalendarVM> {
  @override
  Widget render(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SfCalendar(
              // dataSource: controller.calendarDataSource.value,
              onTap: (CalendarTapDetails detail) {},
              onViewChanged: (detail) {},
              showNavigationArrow: true,
              showDatePickerButton: true,
              viewHeaderHeight: 40,
              view: CalendarView.month,
              headerStyle: CalendarHeaderStyle(
                  // backgroundColor: ThemeData().background(),
                  ),
              viewHeaderStyle: ViewHeaderStyle(
                  // backgroundColor: ThemeData().primary().withOpacity(0.3),
                  // dayTextStyle: context?.textSmallBold.copyWith(
                  //   color: ThemeData().primary(),
                  // ),
                  ),
              monthViewSettings: MonthViewSettings(
                monthCellStyle: MonthCellStyle(
                  leadingDatesBackgroundColor: Colors.red,
                  trailingDatesBackgroundColor: Colors.blue,
                ),
                appointmentDisplayCount: 3,
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
