import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_iti/Provider/bookmark_provider.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import '../Constants/const.dart';
import '../Models/article_model.dart';
import 'article_details.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key});

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  Future<List<ArticleModel>>? _fetchArticlesFuture;

  @override
  void initState() {
    super.initState();
    _fetchArticlesFuture =
        Provider.of<MyNewsProvider>(context, listen: false).fetchArticles();
  }

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
          title: const Text(
            'Saved',
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              FutureBuilder<List<ArticleModel>>(
                future: _fetchArticlesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  else if (snapshot.hasData) {
                    final markedArticles = snapshot.data;
                    return showAllMarkedArticles(markedArticles!);
                  } else {
                    return const Text('No Data');
                  }
                },
              ),
            ],
          ),
        ));
  }

  Widget showAllMarkedArticles(List<ArticleModel> markedArticles) {
    final provider = Provider.of<MyNewsProvider>(context);
    return Expanded(
      child: ListView.separated(
        itemCount: markedArticles.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            thickness: 1,
            height: 1,
            color: Colors.grey,
            indent: 15,
            endIndent: 15,
          );
        },
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    "Delete this article?",
                    style: TextStyle(fontSize: 18),
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.red)),
                            onPressed: () async {
                              setState(() async {
                                await provider.deleteUser(index: index);
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 2),
                                    content: Text(
                                      'Article Deleted',
                                      style: TextStyle(color: Colors.white),
                                    )));
                              });


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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ))
                      ],
                    ),
                  ],
                ),
              );
            },
            child: trendingBodyItems(markedArticles[index], context),
          );
        },
      ),
    );
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
}
