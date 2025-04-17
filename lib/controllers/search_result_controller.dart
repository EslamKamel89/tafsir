import 'dart:developer';

import 'package:get/get.dart';
import 'package:tafsir/db/database_helper.dart';
import 'package:tafsir/models/sura_search_result_model.dart';

class SearchResultController extends GetxController {
  var ayatList = <List<SuraSearchResultModel>>[].obs;

  void getDetails(int suraId, String key) async {
    ayatList.value = await DataBaseHelper.dataBaseInstance().getDetails(suraId, key);
    log('Full Sura $ayatList');
    update();
  }
}
