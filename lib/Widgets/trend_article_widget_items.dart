import 'package:flutter/material.dart';
import 'package:news_iti/Models/article_model.dart';
import 'package:transparent_image/transparent_image.dart';

class ArticleItems extends StatelessWidget {
  const ArticleItems({super.key, required this.articleModel});
  final ArticleModel articleModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: FadeInImage(
            placeholderFit: BoxFit.scaleDown,
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(articleModel.imageUrl),
            width: double.infinity,
            fit: BoxFit.cover,
            height: 175,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          articleModel.title,
          style: const TextStyle(fontSize: 22, color: Colors.black),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(articleModel.publishedAt.substring(0, 10)),
            Text(articleModel.author)
          ],
        )
      ],
    );
  }
}
