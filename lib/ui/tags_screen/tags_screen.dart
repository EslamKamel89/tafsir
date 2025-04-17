import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafsir/ui/home_sura_screen.dart';
import 'package:tafsir/ui/tags_screen/widgets/equals_tag_widget.dart';
import 'package:tafsir/ui/tags_screen/widgets/meaning_tag_widget.dart';
import 'package:tafsir/widgets/quran_toolbar.dart';

class TagsScreen extends StatefulWidget {
  const TagsScreen({super.key});

  static String id = '/TagsScreen';

  @override
  State<TagsScreen> createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // initScreenUtil(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: QuranBar('semantics'.tr),
        body: Column(
          children: [
            const SizedBox(height: 5),
            TabBar(
              indicatorColor: Colors.transparent,
              tabs: [
                TabButton(title: "EQUALS".tr, selected: currentIndex == 0),
                TabButton(title: "MEANING".tr, selected: currentIndex == 1),
                // TabButton(title: "الفروق", selected: currentIndex == 2),
              ],
              onTap: (value) {
                currentIndex = value;
                setState(() {});
              },
            ),
            Expanded(
              child:
                  currentIndex == 0
                      ? const EqualsTagsWidgt()
                      // : currentIndex == 1
                      // ?
                      : const MeaningTagsWidgt(),
              // : const DifferenceTagsWidgt(),
            ),
          ],
        ),
      ),
    );
  }
}
