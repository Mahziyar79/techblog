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
import 'package:tech_blog/controller/article/manage_article_controller.dart';
import 'package:tech_blog/controller/file_controller.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/services/pick_file.dart';

class SingleManageArticle extends StatelessWidget {
  SingleManageArticle({super.key});
  final manageArticleController = Get.find<ManageArticleController>();
  final FileController _fileController = Get.put(FileController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                        SeeMore(bodyMargin: 0, title: Strings.editTitleArticle),
                        SizedBox(height: 12),
                        Text(
                          manageArticleController.articleInfoModel.value.title!,
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),

                        SizedBox(height: 24),
                        SeeMore(
                          bodyMargin: 0,
                          title: Strings.editMainTextArticle,
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
                        SeeMore(bodyMargin: 0, title: Strings.selectCategory),
                        SizedBox(height: 24),
                        // tags(),
                        SizedBox(height: 24),
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
        itemCount: manageArticleController.tagList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {},
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(24),
              ),
              alignment: Alignment.center,
              child: Text(
                manageArticleController.tagList[index].title!,
                style: TextStyle(color: Colors.black),
              ),
            ),
          );
        },
      ),
    );
  }
}
