import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tech_blog/components/loading.dart';
import 'package:tech_blog/constant/colors.dart';
import 'package:tech_blog/constant/strings.dart';
import 'package:tech_blog/controller/article/article_list_screen_controller.dart';
import 'package:tech_blog/controller/article/single_article_controller.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/view/article/article_list_screen.dart';

class SingleArticle extends StatelessWidget {
  SingleArticle({super.key});
  final singleArticleController = Get.find<SingleArticleController>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: SolidColors.scaffoldBg,
        body: SingleChildScrollView(
          child: Obx(
            () => singleArticleController.loading.value
                ? SizedBox(height: size.height, child: Loading())
                : Column(
                    children: [
                      Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: singleArticleController
                                .articleInfoModel
                                .value
                                .image!,
                            imageBuilder: (context, imageProvider) {
                              return Image(image: imageProvider);
                            },
                            placeholder: (context, url) => SpinKitFadingCube(
                              color: SolidColors.primaryColor,
                              size: 32.0,
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              Assets.images.singlePlaceHolder.path,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: GradientColors.singleAppbarGradiant,
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(width: 20),
                                  InkWell(
                                    onTap: () => Get.back(),
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                  Expanded(child: SizedBox()),
                                  Icon(
                                    Icons.bookmark_border_outlined,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  SizedBox(width: 16),
                                  Icon(
                                    Icons.share,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  SizedBox(width: 20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                singleArticleController
                                    .articleInfoModel
                                    .value
                                    .title!,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Image(
                                    image: Image.asset(
                                      Assets.icons.avatar.path,
                                    ).image,
                                    width: 32,
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    singleArticleController
                                        .articleInfoModel
                                        .value
                                        .author!,
                                    style: textTheme.headlineSmall,
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    singleArticleController
                                        .articleInfoModel
                                        .value
                                        .createdAt!,
                                    style: textTheme.headlineSmall,
                                  ),
                                ],
                              ),
                              SizedBox(height: 24),
                              HtmlWidget(
                                singleArticleController
                                    .articleInfoModel
                                    .value
                                    .content!,
                                enableCaching: true,
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                                onLoadingBuilder:
                                    (context, element, loadingProgress) =>
                                        Loading(),
                              ),
                              SizedBox(height: 24),
                              tags(),
                              SizedBox(height: 24),
                              Row(
                                children: [
                                  Text(
                                    Strings.relatedArticle,
                                    style: textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              similarBlogs(size, textTheme),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  SizedBox tags() {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        itemCount: singleArticleController.tagList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              var tagId = singleArticleController.tagList[index].id!;
              var tagName = singleArticleController.tagList[index].title!;
              await Get.find<ArticleListScreenController>()
                  .getArticleListWithTagsId(tagId);
              Get.to(() => ArticleListScreen(title: tagName));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(24),
              ),
              alignment: Alignment.center,
              child: Text(
                singleArticleController.tagList[index].title!,
                style: TextStyle(color: Colors.black),
              ),
            ),
          );
        },
      ),
    );
  }

  SizedBox similarBlogs(Size size, TextTheme textTheme) {
    return SizedBox(
      height: size.height / 3.5,
      child: ListView.builder(
        itemCount: singleArticleController.relatedList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: () {
              singleArticleController.getArticleInfo(
                singleArticleController.relatedList[index].id!,
              );
            },
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: size.width / 2.2,
                        height: size.height / 5.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: NetworkImage(
                              singleArticleController.relatedList[index].image!,
                            ),

                            fit: BoxFit.cover,
                          ),
                        ),
                        foregroundDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: GradientColors.blogPost,
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 0,
                        left: 0,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  singleArticleController
                                      .relatedList[index]
                                      .author!,
                                  style: textTheme.labelSmall,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      singleArticleController
                                          .relatedList[index]
                                          .view!,
                                      style: textTheme.labelSmall,
                                    ),
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.remove_red_eye_sharp,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  SizedBox(
                    width: size.width / 2.2,
                    child: Text(
                      singleArticleController.relatedList[index].title!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.headlineSmall,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
