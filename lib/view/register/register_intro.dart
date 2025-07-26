import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tech_blog/constant/colors.dart';
import 'package:tech_blog/constant/strings.dart';
import 'package:tech_blog/controller/register/register_controller.dart';
import 'package:tech_blog/gen/assets.gen.dart';
// import 'package:tech_blog/view/my_cats.dart';
import 'package:validators/validators.dart';

class RegisterIntro extends StatelessWidget {
  RegisterIntro({super.key});

  final registerController = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: SolidColors.scaffoldBg,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.images.techbot.path, height: 100),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: RichText(
                  text: TextSpan(
                    text: Strings.welcome,
                    style: textTheme.headlineSmall,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  _showEmailBottomSheet(context, size, textTheme);
                },

                child: Text(
                  'بزن بریم',
                  style: TextStyle(color: SolidColors.lightText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showEmailBottomSheet(
    BuildContext context,
    Size size,
    TextTheme textTheme,
  ) {
    String? errorText;

    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                height: size.height / 2,
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(Strings.insertYourEmail, style: textTheme.labelLarge),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: TextField(
                        controller:
                            registerController.emailTextEditingController,
                        style: textTheme.headlineSmall,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          hintText: 'test@gmail.com',
                          errorText: errorText,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        String email = registerController
                            .emailTextEditingController
                            .text
                            .trim();
                        if (isEmail(email)) {
                          registerController.register();
                          Navigator.pop(context);
                          _showActivateBottomSheet(context, size, textTheme);
                        } else {
                          setModalState(() {
                            errorText = 'ایمیل وارد شده معتبر نیست';
                          });
                        }
                      },
                      child: Text(
                        'بزن بریم',
                        style: TextStyle(color: SolidColors.lightText),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<dynamic> _showActivateBottomSheet(
    BuildContext context,
    Size size,
    TextTheme textTheme,
  ) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: size.height / 2,
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(Strings.activateCode, style: textTheme.labelLarge),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: TextField(
                    controller:
                        registerController.activeCodeTextEditingController,
                    style: textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(hintText: '******'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    registerController.verify();
                    // Navigator.of(context).pushReplacement(
                    //   MaterialPageRoute(builder: (context) => MyCats()),
                    // );
                  },

                  child: Text(
                    'بزن بریم',
                    style: TextStyle(color: SolidColors.lightText),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
