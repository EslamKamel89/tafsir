import 'dart:convert';

import 'package:get/get.dart';
import 'package:tafsir/db/database_helper.dart';
import 'package:tafsir/models/video_model.dart';
import 'package:tafsir/utils/api_service/dio_consumer.dart';
import 'package:tafsir/utils/constants.dart';
import 'package:tafsir/utils/get_locale_api.dart';
import 'package:tafsir/utils/print_helper.dart';
import 'package:tafsir/utils/response_state_enum.dart';
import 'package:tafsir/utils/servicle_locator.dart';

abstract class VideoControllerData {
  static List<VideoModel> allVideos = [];
  static List<VideoModel> filteredVideosList = [];
}

class VideoController extends GetxController {
  final DataBaseHelper databaseHelper = DataBaseHelper.dataBaseInstance();
  String getVidoesEndPoin = 'videos';
  ResponseState responseState = ResponseState.initial;

  Future<void> getAllVideos() async {
    VideoControllerData.allVideos = [];
    // VideoControllerData.allVideos = await databaseHelper.getAllVideosRaw();
    await getAllVideosApi();
    // VideoControllerData.allVideos = VideoControllerData.allVideos.reversed.take(2).toList();
    VideoControllerData.filteredVideosList = VideoControllerData.allVideos;
    update();
  }

  void search(String key) {
    VideoControllerData.filteredVideosList =
        VideoControllerData.allVideos
            .where((x) => x.toString().toLowerCase().trim().contains(key.toLowerCase()))
            .toList();
    update();
  }

  Future getAllVideosApi() async {
    const t = 'getAllVideosApi - VideoController';
    DioConsumer dioConsumer = serviceLocator();
    String path = baseUrl + getVidoesEndPoin;
    String deviceLocale = getLocaleApi();
    responseState = ResponseState.loading;
    update();
    try {
      final response = await dioConsumer.get("$path/0/999999999/$deviceLocale");
      List data = jsonDecode(response);
      pr(data, '$t - raw response');
      if (data.isEmpty) {
        responseState = ResponseState.success;
        pr('No tags found', t);
        VideoControllerData.allVideos = [];
        VideoControllerData.filteredVideosList = [];
        update();
        return;
      }
      // await cacheExplanation(id: id, explanation: explanation);
      List<VideoModel> videos = data.map<VideoModel>((json) => VideoModel.fromJson(json)).toList();
      pr(videos, '$t - parsed response');
      responseState = ResponseState.success;
      VideoControllerData.allVideos = videos;
      VideoControllerData.filteredVideosList = videos;
      update();
      return;
    } on Exception catch (e) {
      pr('Exception occured: $e', t);
      responseState = ResponseState.failed;
      VideoControllerData.allVideos = [];
      VideoControllerData.filteredVideosList = [];
      update();
      return;
    }
  }
}
