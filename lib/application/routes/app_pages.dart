import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/ui/calendar/calendar.view.dart';
import 'package:getx_mvvm_boilerplate/ui/calendar/calendar.vm.dart';
import 'package:getx_mvvm_boilerplate/ui/splash_screen/splash_screen.view.dart';
import 'package:getx_mvvm_boilerplate/ui/splash_screen/splash_screen.vm.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.calendar;

  static final routes = [
    GetPage(
        name: _Paths.splashScreen,
        page: () => SplashScreenView(),
        binding: SplashScreenBinding()),
    GetPage(
        name: _Paths.calendar,
        page: () => CalendarAppView(),
        binding: CalendarBinding()),
  ];
}
