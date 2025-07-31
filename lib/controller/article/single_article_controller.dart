import 'package:get/get.dart';
import 'package:tech_blog/constant/api_url_constant.dart';
import 'package:tech_blog/models/article/article_info_model.dart';
import 'package:tech_blog/models/article/article_model.dart';
import 'package:tech_blog/models/tags_model.dart';
import 'package:tech_blog/services/dio_service.dart';

class SingleArticleController extends GetxController {
  RxBool loading = false.obs;
  // RxInt id = RxInt(0);
  Rx<ArticleInfoModel> articleInfoModel = ArticleInfoModel(
    null,
    null,
    null,
  ).obs;
  RxList<TagsModel> tagList = RxList();
  RxList<ArticleModel> relatedList = RxList();

  getArticleInfo(String id) async {
    loading.value = true;

    articleInfoModel.value = ArticleInfoModel(null, null, null);
    tagList.clear();
    relatedList.clear();

    String userId = '';
    var response = await DioService().getMethod(
      '${ApiUrlConstant.baseUrl}article/get.php?command=info&id=$id&user_id=$userId',
    );

    if (response.statusCode == 200) {
      articleInfoModel.value = ArticleInfoModel.fromJson(response.data);

      tagList.assignAll(
        (response.data['tags'] as List)
            .map((e) => TagsModel.fromJson(e))
            .toList(),
      );

      relatedList.assignAll(
        (response.data['related'] as List)
            .map((e) => ArticleModel.fromJson(e))
            .toList(),
      );
    }

    loading.value = false;
  }
}
