import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tafsir/dialogs/custom_snack_bar.dart';
import 'package:tafsir/models/article_model.dart';
import 'package:tafsir/utils/api_service/dio_consumer.dart';
import 'package:tafsir/utils/constants.dart';
import 'package:tafsir/utils/get_locale_api.dart';
import 'package:tafsir/utils/is_internet_available.dart';
import 'package:tafsir/utils/print_helper.dart';
import 'package:tafsir/utils/response_state_enum.dart';
import 'package:tafsir/utils/servicle_locator.dart';

class GetArticleController extends GetxController {
  ResponseState responseState = ResponseState.initial;

  final getArticleEndpoint = "get-article";

  Future<ArticleModel?> getArticle({required int id}) async {
    if (!(await isInternetAvailable())) {
      Future.delayed(const Duration(milliseconds: 100)).then((value) => update());
      showCustomSnackBarNoInternet();
      return getCachedArticle(id: id.toString());
    }
    update();
    return await getArticleApi(id: id);
  }

  Future<ArticleModel?> getArticleApi({required int id}) async {
    const t = 'getArticleApi - GetArticleController';
    DioConsumer dioConsumer = serviceLocator();
    String path = baseUrl + getArticleEndpoint;
    String deviceLocale = getLocaleApi();
    responseState = ResponseState.loading;
    update();
    try {
      final response = await dioConsumer.get("$path/$id/$deviceLocale");
      Map<String, dynamic> data = jsonDecode(response);
      pr(data, '$t - raw response');
      ArticleModel article = ArticleModel.fromJson(data);
      pr(article, '$t - parsed response');
      responseState = ResponseState.success;
      cacheArticle(articleModel: article);
      update();
      return article;
    } on Exception catch (e) {
      pr('Exception occured: $e', t);
      responseState = ResponseState.failed;
      update();
      return null;
    }
  }

  Future<void> cacheArticle({required ArticleModel articleModel}) async {
    SharedPreferences sharedPreferences = serviceLocator<SharedPreferences>();
    sharedPreferences.setString(
      articleDetailsKey + articleModel.id.toString(),
      jsonEncode(articleModel.toJson()),
    );
  }

  Future<ArticleModel?> getCachedArticle({required String id}) async {
    SharedPreferences sharedPreferences = serviceLocator<SharedPreferences>();
    return ArticleModel.fromJson(
      jsonDecode(sharedPreferences.getString(articleDetailsKey + id) ?? ''),
    );
  }
}
