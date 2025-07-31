import 'package:get/get.dart';
import 'package:tech_blog/constant/api_url_constant.dart';
import 'package:tech_blog/models/podcast/podcast_model.dart';
import 'package:tech_blog/services/dio_service.dart';

class PodcastListScreenController extends GetxController {
  RxList<PodcastModel> podcastList = RxList();

  RxBool loading = false.obs;

  @override
  onInit() {
    super.onInit();
    getPodcastitems();
  }

  getPodcastitems() async {
    loading.value = true;
    var response = await DioService().getMethod(ApiUrlConstant.newPodcasts);
    if (response.statusCode == 200) {
      response.data.forEach((element) {
        podcastList.add(PodcastModel.fromJson(element));
      });

      loading.value = false;
    }
  }

  
}
