class CalendarResponse {
  String? title;
  DateTime? startDate;
  DateTime? dueDate;
  String? detail;

  CalendarResponse({
    this.title,
    this.startDate,
    this.dueDate,
    this.detail,
  });

  List<CalendarResponse> getCalendarData() {
    return [
      CalendarResponse(
          title: 'Todo',
          startDate: DateTime.now(),
          dueDate: DateTime(2024, DateTime.september, 12))
    ];
  }
}
