import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:news_iti/Models/article_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyNewsProvider extends ChangeNotifier {

  bool isDark = false;
   ThemeMode themeMode = ThemeMode.light;


  isDarkTest(){
    if(isDark == true){
      themeMode = ThemeMode.dark;
    }else{
      themeMode= ThemeMode.light;
    }
    notifyListeners();
  }
  void changeTheme(ThemeMode theme) {
    setTheme(theme == ThemeMode.light? false :true);
    getTheme();
    themeMode = theme;
    notifyListeners();
  }
  Future setTheme(bool isDark)async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    sharedPreferences.setBool('isDark', isDark);
    notifyListeners();
  }
  Future getTheme()async{
    final SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    isDark = sharedPreferences.getBool('isDark')??false;
    isDarkTest();
    notifyListeners();
  }
  List<ArticleModel> markedArticle = [];
  addArticleHive(ArticleModel articleModel) async {
    var articleBox = Hive.box<ArticleModel>('saved_articles');
    await articleBox.add(articleModel);
    notifyListeners();
  }

  Future<List<ArticleModel>> fetchArticles() async {
    var articleBox = Hive.box<ArticleModel>('saved_articles');
    markedArticle = articleBox.values.toList();
    notifyListeners();
    return markedArticle;
  }

  Future<void> deleteUser({required int index}) async {
    var articleBox = Hive.box<ArticleModel>('saved_articles');
    await articleBox.deleteAt(index);
    markedArticle.removeAt(index);
    markedArticle = articleBox.values.toList();
    notifyListeners();
  }


}
