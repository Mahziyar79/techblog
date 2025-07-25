import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tech_blog/components/custom_launch_url.dart';
import 'package:tech_blog/components/divider.dart';
import 'package:tech_blog/constant/colors.dart';
import 'package:tech_blog/constant/strings.dart';
import 'package:tech_blog/controller/register/register_controller.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/view/main_screen/home_screen.dart';
import 'package:tech_blog/view/main_screen/profile_screen.dart';

class MainScreen extends StatelessWidget {
  final RxInt selectedPageIndex = 0.obs;
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  MainScreen({super.key});

  changeScreen(int value) {
    selectedPageIndex.value = value;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double bodyMargin = size.width / 10;
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        key: _drawerKey,
        drawer: Drawer(
          backgroundColor: SolidColors.scaffoldBg,
          child: Padding(
            padding: EdgeInsets.only(right: bodyMargin, left: bodyMargin),
            child: ListView(
              children: [
                DrawerHeader(
                  child: Center(
                    child: Image.asset(Assets.images.drawerLogo.path, scale: 3),
                  ),
                ),
                ListTile(
                  title: Text('پروفایل کاربری', style: textTheme.labelLarge),
                  onTap: () {},
                ),
                TechDivider(endIndent: 0, indent: 0),
                ListTile(
                  title: Text('درباره تک‌بلاگ', style: textTheme.labelLarge),
                  onTap: () {},
                ),
                TechDivider(endIndent: 0, indent: 0),
                ListTile(
                  title: Text(
                    'اشتراک گذاری تک بلاگ',
                    style: textTheme.labelLarge,
                  ),
                  onTap: () async {
                    await SharePlus.instance.share(
                      ShareParams(text: Strings.shareText),
                    );
                  },
                ),
                TechDivider(endIndent: 0, indent: 0),
                ListTile(
                  title: Text(
                    'تک‌بلاگ در گیت هاب ',
                    style: textTheme.labelLarge,
                  ),
                  onTap: () {
                    customLaunchUrl(Strings.techBlogGithubUrl);
                  },
                ),
                TechDivider(endIndent: 0, indent: 0),
              ],
            ),
          ),
        ),
        backgroundColor: SolidColors.scaffoldBg,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: SolidColors.scaffoldBg,
          title: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                InkWell(
                  onTap: () {
                    _drawerKey.currentState!.openDrawer();
                  },
                  child: Icon(Icons.menu),
                ),
                Assets.images.mainLogo.image(height: size.height / 13.6),
                Icon(Icons.search),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Obx(
                () => IndexedStack(
                  index: selectedPageIndex.value,
                  children: [
                    HomeScreen(
                      size: size,
                      textTheme: textTheme,
                      bodyMargin: bodyMargin,
                    ),
                    ProfileScreen(),
                  ],
                ),
              ),
            ),
            BottomNavigation(
              size: size,
              bodyMargin: bodyMargin,
              changeScreen: changeScreen,
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  BottomNavigation({
    super.key,
    required this.size,
    required this.bodyMargin,
    required this.changeScreen,
  });

  final Size size;
  final double bodyMargin;
  final Function(int) changeScreen;

  final RegisterController _registerController = RegisterController();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        height: size.height / 11,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: GradientColors.bottomNavBackground,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            right: bodyMargin,
            left: bodyMargin,
            bottom: 8,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              gradient: LinearGradient(colors: GradientColors.bottomNav),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    changeScreen(0);
                  },
                  icon: ImageIcon(
                    size: 20,
                    Assets.icons.home.provider(),
                    color: SolidColors.lightIcon,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _registerController.toggleLogin();
                  },
                  icon: ImageIcon(
                    size: 20,
                    Assets.icons.newPost.provider(),
                    color: SolidColors.lightIcon,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    changeScreen(1);
                  },
                  icon: ImageIcon(
                    size: 20,
                    Assets.icons.user.provider(),
                    color: SolidColors.lightIcon,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
