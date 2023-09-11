import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:news_iti/Provider/bookmark_provider.dart';
import 'package:news_iti/Screens/book_mark_screen.dart';
import 'package:news_iti/Screens/news_home_screen.dart';
import 'package:news_iti/Screens/trend_news.dart';
import 'package:provider/provider.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  final List<Widget> screens = [
    const NewsHomeScreen(),
    const TrendNews(),
    const BookMarkScreen()
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyNewsProvider>(context);
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          color:provider.themeMode == ThemeMode.light? Colors.white: Colors.black54,
          animationDuration: const Duration(milliseconds: 800),
          animationCurve: Curves.decelerate,
          height: 45,
          index: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            Icon(
              Icons.home,
              color: Color(0xFF1877F2),
            ),
            Icon(
              Icons.explore,
              color: Color(0xFF1877F2),
            ),
            Icon(
              Icons.bookmark_border_outlined,
              color: Color(0xFF1877F2),
            ),
          ]),
      body: screens[currentIndex],
    );
  }
}
