
import 'package:tech_blog/constant/api_url_constant.dart';

class PodcastModel {
  String? id;
  String? title;
  String? poster;
  String? catName;
  String? author;
  String? view;
  String? status;
  String? createdAt;
  
  PodcastModel({
    required this.id,
    required this.title,
    required this.poster,
    required this.catName,
    required this.author,
    required this.view,
    required this.status,
    required this.createdAt,
  });


  factory PodcastModel.fromJson(Map<String, dynamic> json) {
    return PodcastModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      poster: ApiUrlConstant.hostDlUrl + (json['poster'] ?? ''),
      catName: json['cat_name'] ?? '',
      author: json['author'] ?? '',
      view: json['view'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
    );

  }
}