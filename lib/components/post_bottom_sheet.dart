import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tech_blog/constant/strings.dart';
import 'package:tech_blog/gen/assets.gen.dart';

class PostBottomSheet extends StatelessWidget {
  const PostBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 2.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(Assets.images.techbot.path, height: 50),
                SizedBox(width: 16),
                Text(
                  Strings.shareKnowledge,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              Strings.gigTech,
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(Assets.icons.postBlog.path, height: 30),
                    SizedBox(width: 8),
                    Text(
                      Strings.titleAppBarManageArticle,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(Assets.icons.postPodcast.path, height: 30),
                    SizedBox(width: 8),
                    Text(
                      Strings.managePodcast,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
