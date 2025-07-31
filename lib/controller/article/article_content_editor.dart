import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:tech_blog/components/app_bar_list.dart';
import 'package:tech_blog/constant/colors.dart';
import 'package:tech_blog/constant/strings.dart';
import 'package:tech_blog/controller/article/manage_article_controller.dart';

class ArticleContentEditor extends StatelessWidget {
  ArticleContentEditor({super.key});
  final HtmlEditorController controller = HtmlEditorController();
  final ManageArticleController manageArticleController = Get.put(
    ManageArticleController(),
  );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.clearFocus();
      },
      child: Scaffold(
        backgroundColor: SolidColors.scaffoldBg,
        appBar: appBarList('نوشتن/ویرایش مقاله'),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HtmlEditor(
                controller: controller,
                htmlEditorOptions: HtmlEditorOptions(
                  hint: Strings.hintArticleContentEditor,
                  shouldEnsureVisible: true,
                  initialText:
                      manageArticleController.articleInfoModel.value.content!,
                ),
                callbacks: Callbacks(
                  onChangeContent: (p0) =>
                      manageArticleController.articleInfoModel.update((val) {
                        val!.content = p0;
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
