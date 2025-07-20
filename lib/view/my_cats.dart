import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tech_blog/components/main_tags.dart';
import 'package:tech_blog/constant/colors.dart';
import 'package:tech_blog/constant/strings.dart';
import 'package:tech_blog/gen/assets.gen.dart';
import 'package:tech_blog/models/fake_data/fake_data.dart';

class MyCats extends StatefulWidget {
  const MyCats({super.key});

  @override
  State<MyCats> createState() => _MyCatsState();
}

class _MyCatsState extends State<MyCats> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    var bodyMargin = size.width / 10;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(right: bodyMargin, left: bodyMargin),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 32),
                  SvgPicture.asset(Assets.images.techbot.path, width: 100),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: RichText(
                      text: TextSpan(
                        text: Strings.successfulRegistration,
                        style: textTheme.headlineSmall,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TextField(
                    style: textTheme.headlineSmall,
                    textAlign: TextAlign.right,

                    decoration: InputDecoration(
                      hintText: 'نام و نام خانوادگی',
                      alignLabelWithHint: true,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(Strings.chooseCats, style: textTheme.bodyLarge),
                  SizedBox(height: 24),
                  SizedBox(
                    height: 100,
                    child: GridView.builder(
                      itemCount: tagList.length,
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemBuilder: ((context, index) {
                        return InkWell(
                          onTap: () {
                            if (!selectedTags.contains(tagList[index])) {
                              setState(() {
                                selectedTags.add(tagList[index]);
                              });
                            }
                          },
                          child: MainTags(index: index, title: tagList[index].title),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 12),
                  SvgPicture.asset(Assets.images.arrowDown.path, width: 42),
                  SizedBox(height: 12),
                  //  selectedTags
                  SizedBox(
                    height: 100,
                    child: GridView.builder(
                      itemCount: selectedTags.length,
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemBuilder: ((context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                            color: SolidColors.surface,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedTags[index].title,
                                style: TextStyle(color: Colors.black),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedTags.removeAt(index);
                                  });
                                },
                                child: Icon(
                                  Icons.delete,
                                  size: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
