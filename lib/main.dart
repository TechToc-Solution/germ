import 'package:GermAc/core/router/app_router.dart';
import 'package:GermAc/core/services/shared_preference_manager.dart';
import 'package:GermAc/core/theme/palette.dart';
import 'package:GermAc/firebase_options.dart';
import 'package:GermAc/pages/home_page.dart';
import 'package:GermAc/providers/auth_provider.dart';
import 'package:GermAc/providers/courses_provider.dart';
import 'package:GermAc/providers/home_provider.dart';
import 'package:GermAc/providers/sections_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_context/one_context.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';

import 'core/helper/cache_helper.dart';
import 'core/notifications_services/notifications_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPreferenceManager().read();
  //await CacheHelper.init();
  //await FirebaseApi().initNotifications();

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/local',
        fallbackLocale: const Locale('en'),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
            ChangeNotifierProvider<CoursesProvider>(
                create: (_) => CoursesProvider()),
            ChangeNotifierProvider<SectionProvider>(
                create: (_) => SectionProvider()),
            ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
          ],
          child: MaterialApp(
            builder: OneContext().builder,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: theme,
            debugShowCheckedModeBanner: false,
            title: 'GermAc',
            initialRoute: HomePage.id,
            onGenerateRoute: _appRouter.onGenerateRouter,
          ),
        );
      },
      designSize: const Size(960, 1600),
    );
  }
}
