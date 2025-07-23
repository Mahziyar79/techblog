import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tech_blog/constant/colors.dart';
import 'package:tech_blog/view/splash_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: SolidColors.statusBarColor,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: Locale('fa'),

      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'iranSans',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            textStyle: WidgetStateProperty.resolveWith((state) {
              if (state.contains(WidgetState.pressed)) {
                return TextStyle(fontFamily: 'iranSans', fontSize: 16);
              }
              return TextStyle(fontFamily: 'iranSans', fontSize: 14);
            }),
            backgroundColor: WidgetStateProperty.resolveWith((state) {
              if (state.contains(WidgetState.pressed)) {
                return SolidColors.primaryColor;
              }
              return SolidColors.primaryColor;
            }),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
        textTheme: TextTheme(
          headlineSmall: TextStyle(fontSize: 13, color: SolidColors.blackColor),
          headlineMedium: TextStyle(fontSize: 14, color: SolidColors.greyColor),
          headlineLarge: TextStyle(
            fontSize: 16,
            color: SolidColors.posterTitle,
          ),
          bodySmall: TextStyle(fontSize: 13, color: SolidColors.blackColor),
          bodyMedium: TextStyle(fontSize: 13, color: SolidColors.colorTitle),
          bodyLarge: TextStyle(fontSize: 13, color: SolidColors.primaryColor),
          labelSmall: TextStyle(
            fontSize: 13,
            color: SolidColors.posterSubTitle,
          ),
          labelMedium: TextStyle(
            fontSize: 14,
            color: SolidColors.posterSubTitle,
          ),
          labelLarge: TextStyle(fontSize: 14, color: SolidColors.blackColor),
        ),
      ),
      debugShowCheckedModeBanner: false,

      // home: SingleArticle(),
      home: SplashScreen(),
    );
  }
}
