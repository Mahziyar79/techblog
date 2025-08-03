import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
import 'package:tech_blog/constant/colors.dart';
import 'package:tech_blog/constant/dimens.dart';
import 'package:tech_blog/controller/podcast/single_podcast_controller.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/models/podcast/podcast_model.dart';

class SinglePodcast extends StatelessWidget {
  late final SinglePodcastController controller;
  late final PodcastModel podcastModel;
  SinglePodcast() {
    podcastModel = Get.arguments;
    controller = Get.put(SinglePodcastController(id: podcastModel.id));
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: SolidColors.scaffoldBg,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: Get.height / 5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: Get.width,
                          height: Get.height / 3,
                          child: CachedNetworkImage(
                            imageUrl: podcastModel.poster!,
                            imageBuilder: (context, imageProvider) {
                              return Image(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              );
                            },
                            placeholder: (context, url) => SpinKitFadingCube(
                              color: SolidColors.primaryColor,
                              size: 32.0,
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              Assets.images.singlePlaceHolder.path,
                            ),
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
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              podcastModel.title!,
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
                                  podcastModel.author!,
                                  style: textTheme.headlineSmall,
                                ),
                                SizedBox(width: 12),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Obx(
                        () => ListView.builder(
                          controller: ScrollController(),
                          shrinkWrap: true,
                          itemCount: controller.podcastsFileModel.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                await controller.player.seek(
                                  Duration.zero,
                                  index: index,
                                );
                                controller.currentFileIndex.value =
                                    controller.player.currentIndex!;
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        ImageIcon(
                                          Image.asset(
                                            Assets.icons.microphone.path,
                                          ).image,
                                          color: SolidColors.seeMore,
                                        ),
                                        SizedBox(width: 8),
                                        SizedBox(
                                          width: Get.width / 1.5,
                                          child: Obx(
                                            () => Text(
                                              controller
                                                  .podcastsFileModel[index]
                                                  .title!,
                                              style:
                                                  controller
                                                          .currentFileIndex
                                                          .value ==
                                                      index
                                                  ? textTheme.bodyMedium
                                                  : textTheme.bodySmall,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '${controller.podcastsFileModel[index].lenght!}:00',
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              right: Dimens.bodyMargin,
              left: Dimens.bodyMargin,
              child: Container(
                height: Get.height / 7,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: GradientColors.bottomNavBackground,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    gradient: LinearGradient(colors: GradientColors.bottomNav),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: Get.width - (Dimens.bodyMargin * 2),
                            child: LinearPercentIndicator(
                              percent: 1,
                              backgroundColor: Colors.white,
                              progressColor: Colors.orange,
                            ),
                          ),
                          SizedBox(
                            width: Get.width - (Dimens.bodyMargin * 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await controller.player.seekToNext();
                                    controller.currentFileIndex.value =
                                        controller.player.currentIndex!;
                                  },
                                  child: Icon(
                                    Icons.skip_next,
                                    color: Colors.white,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (controller.player.playing) {
                                      controller.player.pause();
                                    } else {
                                      controller.player.play();
                                    }
                                    controller.playState.value =
                                        controller.player.playing;

                                    controller.currentFileIndex.value =
                                        controller.player.currentIndex!;
                                  },
                                  child: Obx(
                                    () => Icon(
                                      controller.playState.value
                                          ? Icons.pause_circle_filled
                                          : Icons.play_circle_fill,
                                      color: Colors.white,
                                      size: 48,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await controller.player.seekToPrevious();
                                    controller.currentFileIndex.value =
                                        controller.player.currentIndex!;
                                  },
                                  child: Icon(
                                    Icons.skip_previous,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(),
                                Icon(Icons.repeat, color: Colors.white),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
