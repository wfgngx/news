import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_iti/Models/article_model.dart';

class News {
  Future<List<ArticleModel>> fetchData(String category) async {
    http.Response response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=bc3c98abff424eb5a2fdd0fa47a2f5b0'));
    List<ArticleModel> articleList = [];
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> articles = data['articles'];
      for (int i = 0; i < articles.length; i++) {
        articleList.add(ArticleModel.fromJson(articles[i]));
        //print(articleList);
      }
    }
    return articleList;
  }

  Future<List<ArticleModel>> fetchTrending() async {
    http.Response response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=bc3c98abff424eb5a2fdd0fa47a2f5b0'));
    List<ArticleModel> articleList = [];
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> articles = data['articles'];
      for (int i = 0; i < articles.length; i++) {
        articleList.add(ArticleModel.fromJson(articles[i]));
      }
    }
    return articleList;
  }
}
