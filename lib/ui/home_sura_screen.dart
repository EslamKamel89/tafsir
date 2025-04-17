import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:tafsir/ui/search_by_ayah/search_by_ayah_screen.dart';
import 'package:tafsir/ui/search_screen.dart';
import 'package:tafsir/ui/short_explanation_index.dart';
import 'package:tafsir/utils/colors.dart';
import 'package:tafsir/utils/is_arabic.dart';
import 'package:tafsir/utils/text_styles.dart';
import 'package:tafsir/widgets/quran_toolbar.dart';

class HomeSuraScreen extends StatefulWidget {
  const HomeSuraScreen({super.key});
  static var id = '/HomeSuraScreen';

  @override
  State<HomeSuraScreen> createState() => _HomeSuraScreenState();
}

class _HomeSuraScreenState extends State<HomeSuraScreen> with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    // _tabController!.addListener(() {
    //   setState(() {
    //     currentIndex = _tabController!.index;
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // initScreenUtil(context);
    return Scaffold(
      backgroundColor: lightGray,
      appBar: QuranBar('short_explanation'.tr),
      body: Column(
        children: [
          const SizedBox(height: 5),
          Transform.translate(
            offset: Offset(isArabic() ? 0 : -25, 0),
            child: TabBar(
              indicatorColor: Colors.transparent,
              isScrollable: isArabic() ? false : true,
              tabs: [
                TabButton(title: "SHORT_EXPLANATION".tr, selected: currentIndex == 0),
                TabButton(title: "SEARCH_BY_WORD".tr, selected: currentIndex == 1),
                TabButton(title: "SEARCH_BY_AYAH".tr, selected: currentIndex == 2),
              ],
              controller: _tabController!,
              onTap: (value) {
                log('New Value = $value');
                currentIndex = value;
                setState(() {});
              },
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child:
                currentIndex == 0
                    ? ShortExplanationIndex()
                    : currentIndex == 1
                    ? SearchScreen()
                    : const SearchAyahcreen(),
          ),
        ],
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  String title;
  bool selected;

  TabButton({super.key, required this.title, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: selected ? primaryColor2 : Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: LocalizedText(title, color: selected ? Colors.white : Colors.blueGrey),
      // Text(
      //   title,
      //   style: TextStyle(color: selected ? Colors.white : Colors.blueGrey),
      // ),
    );
  }
}
