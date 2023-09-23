import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_iti/Models/article_model.dart';
import 'package:news_iti/Provider/bookmark_provider.dart';
import 'package:news_iti/Screens/splash.dart';
import 'package:provider/provider.dart';
import 'Theme/myTheme.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ArticleModelAdapter());
  await Hive.openBox<ArticleModel>('saved_articles');
  runApp(
      ChangeNotifierProvider<MyNewsProvider>(
      create: (context) {
        final provider = MyNewsProvider();
        provider.getTheme();
        return provider;
      },
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyNewsProvider>(context);
    return MaterialApp(
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: provider.themeMode,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
