import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../view/auth/login_screen.dart';
import '../routes/routes.dart';
import '../theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1365.33),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          useInheritedMediaQuery: true,
          title: 'Shoe Garden',
          debugShowCheckedModeBanner: false,
          theme: TTheme.lightTheme,
          home: LoginScreen(),
          getPages: Routes.adminRoutes(),
        );
      },
    );
  }
}
