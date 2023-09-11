import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_iti/Constants/const.dart';
import 'package:news_iti/Models/article_model.dart';
import 'package:news_iti/Provider/bookmark_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetails extends StatelessWidget {
  const ArticleDetails({super.key, required this.articleModel});
  final ArticleModel articleModel;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyNewsProvider>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          foregroundColor: provider.themeMode == ThemeMode.light?
        Colors.black : Colors.white,
          centerTitle: true,
          title: const Text("Article Details"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(articleModel.title,
                      style: GoogleFonts.libreBaskerville(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color:provider.themeMode == ThemeMode.light?
                          Colors.black : Colors.white
                      ))),
              const SizedBox(
                height: 5,
              ),
              ClipRRect(
                  child: Image.network(
                articleModel.imageUrl,
                height: 250,
                fit: BoxFit.cover,
              )),
              const SizedBox(
                height: 0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      articleModel.publishedAt.substring(0, 10),
                      style: const TextStyle(
                        fontSize: 12,
                        color: myPrimaryColor,
                        // fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    const Text(
                      'by:',
                      style: TextStyle(
                        fontSize: 12,
                        color: myPrimaryColor,
                        // fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      articleModel.author,
                      style: const TextStyle(
                        fontSize: 12,
                        color: myPrimaryColor,
                        // fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Text(
                    articleModel.description,
                    style: GoogleFonts.abyssinicaSil(fontSize: 20),
                  )),
              const SizedBox(
                height: 5,
              ),
               Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    'See all article: ',
                    style: TextStyle(color:provider.themeMode == ThemeMode.light?
                    Colors.black : Colors.white, fontSize: 12),
                  )),
              InkWell(
                  onTap: () => _launchUrl(),
                  child: Text(
                    articleModel.articleUrl,
                    style:
                        const TextStyle(fontSize: 14, color: Colors.blueAccent),
                  ))
            ],
          ),
        ));
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(articleModel.articleUrl))) {
      throw Exception('Could not launch ${articleModel.articleUrl}');
    }
  }
}
