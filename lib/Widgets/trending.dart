import 'package:flutter/material.dart';
import 'package:news_iti/Models/article_model.dart';
import 'package:news_iti/Screens/article_details.dart';
import 'package:transparent_image/transparent_image.dart';

class TrendingWidget extends StatelessWidget {
  const TrendingWidget({super.key, required this.articleModel});
  final ArticleModel articleModel;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ArticleDetails(articleModel: articleModel))),
              child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(articleModel.imageUrl)),
            )),
        const SizedBox(
          height: 16,
        ),
        Text(
          articleModel.title,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.border_color_outlined,
                  // color:Color(0xFF1877F2),
                  size: 16,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  articleModel.author,
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.timer_sharp,
                  size: 16,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(articleModel.publishedAt.substring(0, 10))
              ],
            )
          ],
        )
      ],
    );
  }
}
