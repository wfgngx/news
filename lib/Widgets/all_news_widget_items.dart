import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_iti/Models/article_model.dart';
import 'package:news_iti/Provider/bookmark_provider.dart';
import 'package:news_iti/Screens/article_details.dart';
import 'package:provider/provider.dart';

class ArticleShape extends StatelessWidget {
  const ArticleShape({super.key, required this.articleModel});
  final ArticleModel articleModel;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyNewsProvider>(context);

    return Stack(children: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          child: GestureDetector(
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(
                      "Save this article?",
                      style: TextStyle(fontSize: 18),
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color(0xFF1877F2))),
                              onPressed: () {
                                provider.addArticleHive(articleModel);
                                provider.fetchArticles();

                                Navigator.pop(context);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                        backgroundColor: Color(0xFF1877F2),
                                        duration: Duration(seconds: 2),
                                        content: Text(
                                          'Article Saved',
                                          style: TextStyle(color: Colors.white),
                                        )));
                              },
                              child: const Text(
                                'Yes',
                                style: TextStyle(
                                    color: CupertinoColors.white, fontSize: 18),
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ))
                        ],
                      ),
                    ],
                  ),
                );
              },
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ArticleDetails(articleModel: articleModel))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FadeInImage(
                      height: 110,
                      width: 110,
                      fit: BoxFit.cover,
                      placeholder: const AssetImage('assets/loading-load.gif'),
                      image: NetworkImage(articleModel.imageUrl)),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: SizedBox(
                          height: 103,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                articleModel.title,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.abel(
                                  fontSize: 18,
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                  color: provider.themeMode == ThemeMode.light
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    articleModel.author.length > 20
                                        ? articleModel.author.substring(0, 5)
                                        : articleModel.author,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          provider.themeMode == ThemeMode.light
                                              ? Color(0xFF1877F2)
                                              : Colors.white,
                                    ),
                                  ),
                                  Text(
                                    articleModel.publishedAt.substring(0, 10),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              )
                            ],
                          )))
                ],
              )))
    ]);
  }
}
