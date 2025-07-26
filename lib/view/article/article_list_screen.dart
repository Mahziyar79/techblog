import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_blog/components/app_bar_list.dart';
import 'package:tech_blog/components/custom_image.dart';
import 'package:tech_blog/components/loading.dart';
import 'package:tech_blog/constant/colors.dart';
import 'package:tech_blog/controller/article/article_list_screen_controller.dart';
import 'package:tech_blog/controller/article/single_article_controller.dart';
import 'package:tech_blog/route_manager/names.dart';

class ArticleListScreen extends StatelessWidget {
  final String? title;
  ArticleListScreen({super.key, required this.title});

  final ArticleListScreenController articleListScreenController = Get.put(
    ArticleListScreenController(),
  );

  final singleArticleController = Get.find<SingleArticleController>();
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: SolidColors.scaffoldBg,
        appBar: appBarList(title!),
        body: Obx(
          () => !articleListScreenController.loading.value
              ? ListView.builder(
                  itemCount: articleListScreenController.articleList.length,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        singleArticleController.getArticleInfo(
                          articleListScreenController.articleList[index].id!,
                        );
                        Get.toNamed(NamedRoute.routeSingleArticle);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                        child: Row(
                          children: [
                            SizedBox(
                              width: size.width / 3,
                              height: size.height / 6,
                              child: CustomImage(
                                imageUrl: articleListScreenController
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
                                    articleListScreenController
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
                                        articleListScreenController
                                            .articleList[index]
                                            .author!,
                                        style: TextStyle(
                                          color: SolidColors.hintText,
                                        ),
                                      ),
                                      Text(
                                        '${articleListScreenController.articleList[index].view!} بازدید',
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
              : Loading(),
        ),
      ),
    );
  }
}
