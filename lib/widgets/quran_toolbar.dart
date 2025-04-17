// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafsir/ui/home_sura_screen.dart';
import 'package:tafsir/ui/intro_screen.dart';
import 'package:tafsir/ui/setting_screen.dart';
import 'package:tafsir/utils/colors.dart';
import 'package:tafsir/utils/constants.dart';

class QuranBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final void Function()? backCallback;
  const QuranBar(this.title, {super.key, this.backCallback});

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(title), backgroundColor: primaryColor);
    return AppBar(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      title: Text(title, style: const TextStyle(color: Colors.white, fontFamily: 'Almarai')),
      centerTitle: true,
      leading:
          backCallback == null
              ? null
              : IconButton(onPressed: backCallback, icon: const Icon(Icons.arrow_back_ios)),
      flexibleSpace: Stack(
        children: [
          Container(
            width: Get.width,
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            height: 120,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Image.asset(toolBarBackImage, fit: BoxFit.cover),
            ),
          ),
        ],
      ),
      backgroundColor: lightGray,
      actions: [
        SizedBox(
          width: 40,
          height: 40,
          child: InkWell(
            onTap: () {
              Get.offAll(const IntroScreen());
              Get.to(const HomeSuraScreen());
            },
            customBorder: const CircleBorder(),
            child: const Icon(Icons.menu_book, size: 25),
          ),
        ),
        SizedBox(
          width: 40,
          height: 40,
          child: InkWell(
            onTap: () {
              Get.back();
              Get.to(SettingScreen());
            },
            customBorder: const CircleBorder(),
            child: const Icon(Icons.settings, size: 25),
          ),
        ),
        SizedBox(
          width: 40,
          height: 40,
          child: InkWell(
            onTap: () => Get.offAll(const IntroScreen()),
            customBorder: const CircleBorder(),
            child: const Icon(Icons.home_outlined, size: 25),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size(Get.width, isSmallScreen ? 50 : 60);
}
