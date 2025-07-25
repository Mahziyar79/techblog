import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_blog/constant/api_constant.dart';
import 'package:tech_blog/constant/storage_const.dart';
import 'package:tech_blog/services/dio_service.dart';
import 'package:tech_blog/view/main_screen/main_screen.dart';
import 'package:tech_blog/view/register/register_intro.dart';

class RegisterController extends RxController {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController activeCodeTextEditingController =
      TextEditingController();

  String email = '';
  String userId = '';

  register() async {
    Map<String, dynamic> map = {
      'email': emailTextEditingController.text,
      'command': 'register',
    };

    var response = await DioService().postMethod(
      map,
      ApiUrlConstant.postRegister,
    );

    email = emailTextEditingController.text;
    userId = response.data['user_id'];
  }

  verify() async {
    Map<String, dynamic> map = {
      'email': email,
      'user_id': userId,
      'code': activeCodeTextEditingController.text,
      'command': 'verify',
    };
    var response = await DioService().postMethod(
      map,
      ApiUrlConstant.postRegister,
    );
    String status = response.data['response'];
    switch (status) {
      case 'verified':
        var box = GetStorage();
        await box.write(StorageKey.token, response.data['token']);
        await box.write(StorageKey.userId, response.data['user_id']);

        Get.to(() => MainScreen());
        break;
      case 'incorrect_code':
        Get.snackbar('خطا', 'کد فعالسازی غلط است');
        break;
      case 'expired':
        Get.snackbar('خطا', 'کد فعالسازی منقضی شده است');
        break;
    }
  }

  toggleLogin() {
    if (GetStorage().read(StorageKey.token) == null) {
      Get.to(() => RegisterIntro());
    }
  }
}
