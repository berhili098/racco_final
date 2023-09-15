import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:racco_final/app/data/services.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';
import 'models/palette.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initOneSignal();
  await handlerPermission();
  String? main;  
  main = await initRoute();
  runApp(
    ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Palette.kToDark,
                scaffoldBackgroundColor: Palette.bgColor,
                useMaterial3: true,
                fontFamily: GoogleFonts.lato().fontFamily,
                buttonTheme: const ButtonThemeData(
                  buttonColor: Palette.kToDark,
                  textTheme: ButtonTextTheme.primary,
                )),
            title: "Racco-Mobile",
            initialRoute: main,
            getPages: AppPages.routes,
          );
        }),
  );
}
