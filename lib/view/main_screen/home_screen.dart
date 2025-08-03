import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_blog/components/custom_image.dart';
import 'package:tech_blog/components/loading.dart';
import 'package:tech_blog/components/main_tags.dart';
import 'package:tech_blog/components/see_more.dart';
import 'package:tech_blog/constant/colors.dart';
import 'package:tech_blog/constant/strings.dart';
import 'package:tech_blog/controller/article/article_list_screen_controller.dart';
import 'package:tech_blog/controller/article/single_article_controller.dart';
import 'package:tech_blog/controller/home_screen_controller.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/route_manager/names.dart';
import 'package:tech_blog/view/article/article_list_screen.dart';
import 'package:tech_blog/view/podcast/podcast_list_screen.dart';

class HomeScreen extends StatelessWidget {
  final Size size;
  final TextTheme textTheme;
  final double bodyMargin;

  HomeScreen({
    super.key,
    required this.size,
    required this.textTheme,
    required this.bodyMargin,
  });

  final homeScreenController = Get.find<HomeScreenController>();
  final singleArticleController = Get.find<SingleArticleController>();
  final articleListScreenController = Get.find<ArticleListScreenController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
          child: homeScreenController.loading.value == false
              ? Column(
                  children: [
                    // poster
                    homePagePoster(),

                    SizedBox(height: 12),
                    // hashtag
                    homePageTagList(),

                    SizedBox(height: 24),

                    // see more blog
                    GestureDetector(
                      onTap: () {
                        Get.to(() => ArticleListScreen(title: 'همه مقالات'));
                      },
                      child: SeeMore(
                        bodyMargin: bodyMargin,
                        title: Strings.viewHotestBlog,
                      ),
                    ),

                    SizedBox(height: 12),

                    // blog list
                    homePageBlogList(),
                    SizedBox(height: 12),
                    // see more blog
                    GestureDetector(
                      onTap: () {
                        Get.to(() => PodcastListScreen(title: 'همه پادکست ها'));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: bodyMargin),
                        child: Row(
                          children: [
                            ImageIcon(
                              Assets.icons.microphone.provider(),
                              color: SolidColors.colorTitle,
                            ),
                            SizedBox(width: 8),
                            Text(
                              Strings.viewHotestPodCasts,
                              style: textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 12),

                    // podcast list
                    homePagePodcastList(),

                    SizedBox(height: 60),
                  ],
                )
              : SizedBox(
                  height: Get.height / 2,
                  child: Center(child: Loading()),
                ),
        ),
      ),
    );
  }

  Widget homePageBlogList() {
    return SizedBox(
      height: size.height / 3.5,
      child: ListView.builder(
        itemCount: homeScreenController.topVisitedList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: () {
              singleArticleController.getArticleInfo(
                homeScreenController.topVisitedList[index].id!,
              );
              Get.toNamed(NamedRoute.routeSingleArticle);
            },
            child: Padding(
              padding: EdgeInsets.only(
                right: index == 0 ? bodyMargin : 0,
                left: 16,
              ),
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
                              homeScreenController.topVisitedList[index].image!,
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
                                  homeScreenController
                                      .topVisitedList[index]
                                      .author!,
                                  style: textTheme.labelSmall,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      homeScreenController
                                          .topVisitedList[index]
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
                      homeScreenController.topVisitedList[index].title!,
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

  Widget homePagePodcastList() {
    return SizedBox(
      height: size.height / 4,
      child: ListView.builder(
        itemCount: homeScreenController.topPodcasts.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(
                NamedRoute.singlePodcast,
                arguments: homeScreenController.topPodcasts[index],
              );
            },
            child: Padding(
              padding: EdgeInsets.only(
                right: index == 0 ? bodyMargin : 0,
                left: 16,
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: size.width / 2.2,
                    height: size.height / 4.8,
                    child: CustomImage(
                      imageUrl: homeScreenController.topPodcasts[index].poster!,
                    ),
                  ),
                  SizedBox(height: 6),
                  SizedBox(
                    width: size.width / 2.2,
                    child: Center(
                      child: Text(
                        homeScreenController.topPodcasts[index].title!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.headlineSmall,
                      ),
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

  Widget homePagePoster() {
    return GestureDetector(
      onTap: () {
        singleArticleController.getArticleInfo(
          homeScreenController.poster.value.id!,
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height / 4,
              foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: GradientColors.homePosterCoverGradiant,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: CustomImage(
                imageUrl: homeScreenController.poster.value.image!,
              ),
            ),
            Positioned(
              bottom: 16,
              right: 8,
              left: 0,
              child: Column(
                children: [
                  Text(
                    homeScreenController.poster.value.title!,
                    style: textTheme.headlineLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget homePageTagList() {
    return SizedBox(
      height: 52,
      child: ListView.builder(
        itemCount: homeScreenController.tagsList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: () async {
              var tagId = homeScreenController.tagsList[index].id!;
              var catname = homeScreenController.tagsList[index].title!;
              await articleListScreenController.getArticleListWithCatId(tagId);
              Get.to(() => ArticleListScreen(title: catname));
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                8,
                8,
                index == 0 ? bodyMargin : 4,
                8,
              ),
              child: MainTags(
                index: index,
                title: homeScreenController.tagsList[index].title!,
              ),
            ),
          );
        }),
      ),
    );
  }
}
