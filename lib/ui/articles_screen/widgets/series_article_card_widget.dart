import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:tafsir/models/article_model.dart';
import 'package:tafsir/models/article_series_model.dart';
import 'package:tafsir/ui/artice_details_screen.dart';
import 'package:tafsir/utils/colors.dart';
import 'package:tafsir/utils/text_styles.dart';

class SeriesArticleCardWidget extends StatefulWidget {
  final ArticleSeriesModel articleSeriesModel;

  const SeriesArticleCardWidget(this.articleSeriesModel, {super.key});

  @override
  State<SeriesArticleCardWidget> createState() => _SeriesArticleCardWidgetState();
}

class _SeriesArticleCardWidgetState extends State<SeriesArticleCardWidget> {
  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body!.text).documentElement!.text;
    return parsedString;
  }

  bool seeMore = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child:
      // style: ElevatedButton.styleFrom(
      // foregroundColor: Colors.grey, backgroundColor: Colors.white, padding: EdgeInsets.zero, elevation: 2),
      // onPressed: () {},
      // Get.to(const ArticleDetailsScreen(), transition: Transition.fadeIn, arguments: articleModel.toJson()),
      // child:
      Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 1,
        // color: Colors.grey,
        shadowColor: Colors.grey,
        child: Container(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LocalizedText(widget.articleSeriesModel.name!, color: primaryColor, fontSize: 18),
              // Text(
              //   widget.articleSeriesModel.name!,
              //   textAlign: TextAlign.start,
              //   style: const TextStyle(color: primaryColor, fontSize: 18, fontFamily: 'Almarai'),
              // ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  _parseHtmlString(widget.articleSeriesModel.content ?? ''),
                  style: const TextStyle(fontSize: 18, fontFamily: "Almarai"),
                  maxLines: 2,
                ),
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: seeMore,
                child: Material(
                  borderRadius: BorderRadius.circular(15),
                  elevation: 2,
                  shadowColor: Colors.grey,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child:
                        widget.articleSeriesModel.articles == null
                            ? const Center(child: DefaultText('لا يوجد مقالات'))
                            : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: widget.articleSeriesModel.articles!.length,
                              itemBuilder: (context, index) {
                                ArticleModel? articleModel =
                                    (widget.articleSeriesModel.articles?[index]);
                                if (articleModel == null) {
                                  return const SizedBox();
                                }
                                return InkWell(
                                  onTap: () {
                                    // Get.to(const ArticleDetailsScreen(),
                                    //     transition: Transition.fadeIn, arguments: articleModel.toJson());
                                    Get.to(
                                      const ArticleDetailsScreen(),
                                      transition: Transition.fadeIn,
                                      arguments: articleModel.id,
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 10),
                                    child: Material(
                                      elevation: 2,
                                      borderRadius: BorderRadius.circular(5),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 10,
                                        ),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [DefaultText(articleModel.name ?? '')],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      seeMore = !seeMore;
                    });
                  },
                  child: DefaultText(seeMore ? 'أخفاء المقالات' : 'مشاهدة المقالات', fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
