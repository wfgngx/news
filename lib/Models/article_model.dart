import 'package:hive/hive.dart';
part 'article_model.g.dart';

@HiveType(typeId: 0)
class ArticleModel extends HiveObject {

  @HiveField(0)
  final String imageUrl;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String author;

  @HiveField(3)
  final  String description;

  @HiveField(4)
  final String publishedAt;

  @HiveField(5)
  final String articleUrl;
   ArticleModel(
      {required this.publishedAt,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.articleUrl,
      required this.author});
 factory ArticleModel.fromJson(Map<String, dynamic> data) {
   return ArticleModel(
     title: data['title'] ?? '',
     description: data['description'] ?? '',
     publishedAt: data['publishedAt'] ?? 'UN KNOWN',
     imageUrl: data['urlToImage'] ?? 'https://www.fluttercampus.com/img/4by3.webp',
     articleUrl: data['url'] ?? '',
     author: data['author'] ?? 'UN KNOWN',
   );
 }
}
