import 'dart:developer';

import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:tafsir/db/database_helper.dart';
import 'package:tafsir/models/video_model.dart';

class DialogWordTagController extends GetxController {
  var videoUrl = ''.obs;
  var wordName = ''.obs;
  var description = ''.obs;
  var videoModels = <VideoModel>[].obs;

  void getTagVideo(String tagId, int wordId) async {
    var values = await DataBaseHelper.dataBaseInstance().getTagVideo(tagId);
    videoUrl.value = await DataBaseHelper.dataBaseInstance().videoUrlWord(wordId);
    wordName.value = values['name'].toString();
    description.value = _parseHtmlString(values['desc'].toString());
    log('values = ${description.value}');
    getTagVideos(int.parse(tagId));
  }

  void getTagVideos(int tagId) async {
    videoModels.value = await DataBaseHelper.dataBaseInstance().tagsVideos(tagId);
    update();
  }

  String _parseHtmlString(String htmlString) {
    return htmlString;
    final document = parse(htmlString);
    final String parsedString = parse(document.body!.text).documentElement!.text;
    return parsedString;
  }
}
