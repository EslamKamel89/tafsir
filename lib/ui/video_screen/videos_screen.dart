import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafsir/ui/video_screen/widgets/normal_videos_widget.dart';
import 'package:tafsir/ui/video_screen/widgets/series_videos_widget.dart';
import 'package:tafsir/widgets/quran_toolbar.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({super.key});

  static String id = '/VideosScreen';

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: QuranBar('VIDEOS'.tr),
        body:
        //  DefaultTabController(
        //   length: 2,
        //   child:
        Column(
          children: [
            Container(height: 5),
            // TabBar(
            //   indicatorColor: Colors.transparent,
            //   tabs: [
            //     TabButton(title: "VIDEOS".tr, selected: currentIndex == 0),
            //     TabButton(title: "SERIES".tr, selected: currentIndex == 1),
            //   ],
            //   onTap: (value) {
            //     currentIndex = value;
            //     setState(() {});
            //   },
            // ),
            Expanded(
              child:
                  currentIndex == 0 || true
                      ? const NormalVideosWidget()
                      : const SeriesVideosWidget(),
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
