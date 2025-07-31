import 'package:get/get.dart';
import 'package:tech_blog/constant/api_url_constant.dart';
import 'package:tech_blog/models/article_model.dart';
import 'package:tech_blog/services/dio_service.dart';

class ArticleListScreenController extends GetxController {
  RxList<ArticleModel> articleList = RxList();

  RxBool loading = false.obs;

  @override
  onInit() {
    super.onInit();
    getArticleitems();
  }

  getArticleitems() async {
    loading.value = true;
    var response = await DioService().getMethod(ApiUrlConstant.getArticleList);
    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });

      loading.value = false;
    }
  }

  getArticleListWithTagsId(String id) async {
    articleList.clear();
    loading.value = true;

    // final queryParam = {
    //   'command': 'get_articles_with_tag_id',
    //   'tag_id': id,
    //   'user_id': '',
    // };

    // final uri = Uri.https(
    //   ApiUrlConstant.baseUrl,
    //   'article/get.php?',
    //   queryParam,
    // );

    var response = await DioService().getMethod(
      '${ApiUrlConstant.baseUrl}article/get.php?command=get_articles_with_tag_id&tag_id=$id&user_id=',
    );

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });
      loading.value = false;
    }
  }

    getArticleListWithCatId(String id) async {
    articleList.clear();
    loading.value = true;

    var response = await DioService().getMethod(
      '${ApiUrlConstant.baseUrl}article/get.php?command=get_articles_with_cat_id&cat_id=$id&user_id=',
    );

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });
      loading.value = false;
    }
  }
}
