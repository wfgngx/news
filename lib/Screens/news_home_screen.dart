import 'package:flutter/material.dart';
import 'package:news_iti/Models/article_model.dart';
import 'package:news_iti/Provider/bookmark_provider.dart';
import 'package:news_iti/Widgets/all_news_widget_items.dart';
import 'package:provider/provider.dart';

import '../Api/getDate.dart';

String category = 'technology';

class NewsHomeScreen extends StatefulWidget {
  const NewsHomeScreen({
    super.key,
  });

  @override
  State<NewsHomeScreen> createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends State<NewsHomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  // Store all articles
  List<ArticleModel> articles = [];
  // Store filtered articles
  List<ArticleModel> filteredList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchArticles();
  }

  void fetchArticles() async {
    List<ArticleModel> fetchedArticles = await News().fetchData(category);
    setState(() {
      articles = fetchedArticles;
      filteredList = articles; // Initialize the filtered list with all articles
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyNewsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.dark_mode,
              color: provider.themeMode == ThemeMode.light
                  ? Colors.black26
                  : Colors.white,
            ),
            onPressed: () {
              Provider.of<MyNewsProvider>(context, listen: false)
                  .changeTheme(ThemeMode.dark);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.light_mode,
              color: provider.themeMode == ThemeMode.light
                  ? Colors.white
                  : Colors.black26,
            ),
            onPressed: () {
              Provider.of<MyNewsProvider>(context, listen: false)
                  .changeTheme(ThemeMode.light);
            },
          )
        ],
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(46),
                bottomRight: Radius.circular(46))),
        backgroundColor: const Color(0xFF1877F2),
        title: const Text(
          "BeIN News",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
                child: SearchBar(
                  controller: _searchController,
                  surfaceTintColor:
                      const MaterialStatePropertyAll(Colors.white),
                  leading: const Icon(Icons.search),
                  hintText: 'Search',
                  hintStyle: MaterialStatePropertyAll(TextStyle(fontSize: 18)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
                  onChanged: (query) {
                    filterArticles(query);
                  },
                )),
            // ),)),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: EdgeInsets.only(right: 16, left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Category',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        // color: Color(0xFF1877F2),
                        color: provider.themeMode == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: SizedBox(
                  width: double.infinity,
                  height: 35,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              category = 'sports';
                            });
                          },
                          child: categoryName('Sports',
                              color: category == 'sports'
                                  ? const Color(0xFF1877F2)
                                  :Colors.blueGrey,
                              textColor: category == 'sports'
                                  ? Colors.white
                                  : Colors.black)),
                      InkWell(
                          onTap: () {
                            setState(() {
                              category = 'technology';
                            });
                          },
                          child: categoryName('Technology',
                              color: category == 'technology'
                                  ? const Color(0xFF1877F2)
                                  : Colors.blueGrey,
                              textColor: category == 'technology'
                                  ? Colors.white
                                  : Colors.black)),
                      InkWell(
                          onTap: () {
                            setState(() {
                              category = 'business';
                            });
                          },
                          child: categoryName('Business',
                              color: category == 'business'
                                  ? const Color(0xFF1877F2)
                                  : Colors.blueGrey,
                              textColor: category == 'business'
                                  ? Colors.white
                                  : Colors.black)),
                      InkWell(
                          onTap: () {
                            setState(() {
                              category = 'entertainment';
                            });
                          },
                          child: categoryName('Entertainment',
                              color: category == 'entertainment'
                                  ? const Color(0xFF1877F2)
                                  : Colors.blueGrey,
                              textColor: category == 'entertainment'
                                  ? Colors.white
                                  : Colors.black)),
                      InkWell(
                          onTap: () {
                            setState(() {
                              category = 'general';
                            });
                          },
                          child: categoryName('General',
                              color: category == 'general'
                                  ? const Color(0xFF1877F2)
                                  : Colors.blueGrey,
                              textColor: category == 'general'
                                  ? Colors.white
                                  : Colors.black)),
                      InkWell(
                          onTap: () {
                            setState(() {
                              category = 'health';
                            });
                          },
                          child: categoryName('Health',
                              color: category == 'health'
                                  ? const Color(0xFF1877F2)
                                  : Colors.blueGrey,
                              textColor: category == 'health'
                                  ? Colors.white
                                  : Colors.black)),
                      InkWell(
                          onTap: () {
                            setState(() {
                              category = 'science';
                            });
                          },
                          child: categoryName('Science',
                              color: category == 'science'
                                  ? const Color(0xFF1877F2)
                                  :Colors.blueGrey,
                              textColor: category == 'science'
                                  ? Colors.white
                                  : Colors.black)),


                    ],
                  )),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: showAllArticles(category),
            )
          ],
        ),
      ),
    );
  }

  Widget categoryName(String categoryName,
      {Color color = Colors.white, Color textColor = Colors.black}) {
    return InkWell(
        child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
                padding: const EdgeInsets.only(left: 12, right: 12),
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(16)),
                child: Center(
                    child: Text(
                  categoryName,
                  style: TextStyle(fontSize: 16, color: textColor),
                )))));

  }

  void filterArticles(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredList = articles; // If the query is empty, show all articles
      } else {
        filteredList = articles
            .where((article) =>
                article.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  Widget showAllArticles(String category) {
    return SizedBox(
        height: 2603,
        child: FutureBuilder<List<ArticleModel>>(
          future: News().fetchData(category),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ArticleModel> articles = snapshot.data!;
              List<ArticleModel> filteredList = articles
                  .where((article) => article.title
                      .toLowerCase()
                      .contains(_searchController.text.toLowerCase()))
                  .toList();
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  return ArticleShape(
                    articleModel: filteredList[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    color: Colors.grey,
                    thickness: 1,
                    height: 1,
                    indent: 10,
                    endIndent: 10,
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
