import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:tafsir/utils/colors.dart';
import 'package:tafsir/widgets/font_text.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(width: 10),
        const SizedBox(height: 15, child: SpinKitWave(size: 17, color: primaryColor)),
        const SizedBox(width: 10),
        AlMaraiText(10, 'loading'.tr),
      ],
    );
  }
}
