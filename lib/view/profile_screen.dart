import 'package:flutter/material.dart';
import 'package:tech_blog/components/divider.dart';
import 'package:tech_blog/constant/colors.dart';
import 'package:tech_blog/constant/strings.dart';
import 'package:tech_blog/gen/assets.gen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
        child: Column(
          children: [
            Image(image: Assets.icons.avatar.provider(), height: 100),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageIcon(
                  Assets.icons.pencil.provider(),
                  color: SolidColors.colorTitle,
                  size: 16,
                ),
                SizedBox(width: 8),
                Text(Strings.imageProfileEdit, style: textTheme.bodyMedium),
              ],
            ),
            SizedBox(height: 40),
            Text('فاطمه امیری', style: textTheme.bodyLarge),
            SizedBox(height: 4),
            Text('fatemeamiri@gmail.com'),
            SizedBox(height: 30),
            TechDivider(endIndent: size.width / 6, indent: size.width / 6),
            InkWell(
              onTap: () {},
              child: SizedBox(
                height: 40,
                width: size.width / 1.5,
                child: Center(
                  child: Text(
                    Strings.myFavBlog,
                    style: textTheme.headlineSmall,
                  ),
                ),
              ),
            ),
            TechDivider(endIndent: size.width / 6, indent: size.width / 6),
            InkWell(
              onTap: () {},
              child: SizedBox(
                height: 40,
                width: size.width / 1.5,
                child: Center(
                  child: Text(
                    Strings.myFavPodcast,
                    style: textTheme.headlineSmall,
                  ),
                ),
              ),
            ),
            TechDivider(endIndent: size.width / 6, indent: size.width / 6),
            InkWell(
              onTap: () {},
              child: SizedBox(
                height: 40,
                width: size.width / 1.5,
                child: Center(
                  child: Text(Strings.logOut, style: textTheme.headlineSmall),
                ),
              ),
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
