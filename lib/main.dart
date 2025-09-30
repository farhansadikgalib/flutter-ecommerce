import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_value/shared_value.dart';

import 'app/core/binding/initial_binding.dart';
import 'app/services/notification/notification_service.dart';
import 'app/core/style/app_colors.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService().initialize();

  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 700),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.edgeToEdge,
          overlays: [SystemUiOverlay.bottom],
        );

        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        );

        return SharedValue.wrapApp(
          MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: const TextScaler.linear(1.0)),
            child: GetMaterialApp(
              title: "OusadBazar",
              debugShowCheckedModeBanner: false,
              initialRoute: AppPages.INITIAL,
              initialBinding: InitialBinding(),
              builder: EasyLoading.init(),
              theme: ThemeData(
                primaryColor: AppColors.primaryColor,
                useMaterial3: false,
                scaffoldBackgroundColor: Colors.white,
                iconTheme: const IconThemeData(color: Color(0xff037F84)),
                hintColor: const Color(0xff037F84),
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
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 2,
                    ),
                  ),
                  focusColor: AppColors.primaryColor,
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 2,
                    ),
                  ),
                  prefixIconColor: AppColors.primaryColor,
                  suffixIconColor: AppColors.primaryColor,
                  labelStyle: TextStyle(color: AppColors.primaryColor),
                  floatingLabelStyle: TextStyle(color: AppColors.primaryColor),
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
          ),
        );
      },
    ),
  );
}
