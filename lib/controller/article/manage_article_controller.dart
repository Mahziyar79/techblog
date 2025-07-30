import 'package:get/get.dart';
import 'package:tech_blog/constant/api_constant.dart';
import 'package:tech_blog/models/article_info_model.dart';
import 'package:tech_blog/models/article_model.dart';
import 'package:tech_blog/models/tags_model.dart';
import 'package:tech_blog/services/dio_service.dart';

class ManageArticleController extends GetxController {
  RxList<ArticleModel> articleList = RxList.empty();
  RxList<TagsModel> tagList = RxList.empty();
  Rx<ArticleInfoModel> articleInfoModel = ArticleInfoModel('test','test','').obs;
  RxBool loading = false.obs;

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
}
