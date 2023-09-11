import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_iti/Constants/const.dart';
import 'package:news_iti/Models/article_model.dart';
import 'package:news_iti/Api/getDate.dart';
import 'package:news_iti/Provider/bookmark_provider.dart';
import 'package:news_iti/Screens/article_details.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class TrendNews extends StatelessWidget {
  const TrendNews({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(46),
                  bottomRight: Radius.circular(46))),

          backgroundColor: const Color(0xFF1877F2),
          //   backgroundColor: const Color(0xFF39A552),
          title: const Text(
            'Trending',
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: showAllTrendingArticles())
            ],
          ),
        ));
  }

  Widget trendingBodyItems(ArticleModel articleModel, BuildContext context) {
    var provider = Provider.of<MyNewsProvider>(context);
    return Padding(
        padding: const EdgeInsets.only(bottom: 14, top: 14),
        child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ArticleDetails(articleModel: articleModel);
              }));
            },
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage(
                        width: double.infinity,
                        fit: BoxFit.contain,
                        placeholder: MemoryImage(kTransparentImage),
                        image: NetworkImage(articleModel.imageUrl))),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  articleModel.title,
                  style: GoogleFonts.libreBaskerville(
                    fontSize: 18,
                    color: provider.themeMode == ThemeMode.light
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.border_color_outlined,
                          color: provider.themeMode == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                          size: 12,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          articleModel.author.length > 20
                              ? articleModel.author.substring(0, 5)
                              : articleModel.author,
                          style: TextStyle(
                            color: provider.themeMode == ThemeMode.light
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.timer_sharp,
                          color: provider.themeMode == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                          size: 12,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          articleModel.publishedAt.substring(0, 10),
                          style: TextStyle(
                            color: provider.themeMode == ThemeMode.light
                                ? Colors.black
                                : Colors.white,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            )));
  }

  Widget showAllTrendingArticles() {
    return SizedBox(
        height: 1000,
        child: FutureBuilder<List<ArticleModel>>(
          future: News().fetchTrending(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ArticleModel> articles = snapshot.data!;
              return ListView.separated(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return trendingBodyItems(articles[index], context);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    thickness: 1,
                    height: 1,
                    color: Colors.grey,
                    indent: 15,
                    endIndent: 15,
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
