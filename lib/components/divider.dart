import 'package:flutter/material.dart';
import 'package:tech_blog/constant/colors.dart';

class TechDivider extends StatelessWidget {
  const TechDivider({
    super.key,
    required this.indent,
    required this.endIndent,
  });

  final double indent;
  final double endIndent;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: SolidColors.dividerColor,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
