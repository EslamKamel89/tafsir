import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tafsir/dialogs/custom_snack_bar.dart';
import 'package:tafsir/models/tag_model.dart';
import 'package:tafsir/utils/api_service/dio_consumer.dart';
import 'package:tafsir/utils/constants.dart';
import 'package:tafsir/utils/get_locale_api.dart';
import 'package:tafsir/utils/is_internet_available.dart';
import 'package:tafsir/utils/print_helper.dart';
import 'package:tafsir/utils/response_state_enum.dart';
import 'package:tafsir/utils/servicle_locator.dart';

class GetTagController extends GetxController {
  ResponseState responseState = ResponseState.initial;

  final getTagEndpoint = "get-tag";

  Future<TagModel?> getTag({required int id}) async {
    if (!(await isInternetAvailable())) {
      Future.delayed(const Duration(milliseconds: 100)).then((value) => update());
      showCustomSnackBarNoInternet();
      return await getCachedTag(id: id.toString());
    }
    update();
    return await getTagApi(id: id);
  }

  Future<TagModel?> getTagApi({required int id}) async {
    const t = 'getTagApi - GetTagController';
    DioConsumer dioConsumer = serviceLocator();
    String path = baseUrl + getTagEndpoint;
    String deviceLocale = getLocaleApi();
    responseState = ResponseState.loading;
    update();
    try {
      if (!(await isInternetAvailable())) {
        showCustomSnackBarNoInternet();
      }
      final response = await dioConsumer.get("$path/$id/$deviceLocale");
      Map<String, dynamic> data = jsonDecode(response);
      pr(data, '$t - raw response');
      TagModel tag = TagModel.fromJson(data);
      pr(tag, '$t - parsed response');
      responseState = ResponseState.success;
      cacheTag(tagModel: tag);
      update();
      return tag;
    } on Exception catch (e) {
      pr('Exception occured: $e', t);
      responseState = ResponseState.failed;
      update();
      return null;
    }
  }

  Future<void> cacheTag({required TagModel tagModel}) async {
    SharedPreferences sharedPreferences = serviceLocator<SharedPreferences>();

    sharedPreferences.setString(
      tagDetailsKey + tagModel.id.toString(),
      jsonEncode(tagModel.toJson()),
    );
  }

  Future<TagModel?> getCachedTag({required String id}) async {
    SharedPreferences sharedPreferences = serviceLocator<SharedPreferences>();
    return TagModel.fromJson(jsonDecode(sharedPreferences.getString(tagDetailsKey + id) ?? ''));
  }
}
