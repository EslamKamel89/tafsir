import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafsir/ui/articles_screen/widgets/normal_article_widget.dart';
import 'package:tafsir/ui/articles_screen/widgets/series_article_widget.dart';
import 'package:tafsir/ui/home_sura_screen.dart';
import 'package:tafsir/widgets/quran_toolbar.dart';

class ArticlesScreen extends StatefulWidget {
  static String id = '/ArticlesScreen';
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: QuranBar("articles".tr),
      appBar: QuranBar("الابحاث"),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            // Container(height: 5, color: const Color(0XFFf44235)),
            Container(height: 5),
            // Container(height: 5, color: Color(hexToInteger("FFf44235"))),
            TabBar(
              indicatorColor: Colors.transparent,
              tabs: [
                TabButton(title: "ARTICLES".tr, selected: currentIndex == 0),
                TabButton(title: "SERIES".tr, selected: currentIndex == 1),
              ],
              onTap: (value) {
                currentIndex = value;
                setState(() {});
              },
            ),
            Expanded(
              child:
                  currentIndex == 0 ? const NormalArticlesWidget() : const SeriesArticlesWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
