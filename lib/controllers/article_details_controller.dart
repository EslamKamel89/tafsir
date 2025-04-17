import 'dart:convert';

import 'package:get/get.dart';
import 'package:tafsir/models/article_model.dart';
import 'package:tafsir/utils/api_service/dio_consumer.dart';
import 'package:tafsir/utils/constants.dart';
import 'package:tafsir/utils/get_locale_api.dart';
import 'package:tafsir/utils/print_helper.dart';
import 'package:tafsir/utils/response_state_enum.dart';
import 'package:tafsir/utils/servicle_locator.dart';

abstract class ArticleDetailsData {
  static List relatedArticles = [];
}

class ArticlesDetailsController extends GetxController {
  int articleId = 0;
  // var relatedArticles = [].obs;
  var selectedArticleModel = ArticleModel().obs;
  ResponseState responseState = ResponseState.initial;
  final getRelatedArticlesEndpoint = "related-articles";

  void getRelatedArticles() async {
    // ArticleDetailsData.relatedArticles = await DataBaseHelper.dataBaseInstance().relatedArticles(articleId);
    ArticleDetailsData.relatedArticles = await getRelatedArticlesApi();
    // ArticleDetailsData.relatedArticles = [];
    update();
  }

  Future<List<ArticleModel>> getRelatedArticlesApi() async {
    const t = 'getRelatedArticlesApi - ArticlesDetailsController ';
    pr(articleId, '$t - articleId');
    DioConsumer dioConsumer = serviceLocator();
    String deviceLocale = getLocaleApi();
    String path = '$baseUrl$getRelatedArticlesEndpoint/$articleId/$deviceLocale';
    responseState = ResponseState.loading;
    try {
      final response = await dioConsumer.get(path);
      List data = jsonDecode(response);
      pr(data, '$t - raw response');
      if (data.isEmpty) {
        responseState = ResponseState.success;
        pr('No related articles found', t);
        return [];
      }
      List<ArticleModel> articles =
          data.map<ArticleModel>((json) => ArticleModel.fromJson(json)).toList();
      pr(articles, '$t - parsed response');
      responseState = ResponseState.success;
      return articles;
    } on Exception catch (e) {
      pr('Exception occured: $e', t);
      responseState = ResponseState.failed;
      update();
      return [];
    }
  }

  void updateArticleModel(ArticleModel model) {
    selectedArticleModel.value = model;
    articleId = model.id!;

    update();
    getRelatedArticles();
  }

  @override
  void onClose() {
    ArticleDetailsData.relatedArticles = [];
    super.onClose();
  }
}
