import 'package:get/get.dart';
import 'package:tafsir/controllers/add_reserch_controller.dart';
import 'package:tafsir/controllers/article_series_controller.dart';
import 'package:tafsir/controllers/articles_controller.dart';
import 'package:tafsir/controllers/comment_controller.dart';
import 'package:tafsir/controllers/correct_word_controller.dart';
import 'package:tafsir/controllers/download_link_controller.dart';
import 'package:tafsir/controllers/explanation_controller.dart';
import 'package:tafsir/controllers/get_article_controller.dart';
import 'package:tafsir/controllers/get_tag_controller.dart';
import 'package:tafsir/controllers/read_aya_controller.dart';
import 'package:tafsir/controllers/settings_controller.dart';
import 'package:tafsir/controllers/similar_word_controller.dart';
import 'package:tafsir/controllers/tags_screen_controller.dart';
import 'package:tafsir/controllers/video_controller.dart';
import 'package:tafsir/controllers/video_series_controller.dart';
import 'package:tafsir/controllers/word_tag_controller.dart';
import 'package:tafsir/network/sync_manager.dart';
import 'package:tafsir/utils/servicle_locator.dart';

void initializeGetController() {
  Get.put(SyncManager()..syncData(), permanent: true);
  Get.put(CommentController(dioConsumer: serviceLocator()), permanent: true);
  Get.put(ExplanationController(dioConsumer: serviceLocator()), permanent: true);
  Get.put(AddResearchController(dioConsumer: serviceLocator()), permanent: true);
  Get.put(GetDownloadLinkController(dioConsumer: serviceLocator()), permanent: true);
  Get.put(VideoController(), permanent: true);
  Get.put(WordTagController(), permanent: true);
  Get.put(SettingsController(), permanent: true);
  Get.put(ArticlesController(), permanent: true);
  Get.put(TagsScreenController(), permanent: true);
  Get.put(ArticlesSeriesController(), permanent: true);
  Get.put(GetArticleController(), permanent: true);
  Get.put(GetTagController(), permanent: true);
  Get.put(VideosSeriesController(), permanent: true);
  Get.put(ReadAyaController(), permanent: true);
  Get.put(SimilarWordController(), permanent: true);
  Get.put(CorrectWordController(), permanent: true);
}
