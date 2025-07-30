import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tech_blog/constant/colors.dart';
import 'package:tech_blog/my_http_overrides.dart';
import 'package:tech_blog/route_manager/binding.dart';
import 'package:tech_blog/route_manager/names.dart';
import 'package:tech_blog/view/article/manage_article.dart';
import 'package:tech_blog/view/article/single_article.dart';
import 'package:tech_blog/view/article/single_manage_article.dart';
import 'package:tech_blog/view/main_screen/main_screen.dart';
import 'package:tech_blog/view/splash_screen.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: SolidColors.statusBarColor,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: Locale('fa'),
      title: 'Flutter Demo',
      theme: lightTheme(),
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: NamedRoute.routeMainScreen,
          page: () => MainScreen(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: NamedRoute.routeSingleArticle,
          page: () => SingleArticle(),
          binding: ArticleBinding(),
        ),
         GetPage(
          name: NamedRoute.manageArticle,
          page: () => ManageArticle(),
          binding: ArticleManagerBinding(),
        ),
        GetPage(
          name: NamedRoute.singleManageArticle,
          page: () => SingleManageArticle(),
          binding: ArticleManagerBinding(),
        ),
      ],
      home: SplashScreen(),
    );
  }

  ThemeData lightTheme() {
    return ThemeData(
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
        headlineLarge: TextStyle(fontSize: 16, color: SolidColors.posterTitle),
        bodySmall: TextStyle(fontSize: 13, color: SolidColors.blackColor),
        bodyMedium: TextStyle(fontSize: 13, color: SolidColors.colorTitle),
        bodyLarge: TextStyle(fontSize: 13, color: SolidColors.primaryColor),
        labelSmall: TextStyle(fontSize: 13, color: SolidColors.posterSubTitle),
        labelMedium: TextStyle(fontSize: 14, color: SolidColors.posterSubTitle),
        labelLarge: TextStyle(fontSize: 14, color: SolidColors.blackColor),
      ),
    );
  }
}
