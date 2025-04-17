// import 'package:tafsir/controllers/correct_word_controller.dart';
// import 'package:tafsir/controllers/similar_word_controller.dart';
// import 'package:tafsir/ui/add_research.dart';
// import 'package:tafsir/ui/articles_screen/articles_screen.dart';
// import 'package:tafsir/ui/competition_screen.dart';
// import 'package:tafsir/ui/home_sura_screen.dart';
// import 'package:tafsir/ui/read_full_sura_screen/read_full_sura_screen.dart';
// import 'package:tafsir/ui/setting_screen.dart';
// import 'package:tafsir/ui/tags_screen/tags_screen.dart';
// import 'package:tafsir/ui/video_screen/videos_screen.dart';
// import 'package:tafsir/utils/constants.dart';
// import 'package:tafsir/utils/text_styles.dart';
// import 'package:tafsir/widgets/splash_background.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// class IntroScreen extends StatefulWidget {
//   static var id = '/IntroScreen';

//   const IntroScreen({super.key});

//   @override
//   State<IntroScreen> createState() => _IntroScreenState();
// }

// class _IntroScreenState extends State<IntroScreen> {
//   @override
//   void initState() {
//     Get.find<SimilarWordController>().getSimilarWords();
//     Get.find<CorrectWordController>().getCorrectWords();
//     // getPermissionRequest();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // pr('database deleted');
//     // deleteDatabase('dlalat_qurann.db');
//     // pr('sharedPreferences cleared');
//     // serviceLocator<SharedPreferences>().clear();
//     var itemSize = (MediaQuery.of(context).size.width - 80) / 3;
//     var scHeight = Get.height;
//     var scWidth = Get.width;
//     // Get.find<ReadFullSurahController>().playFullSura('An-Nas');
//     return Stack(
//       children: [
//         SplashBackground(
//             childWidget: Container(
//           padding: EdgeInsets.only(top: itemSize / 1.3),
//           child: Column(
//             children: [
//               Image.asset(
//                 logoSmall,
//                 width: scHeight / 8,
//                 height: scHeight / 8,
//               ),
//               Text(
//                 'app_name'.tr,
//                 // '',
//                 textAlign: TextAlign.center,
//                 style:
//                     TextStyle(color: Colors.white, fontSize: scHeight / 40, fontFamily: 'Almarai'),
//               ),
//               const SizedBox(
//                 height: 8,
//               ),
//               Text(
//                 'introText'.tr,
//                 style: TextStyle(
//                   color: const Color(0xFFF5B45E),
//                   fontSize: scHeight / 70,
//                   fontFamily: 'Almarai',
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(
//                 height: scHeight / 20,
//               ),
//               Stack(
//                 children: [
//                   Image.asset(
//                     _centerView(),
//                     width: scHeight / 2.8,
//                     height: scHeight / 2.3,
//                   ),
//                   Positioned(
//                     left: itemSize,
//                     top: 20,
//                     child: SizedBox(
//                       width: itemSize,
//                       height: itemSize - 20,
//                       child: GestureDetector(
//                         onTap: () {
//                           int page = GetStorage().read(savedPage).toString() == 'null'
//                               ? 0
//                               : GetStorage().read(savedPage);
//                           Locale loca = Get.locale!;
//                           Widget destination;
//                           if (loca.languageCode == 'ar') {
//                             destination = const HomeSuraScreen();
//                           } else {
//                             destination = const HomeSuraScreen();
//                           }
//                           // ShortExplanationIndex();
//                           // Get.to(() => destination);
//                           Navigator.of(context)
//                               .push(MaterialPageRoute(builder: (_) => destination));
//                         },
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 20,
//                     top: itemSize - 30,
//                     child: SizedBox(
//                       width: itemSize - 20,
//                       height: itemSize - 20,
//                       child: GestureDetector(
//                         // onTap: () => Get.to(const ArticlesScreen()),
//                         onTap: () => Navigator.of(context)
//                             .push(MaterialPageRoute(builder: (_) => const ArticlesScreen())),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 20,
//                     bottom: itemSize - 15,
//                     child: SizedBox(
//                       width: itemSize - 20,
//                       height: itemSize - 20,
//                       child: GestureDetector(
//                         // onTap: () => Get.to(const TagsScreen()),
//                         onTap: () => Navigator.of(context)
//                             .push(MaterialPageRoute(builder: (_) => const TagsScreen())),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: itemSize,
//                     bottom: 15,
//                     child: SizedBox(
//                       width: itemSize,
//                       height: itemSize - 20,
//                       child: GestureDetector(
//                         // onTap: () => Get.to(SettingScreen()),
//                         onTap: () => Navigator.of(context)
//                             .push(MaterialPageRoute(builder: (_) => SettingScreen())),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     right: 20,
//                     top: itemSize - 30,
//                     child: SizedBox(
//                         width: itemSize - 20,
//                         height: itemSize - 20,
//                         child: GestureDetector(
//                           // onTap: () => Get.to(AudioRecitationsScreen(), transition: Transition.fade),
//                           onTap: () => Get.toNamed(ReadFullSuraScreen.id),
//                         )
//                         // onTap: () => Navigator.of(context)
//                         // .push(MaterialPageRoute(builder: (_) => const ReadFullSuraScreen()))),
//                         ),
//                   ),
//                   Positioned(
//                     right: 20,
//                     bottom: itemSize - 15,
//                     child: SizedBox(
//                       width: itemSize - 20,
//                       height: itemSize - 20,
//                       child: GestureDetector(
//                         // onTap: () => Get.to(VideoCategoriesScreen(), transition: Transition.fade),
//                         // onTap: () => Get.to(const VideosScreen(), transition: Transition.fade),
//                         onTap: () => Navigator.of(context)
//                             .push(MaterialPageRoute(builder: (_) => const VideosScreen())),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: itemSize,
//                     bottom: itemSize,
//                     left: itemSize,
//                     child: SizedBox(
//                       width: itemSize - 20,
//                       height: itemSize - 20,
//                       child: GestureDetector(
//                         onTap: () => print('Quraaan'),
//                       ),
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         )),
//         Positioned(
//           bottom: 30,
//           right: 0,
//           left: 0,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 50),
//             child: SizedBox(
//               // width: double,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       // Get.toNamed(CompetitionsScreen.id);
//                       Navigator.of(context).pushNamed(CompetitionsScreen.id);
//                     },
//                     child: Column(
//                       children: [
//                         Container(
//                           height: 50,
//                           width: 50,
//                           alignment: Alignment.center,
//                           child: Image.asset(
//                             "assets/images/answer_icon.png",
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         LocalizedText(
//                           "QUESTIONS".tr,
//                           color: Colors.white,
//                           fontSize: 10,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       // height: 50,
//                       margin: const EdgeInsets.only(bottom: 70),
//                       child: Image.asset("assets/images/Line.png", fit: BoxFit.cover),
//                     ),
//                   ),
//                   const SizedBox(width: 5),
//                   GestureDetector(
//                     onTap: () {
//                       // Get.toNamed(AddResearchView.id);
//                       Navigator.of(context).pushNamed(AddResearchView.id);
//                       // Get.toNamed(AudioPlayerScreen.id);
//                     },
//                     child: Column(
//                       children: [
//                         Container(
//                           height: 50,
//                           width: 50,
//                           alignment: Alignment.center,
//                           child: Image.asset(
//                             "assets/images/research_icon.png",
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         LocalizedText(
//                           "UPLOAD_RESEARCH".tr,
//                           color: Colors.white,
//                           fontSize: 10,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   String _centerView() {
//     String path = '';
//     switch (GetStorage().read(language)) {
//       case 'ar':
//         path = 'assets/images/center_view.png';
//         break;
//       // case 'en':
//       //   path = 'assets/images/center_view_en.png';
//       //   break;
//       // case 'fr':
//       //   path = 'assets/images/center_view.png';
//       //   break;
//       // case 'es':
//       //   path = 'assets/images/center_view.png';
//       //   break;
//       default:
//         path = 'assets/images/center_view_en.png';
//     }
//     return path;
//   }
// }

// const commentRequest = {
//   "model": "tags", // reciters , articles , tag_words ....
//   "modelId": "10",
//   "name": "Eslam Ahmed Kamel",
//   "phone": "01024510803",
//   "comment": "some comment",
//   "deviceLocale": "ar" // 'en' , 'es' , 'fr' ....
// };
