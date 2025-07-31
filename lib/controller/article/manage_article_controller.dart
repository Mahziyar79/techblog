
import 'package:dio/dio.dart' as dio;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_blog/constant/api_key_constants.dart';
import 'package:tech_blog/constant/api_url_constant.dart';
import 'package:tech_blog/constant/commands.dart';
import 'package:tech_blog/constant/storage_const.dart';
import 'package:tech_blog/controller/file_controller.dart';
import 'package:tech_blog/models/article/article_info_model.dart';
import 'package:tech_blog/models/article/article_model.dart';
import 'package:tech_blog/models/tags_model.dart';
import 'package:tech_blog/services/dio_service.dart';

class ManageArticleController extends GetxController {
  RxList<ArticleModel> articleList = RxList.empty();
  RxList<TagsModel> tagList = RxList.empty();
  Rx<ArticleInfoModel> articleInfoModel = ArticleInfoModel(
    'test',
    'test',
    '',
  ).obs;
  RxBool loading = false.obs;
  TextEditingController titleTextEditingController = TextEditingController();
  @override
  onInit() {
    super.onInit();
    getManagedArticle();
  }

  getManagedArticle() async {
    loading.value = true;
    // var response = await DioService().getMethod(
    //   ApiUrlConstant.publishedByMe + GetStorage().read(StorageKey.userId),
    // );
    var response = await DioService().getMethod(
      '${ApiUrlConstant.publishedByMe}1',
    );
    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });
      loading.value = false;
    }
  }

  updateTitle() {
    articleInfoModel.update((val) {
      val!.title = titleTextEditingController.text;
    });
  }

  storeArticle() async {
    FileController fileController = Get.find<FileController>();
    loading.value = true;
    Map<String, dynamic> map = {
      ApiArticleKeyConstant.title: articleInfoModel.value.title,
      ApiArticleKeyConstant.content: articleInfoModel.value.content,
      ApiArticleKeyConstant.catId: articleInfoModel.value.catId,
      ApiArticleKeyConstant.userId: GetStorage().read(StorageKey.userId),
      ApiArticleKeyConstant.image: fileController.file.value.path != null
          ? await dio.MultipartFile.fromFile(fileController.file.value.path!)
          : '',
      ApiArticleKeyConstant.command: Commands.store,
      ApiArticleKeyConstant.tagList: '[]',
    };
      await DioService().postMethod(
      map,
      ApiUrlConstant.articlePost,
    );

    loading.value = false;
  }
}
