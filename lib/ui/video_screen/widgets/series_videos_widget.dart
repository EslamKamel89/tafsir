import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafsir/controllers/video_series_controller.dart';
import 'package:tafsir/models/video_series_model.dart';
import 'package:tafsir/ui/video_screen/widgets/video_series_card.dart';
import 'package:tafsir/utils/response_state_enum.dart';
import 'package:tafsir/utils/text_styles.dart';
import 'package:tafsir/widgets/search_widget.dart';

class SeriesVideosWidget extends StatefulWidget {
  const SeriesVideosWidget({super.key});

  @override
  State<SeriesVideosWidget> createState() => _SeriesVideosWidgetState();
}

class _SeriesVideosWidgetState extends State<SeriesVideosWidget> {
  final VideosSeriesController _videoController =
      Get.find<VideosSeriesController>()..getVideoSeries();
  final TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    _videoController.getVideoSeries();
    _textEditingController.addListener(() {
      _videoController.search(_textEditingController.text.toString().toLowerCase());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          SearchWidget(_textEditingController, null, () {
            _videoController.search(_textEditingController.text.toString().toLowerCase());
          }),
          GetBuilder<VideosSeriesController>(
            builder: (_) {
              if (_videoController.responseState == ResponseState.loading) {
                return const Expanded(child: Center(child: CircularProgressIndicator()));
              }
              if (_videoController.responseState == ResponseState.success &&
                  VideosSeriesData.filteredList.isEmpty) {
                return const Expanded(child: Center(child: LocalizedText('لا يوجد بيانات')));
              }
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    VideoSeriesModel videoSeriesModel = VideosSeriesData.filteredList[index];
                    return VideoSeriesCard(videoSeriesModel: videoSeriesModel);
                  },
                  itemCount: VideosSeriesData.filteredList.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
