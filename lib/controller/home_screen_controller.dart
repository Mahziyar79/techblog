import 'package:get/get.dart';
import 'package:tech_blog/constant/api_constant.dart';
import 'package:tech_blog/models/article_model.dart';
import 'package:tech_blog/models/podcast_model.dart';
import 'package:tech_blog/models/poster_model.dart';
import 'package:tech_blog/models/tags_model.dart';
import 'package:tech_blog/services/dio_service.dart';

class HomeScreenController extends GetxController {
  Rx<PosterModel> poster = PosterModel().obs;

  RxList<ArticleModel> topVisitedList = <ArticleModel>[].obs;
  RxList<TagsModel> tagsList = <TagsModel>[].obs;
  RxList<PodcastModel> topPodcasts = <PodcastModel>[].obs;

  RxBool loading = false.obs;

  @override
  onInit() {
    super.onInit();
    getHomeitems();
  }

  getHomeitems() async {
    loading.value = true;
    var response = await DioService().getMethod(ApiUrlConstant.getHomeItems);
    if (response.statusCode == 200) {
      topVisitedList.value = (response.data['top_visited'] as List)
          .map((item) => ArticleModel.fromJson(item))
          .toList();

      topPodcasts.value = (response.data['top_podcasts'] as List)
          .map((item) => PodcastModel.fromJson(item))
          .toList();

      tagsList.value = (response.data['tags'] as List)
          .map((item) => TagsModel.fromJson(item))
          .toList();

      poster.value = PosterModel.fromJson(response.data['poster']);
      loading.value = false;
    }
  }
}
