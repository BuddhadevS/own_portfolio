import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:buddhadev/core/services/injector.dart';
import 'package:buddhadev/routes/app_pages.dart';
import 'package:buddhadev/shared/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyPortfolio());
}

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      title: "Buddhadev Sahu | Portfolio",
      getPages: AppPages.routes,
      defaultTransition: Transition.rightToLeftWithFade,
      darkTheme: AppTheme.lightTheme,
      theme: AppTheme.lightTheme,
      locale: const Locale("en", "US"),
      fallbackLocale: const Locale("en", "US"),
    );
  }
}
