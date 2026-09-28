import 'package:get/get.dart';
import 'package:buddhadev/app/modules/contact/views/contact_screen.dart';
import 'package:buddhadev/app/modules/home/bindings/home_binding.dart';
import 'package:buddhadev/app/modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = _Paths.home;
  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: _Paths.contact,
      page: () => ContactView(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 400),
    ),
  ];
}
