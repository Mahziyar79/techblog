import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tech_blog/components/app_bar_list.dart';
import 'package:tech_blog/components/custom_image.dart';
import 'package:tech_blog/components/loading.dart';
import 'package:tech_blog/constant/colors.dart';
import 'package:tech_blog/constant/strings.dart';
import 'package:tech_blog/controller/article/manage_article_controller.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/route_manager/names.dart';

class ManageArticle extends StatelessWidget {
  ManageArticle({super.key});

  final manageArticleController = Get.find<ManageArticleController>();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: SolidColors.scaffoldBg,
        appBar: appBarList('مدیریت مقاله ها'),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Get.toNamed(NamedRoute.singleManageArticle);
            },
            child: Text(
              Strings.textManageArticle,
              style: TextStyle(color: SolidColors.lightText),
            ),
          ),
        ),
        body: Obx(
          () => !manageArticleController.loading.value
              ? manageArticleController.articleList.isNotEmpty
                    ? ListView.builder(
                        itemCount: manageArticleController.articleList.length,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                12,
                                10,
                                12,
                                10,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: size.width / 3,
                                    height: size.height / 6,
                                    child: CustomImage(
                                      imageUrl: manageArticleController
                                          .articleList[index]
                                          .image!,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.5,
                                        child: Text(
                                          manageArticleController
                                              .articleList[index]
                                              .title!,
                                          style: textTheme.labelLarge,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      SizedBox(
                                        width: size.width * 0.5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              manageArticleController
                                                  .articleList[index]
                                                  .author!,
                                              style: TextStyle(
                                                color: SolidColors.hintText,
                                              ),
                                            ),
                                            Text(
                                              '${manageArticleController.articleList[index].view!} بازدید',
                                              style: TextStyle(
                                                color: SolidColors.hintText,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      )
                    : articleEmpty(textTheme)
              : Loading(),
        ),
      ),
    );
  }

  Widget articleEmpty(TextTheme textTheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.images.techbotSad.path, height: 100),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: RichText(
              text: TextSpan(
                text: Strings.articleEmpty,
                style: textTheme.headlineSmall,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
