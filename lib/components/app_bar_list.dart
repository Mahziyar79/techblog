import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_blog/constant/colors.dart';
import 'package:tech_blog/constant/text_style.dart';

PreferredSize appBarList(String title) {
  return PreferredSize(
    preferredSize: Size.fromHeight(70),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
      child: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: SolidColors.scaffoldBg,
        actions: [Text(title, style: appBarTextStyle)],
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            decoration: BoxDecoration(
              color: SolidColors.primaryColor,
              shape: BoxShape.circle,
            ),

            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.keyboard_arrow_right_rounded,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
