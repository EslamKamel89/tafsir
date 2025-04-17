import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:tafsir/db/database_helper.dart';
import 'package:tafsir/dialogs/custom_snack_bar.dart';
import 'package:tafsir/models/sura_search_model.dart';
import 'package:tafsir/utils/api_service/dio_consumer.dart';
import 'package:tafsir/utils/constants.dart';
import 'package:tafsir/utils/get_locale_api.dart';
import 'package:tafsir/utils/is_internet_available.dart';
import 'package:tafsir/utils/print_helper.dart';
import 'package:tafsir/utils/response_state_enum.dart';
import 'package:tafsir/utils/servicle_locator.dart';

class WordSearchController extends GetxController {
  var resultList = <SuraSearchModel>[].obs;
  var loading = false.obs;
  var wordCount = '0'.obs;
  int sum = 0;
  var searchKey = '';
  //? api properties
  ResponseState searchWordResponseState = ResponseState.initial;
  final searchWordEndpoint = "search-word";

  void search(String key) async {
    if (key.isEmpty) {
      return;
    }
    if (!(await isInternetAvailable())) {
      showCustomSnackBarNoInternet();
      return;
    }
    log('Search Key $key');
    resultList.clear();
    sum = 0;
    searchKey = key;
    wordCount.value = sum.toString();
    loading.value = true;
    update();
    resultList.value = await DataBaseHelper.dataBaseInstance().searchByWord(key);
    // resultList.value = await searchApi(key);
    for (var e in resultList) {
      sum += e.count!;
    }
    wordCount.value = sum.toString();
    loading.value = false;
    update();
  }

  Future<List<SuraSearchModel>> searchApi(String key) async {
    const t = "searchApi  - WordSearchController";
    pr(key, '$t - key');
    DioConsumer dioConsumer = serviceLocator();
    String deviceLocale = getLocaleApi();
    String path = '$baseUrl$searchWordEndpoint/$key';
    searchWordResponseState = ResponseState.loading;
    try {
      final response = await dioConsumer.get(path);
      List data = jsonDecode(response);
      pr(data, '$t - raw response');
      if (data.isEmpty) {
        searchWordResponseState = ResponseState.success;
        pr('No Search Result found', t);
        return [];
      }
      List<SuraSearchModel> results =
          data.map<SuraSearchModel>((json) {
            var result = SuraSearchModel.fromJson(json);
            result.searchKey = key;
            return result;
          }).toList();
      pr(results, '$t - parsed response');
      searchWordResponseState = ResponseState.success;
      return results;
    } on Exception catch (e) {
      pr('Exception occured: $e', t);
      searchWordResponseState = ResponseState.failed;
      // update();
      return [];
    }
  }
}
