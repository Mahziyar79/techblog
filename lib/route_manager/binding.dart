import 'package:get/get.dart';
import 'package:tech_blog/controller/article/article_list_screen_controller.dart';
import 'package:tech_blog/controller/article/manage_article_controller.dart';
import 'package:tech_blog/controller/article/single_article_controller.dart';
import 'package:tech_blog/controller/home_screen_controller.dart';
import 'package:tech_blog/controller/register/register_controller.dart';


class ArticleBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ArticleListScreenController());
    Get.lazyPut(() => SingleArticleController());
  }
}

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeScreenController());
    Get.lazyPut(() => SingleArticleController());
    Get.lazyPut(() => ArticleListScreenController());
    Get.put(RegisterController());
  }
}

class ArticleManagerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ManageArticleController());
  }
}


// class SinglePodcastBinding implements Bindings {
//   @override
//   void dependencies() {
//     Get.put(SinglePodcastController());
//   }
// }

// class podcastManagerBinding implements Bindings {
//   @override
//   void dependencies() {
//      Get.lazyPut(() => SinglePodcastController());
//   }
// }