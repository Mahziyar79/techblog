import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tech_blog/components/loading.dart';
import 'package:tech_blog/components/see_more.dart';
import 'package:tech_blog/constant/colors.dart';
import 'package:tech_blog/constant/dimens.dart';
import 'package:tech_blog/constant/strings.dart';
import 'package:tech_blog/controller/article/article_content_editor.dart';
import 'package:tech_blog/controller/article/manage_article_controller.dart';
import 'package:tech_blog/controller/file_controller.dart';
import 'package:tech_blog/controller/home_screen_controller.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/services/pick_file.dart';

class SingleManageArticle extends StatelessWidget {
  SingleManageArticle({super.key});
  final manageArticleController = Get.find<ManageArticleController>();
  final homeScreenController = Get.find<HomeScreenController>();
  final FileController _fileController = Get.put(FileController());

  getTitle() {
    Get.defaultDialog(
      title: Strings.titleDialogSingleManageArticle,
      titleStyle: TextStyle(color: SolidColors.scaffoldBg),
      backgroundColor: SolidColors.primaryColor,
      radius: 8,
      content: TextField(
        controller: manageArticleController.titleTextEditingController,
        keyboardType: TextInputType.text,
        style: TextStyle(color: SolidColors.blackColor),
        decoration: InputDecoration(
          hintText: 'عنوان مقاله',
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
      confirm: ElevatedButton(
        onPressed: () {
          manageArticleController.updateTitle();
          Get.back();
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((state) {
            return SolidColors.scaffoldBg;
          }),
        ),
        child: Text('ثبت'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: SolidColors.scaffoldBg,
        body: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: Get.width,
                      height: Get.height / 3,
                      child: _fileController.file.value.name == 'nothing'
                          ? CachedNetworkImage(
                              imageUrl: manageArticleController
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
                                fit: BoxFit.cover,
                              ),
                            )
                          : Image.file(
                              File(_fileController.file.value.path!),
                              fit: BoxFit.cover,
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
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            pickFile();
                          },
                          child: Container(
                            height: 40,
                            width: Get.width / 2.8,
                            decoration: BoxDecoration(
                              color: SolidColors.primaryColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  Strings.selectImage,
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(Icons.add, color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: size.width,
                  child: Padding(
                    padding: EdgeInsets.all(Dimens.halfBodyMargin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            getTitle();
                          },
                          child: SeeMore(
                            bodyMargin: 0,
                            title: Strings.editTitleArticle,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          manageArticleController.articleInfoModel.value.title!,
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),

                        SizedBox(height: 24),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => ArticleContentEditor());
                          },
                          child: SeeMore(
                            bodyMargin: 0,
                            title: Strings.editMainTextArticle,
                          ),
                        ),
                        SizedBox(height: 12),
                        HtmlWidget(
                          manageArticleController
                              .articleInfoModel
                              .value
                              .content!,
                          enableCaching: true,
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          onLoadingBuilder:
                              (context, element, loadingProgress) => Loading(),
                        ),
                        SizedBox(height: 24),
                        GestureDetector(
                          onTap: () {
                            chooseCatsBottomSheet(textTheme);
                          },
                          child: SeeMore(
                            bodyMargin: 0,
                            title: Strings.selectCategory,
                          ),
                        ),
                        SizedBox(height: 24),
                        Text(
                          manageArticleController
                                      .articleInfoModel
                                      .value
                                      .catName ==
                                  null
                              ? Strings.noCategorySelected
                              : manageArticleController
                                    .articleInfoModel
                                    .value
                                    .catName!,
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () async {
                            await manageArticleController.storeArticle();
                          },
                          child: Text(
                           manageArticleController.loading.value ? Strings.wait :  Strings.save,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
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

  SizedBox cats() {
    return SizedBox(
      height: Get.height / 1.8,
      child: GridView.builder(
        itemCount: homeScreenController.tagsList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              manageArticleController.articleInfoModel.update((val) {
                val!.catId = homeScreenController.tagsList[index].id;
                val.catName = homeScreenController.tagsList[index].title;
              });

              Get.back();
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: SolidColors.primaryColor,
                borderRadius: BorderRadius.circular(24),
              ),
              alignment: Alignment.center,
              child: Center(
                child: Text(
                  homeScreenController.tagsList[index].title!,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
      ),
    );
  }

  chooseCatsBottomSheet(TextTheme textTheme) {
    Get.bottomSheet(
      Container(
        height: Get.height / 1.5,
        width: Get.width,
        decoration: BoxDecoration(
          color: SolidColors.scaffoldBg,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(Strings.selectCategory),
              SizedBox(height: 16),
              cats(),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      persistent: true,
    );
  }
}
