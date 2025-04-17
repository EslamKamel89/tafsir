// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tafsir/utils/api_service/dio_consumer.dart';
import 'package:tafsir/utils/constants.dart';
import 'package:tafsir/utils/get_locale_api.dart';
import 'package:tafsir/utils/is_internet_available.dart';
import 'package:tafsir/utils/print_helper.dart';
import 'package:tafsir/utils/response_state_enum.dart';
import 'package:tafsir/utils/servicle_locator.dart';

class ExplanationController extends GetxController {
  static const String _domainLink = "https://ioqs.org/control-panel/api/v1/";
  static const String _ayah = "ayah";
  String? explanation;
  ResponseState responseState = ResponseState.initial;
  final DioConsumer dioConsumer;
  ExplanationController({this.explanation, required this.dioConsumer});
  Future<String?> getExplanation({required String id}) async {
    const t = 'getExplanation - ExplanationController ';
    String path = _domainLink;
    String deviceLocale = getLocaleApi();
    path += "$_ayah/$id/$deviceLocale";
    responseState = ResponseState.loading;
    try {
      if (!(await isInternetAvailable())) {
        update();
        return await getCachedExplanation(id: id);
      }
      final response = await dioConsumer.get(path);
      String? explanation = jsonDecode(response)['explanation'];
      if (explanation != null) {
        pr(response, t);
        responseState = ResponseState.success;
        await cacheExplanation(id: id, explanation: explanation);
        update();
        return explanation;
      }
      pr('No explanation for this ayah: $id', t);
      responseState = ResponseState.success;
      update();
      return null;
    } on Exception catch (e) {
      pr('Exeption occured: $e', t);
      responseState = ResponseState.failed;
      update();
      return null;
    }
  }

  Future<void> cacheExplanation({required String id, required String explanation}) async {
    SharedPreferences sharedPreferences = serviceLocator<SharedPreferences>();
    sharedPreferences.setString(ayahExplanationKey + id, explanation);
  }

  Future<String> getCachedExplanation({required String id}) async {
    SharedPreferences sharedPreferences = serviceLocator<SharedPreferences>();
    return sharedPreferences.getString(ayahExplanationKey + id) ?? '';
  }
}
