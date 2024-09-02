import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppCalendarDataSource extends CalendarDataSource {
  AppCalendarDataSource(List<dynamic> document) {
    appointments = document;
  }
}
