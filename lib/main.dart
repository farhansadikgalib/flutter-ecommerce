import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_value/shared_value.dart';

import 'app/core/binding/initial_binding.dart';
import 'app/core/config/app_config.dart';
import 'app/core/style/app_colors.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  runApp(ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
            overlays: [SystemUiOverlay.bottom]);

        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark));

        return SharedValue.wrapApp(
          GetMaterialApp(
            title: "Turi",
            debugShowCheckedModeBanner: false,
            initialRoute: AppPages.INITIAL,
            initialBinding: InitialBinding(),
            builder: EasyLoading.init(),
            theme: ThemeData(
              primaryColor: AppColors.primaryColor,
              useMaterial3: false,
              scaffoldBackgroundColor: Colors.white,
              textTheme: GoogleFonts.robotoTextTheme(
                Theme.of(context).textTheme,
              ),
              inputDecorationTheme: const InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide:
                  BorderSide(color: AppColors.primaryColor, width: 2),
                ),
                focusColor: AppColors.primaryColor,
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide:
                  BorderSide(color: AppColors.primaryColor, width: 2),
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ),
            defaultTransition: Transition.fadeIn,
            getPages: AppPages.routes,
            enableLog: kDebugMode,
          ),
        );
      }));
}
