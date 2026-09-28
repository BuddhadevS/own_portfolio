part of 'app_pages.dart';

abstract class AppRoutes {
  static const home = _Paths.home;
  static const contact = _Paths.contact;
  AppRoutes._();
}

abstract class _Paths {
  static const home = '/home';
  static const contact = '/contact';

  _Paths._();
}
