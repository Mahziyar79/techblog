import 'package:flutter/material.dart';
import 'package:tech_blog/constant/colors.dart';
import 'package:tech_blog/gen/assets.gen.dart';

class SeeMore extends StatelessWidget {
  const SeeMore({super.key, required this.bodyMargin,required this.title});
  final double bodyMargin;
  final String title;
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(right: bodyMargin > 0 ? bodyMargin : 0),
      child: Row(
        children: [
          ImageIcon(
            Assets.icons.pencil.provider(),
            color: SolidColors.colorTitle,
            size: 20,
          ),
          SizedBox(width: 8),
          Text(title, style: textTheme.bodyMedium),
        ],
      ),
    );
  }
}
