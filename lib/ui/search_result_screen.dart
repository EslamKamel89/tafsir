import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafsir/controllers/search_result_controller.dart';
import 'package:tafsir/models/sura_search_model.dart';
import 'package:tafsir/utils/colors.dart';
import 'package:tafsir/widgets/font_text.dart';
import 'package:tafsir/widgets/quran_toolbar.dart';
import 'package:tafsir/widgets/white_container.dart';
import 'package:tafsir/widgets/word_result_item.dart';

class SearchResultScreen extends StatelessWidget {
  static var id = '/SearchResultScreen';
  late SuraSearchModel suraModel;
  final SearchResultController _resultController = Get.put(SearchResultController());

  SearchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    suraModel = SuraSearchModel.fromJson(Get.arguments);
    _resultController.getDetails(suraModel.suraId!, suraModel.searchKey!);
    // initScreenUtil(context);
    return Scaffold(
      backgroundColor: lightGray,
      appBar: const QuranBar('نتائج البحث'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: WhiteContainer(
              height: 45,
              radius: 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'نتائج البحث عن كلمة : ',
                    style: TextStyle(color: Colors.blueGrey, fontFamily: 'Almarai'),
                  ),
                  Text(
                    suraModel.searchKey!,
                    style: const TextStyle(color: primaryColor2, fontFamily: 'Almarai'),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: WhiteContainer(
              radius: 6,
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AlMaraiText(0, '${suraModel.suraId} ${suraModel.suraAr}'),
                  AlMaraiText(0, 'عدد : ${suraModel.count}'),
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () =>
                  _resultController.ayatList.isNotEmpty
                      ? ListView.builder(
                        itemBuilder: (context, index) {
                          var ayatList = _resultController.ayatList[index];
                          // ayatList.searchKey = suraModel.searchKey!;
                          return WordResultItem(ayatList);
                        },
                        itemCount: _resultController.ayatList.length,
                      )
                      : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
