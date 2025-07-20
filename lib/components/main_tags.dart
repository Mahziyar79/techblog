import 'package:flutter/material.dart';
import 'package:tech_blog/constant/colors.dart';

class MainTags extends StatelessWidget {
  const MainTags({super.key, required this.index,required this.title});
  final int index;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        gradient: LinearGradient(
          colors: GradientColors.tags,
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.tag, size: 10, color: Colors.white),
          SizedBox(width: 4),
          Text(title, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
