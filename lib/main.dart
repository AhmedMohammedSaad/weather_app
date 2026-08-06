import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'core/router/app_router.dart';
import 'core/router/routes.dart';
import 'core/services/service_locator/service_locator.dart';
import 'core/theme/app_colors.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Preserve native splash screen until initialization completes
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 1. Initialize local cache storage (SharedPreferences via nb_utils)
  await initialize();

  // 2. Initialize Dependency Injection Service Locator (GetIt)
  ServiceLocator.init();

  // 3. Initialize EasyLocalization
  await EasyLocalization.ensureInitialized();

  // Remove splash screen cleanly after initialization
  FlutterNativeSplash.remove();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: WeatherApp(appRouter: AppRouter()),
    ),
  );
}

class WeatherApp extends StatelessWidget {
  final AppRouter appRouter;

  const WeatherApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Weather App',
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: AppColors.primary,
            scaffoldBackgroundColor: AppColors.background,
            useMaterial3: true,
          ),
          onGenerateRoute: appRouter.generateRoute,
          initialRoute: Routes.weatherView,
        );
      },
    );
  }
}
