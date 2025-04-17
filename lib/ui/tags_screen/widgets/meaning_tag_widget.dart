import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafsir/controllers/tags_screen_controller.dart';
import 'package:tafsir/ui/tag_details_screen.dart';
import 'package:tafsir/utils/response_state_enum.dart';
import 'package:tafsir/utils/text_styles.dart';
import 'package:tafsir/widgets/search_widget.dart';
import 'package:tafsir/widgets/tag_item_widget.dart';

class MeaningTagsWidgt extends StatefulWidget {
  const MeaningTagsWidgt({super.key});

  @override
  State<MeaningTagsWidgt> createState() => MeaningTagsWidgtState();
}

class MeaningTagsWidgtState extends State<MeaningTagsWidgt> {
  final TagsScreenController _tagsController = Get.find<TagsScreenController>();

  late TextEditingController _textEditingController;
  @override
  void initState() {
    TagsScreenData.filteredMeaningList = TagsScreenData.tagsMeaningList;
    if (TagsScreenData.tagsMeaningList.isEmpty) {
      _tagsController.getTags(tagType: TagType.meaning);
    }
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _textEditingController.addListener(() {
      _tagsController.search(
        key: _textEditingController.text.toString().toLowerCase(),
        tagType: TagType.meaning,
      );
    });
    return GetBuilder<TagsScreenController>(
      builder: (context) {
        return _tagsController.responseState == ResponseState.loading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    children: [
                      SearchWidget(_textEditingController, null, () {
                        _tagsController.search(
                          key: _textEditingController.text.toString().toLowerCase(),
                          tagType: TagType.meaning,
                        );
                      }),
                      TagsScreenData.filteredMeaningList.isEmpty
                          ? Center(child: LocalizedText("NO_DATA".tr))
                          : const SizedBox(),
                    ],
                  );
                }
                index--;
                return TagItemWidget(
                  TagsScreenData.filteredMeaningList[index],
                  const TagDetailsScreen(),
                );
              },
              itemCount: TagsScreenData.filteredMeaningList.length + 1,
            );
      },
    );
  }
}
