import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:device_preview/device_preview.dart';
import 'package:tafsir/db/database_helper.dart';
import 'package:tafsir/ui/about_app_screen.dart';
import 'package:tafsir/ui/add_comment.dart';
import 'package:tafsir/ui/add_research.dart';
import 'package:tafsir/ui/artice_details_screen.dart';
import 'package:tafsir/ui/articles_screen/articles_screen.dart';
import 'package:tafsir/ui/audio_recitations_screen.dart';
import 'package:tafsir/ui/competition_screen.dart';
import 'package:tafsir/ui/home_sura_screen.dart';
import 'package:tafsir/ui/intro_screen.dart';
import 'package:tafsir/ui/join_competition_screen.dart';
import 'package:tafsir/ui/read_full_sura_screen/read_full_sura_screen.dart';
import 'package:tafsir/ui/search_result_screen.dart';
import 'package:tafsir/ui/select_language_screen.dart';
import 'package:tafsir/ui/setting_screen.dart';
import 'package:tafsir/ui/splash_screen.dart';
import 'package:tafsir/ui/tag_details_screen.dart';
import 'package:tafsir/ui/tags_screen/tags_screen.dart';
import 'package:tafsir/ui/video_player_screen.dart';
import 'package:tafsir/ui/video_screen/videos_screen.dart';
import 'package:tafsir/utils/audio_folders.dart';
import 'package:tafsir/utils/constants.dart';
import 'package:tafsir/utils/current_locales.dart';
import 'package:tafsir/utils/initialize_get_controllers.dart';
import 'package:tafsir/utils/servicle_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  await GetStorage.init();
  DataBaseHelper.dataBaseInstance();
  GetStorage().read(KpageBg);
  GetStorage().read(KnormalFontColor);
  GetStorage().read(KtagWordsColor);
  log('Strorageeg ${GetStorage().read(KreadWordsColor)}');
  await DataBaseHelper().initDb(); // Init DataBase
  await DataBaseHelper.dataBaseInstance().suraIndex();
  runApp(const DlalatQuran());
}

class DlalatQuran extends StatefulWidget {
  static final AudioPlayer mainAudioPlayer = AudioPlayer();

  const DlalatQuran({super.key});

  @override
  State<DlalatQuran> createState() => _DlalatQuranState();
}

class _DlalatQuranState extends State<DlalatQuran> {
  @override
  void initState() {
    initializeGetController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AudioFolders().checkStoragePermission();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Update

    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          foregroundColor: Colors.white, // 2
        ),
      ),
      locale:
          GetStorage().read(language) != null
              ? Locale(GetStorage().read(language))
              // : Get.deviceLocale,
              : const Locale('ar'),
      // locale: const Locale('ar'),
      translations: CurrentLocales(),
      debugShowCheckedModeBanner: false,
      title: 'دلالات القرآن',
      home: const SplashScreen(),
      getPages: [
        GetPage(name: SelectLanguageScreen.id, page: () => SelectLanguageScreen()),
        GetPage(name: SplashScreen.id, page: () => const SplashScreen()),
        GetPage(name: IntroScreen.id, page: () => const IntroScreen()),
        GetPage(name: ArticlesScreen.id, page: () => const ArticlesScreen()),
        GetPage(name: ArticleDetailsScreen.id, page: () => const ArticleDetailsScreen()),
        // GetPage(
        //   name: VideoCategoriesScreen.id,
        //   page: () => VideoCategoriesScreen(),
        // ),
        GetPage(name: TagsScreen.id, page: () => const TagsScreen()),
        GetPage(name: TagDetailsScreen.id, page: () => const TagDetailsScreen()),
        GetPage(name: SettingScreen.id, page: () => SettingScreen()),
        GetPage(name: AboutAppScreen.id, page: () => const AboutAppScreen()),
        // GetPage(
        //   name: VideoLibraryScreen.id,
        //   page: () => VideoLibraryScreen(),
        // ),
        GetPage(name: AudioRecitationsScreen.id, page: () => AudioRecitationsScreen()),
        GetPage(name: VideoPlayerScreen.id, page: () => const VideoPlayerScreen(videoId: "")),
        GetPage(name: HomeSuraScreen.id, page: () => const HomeSuraScreen()),
        GetPage(name: SearchResultScreen.id, page: () => SearchResultScreen()),
        GetPage(name: AddCommentView.id, page: () => const AddCommentView()),
        GetPage(name: AddResearchView.id, page: () => const AddResearchView()),
        GetPage(name: CompetitionsScreen.id, page: () => const CompetitionsScreen()),
        GetPage(name: JoinCompetitonView.id, page: () => JoinCompetitonView()),
        GetPage(name: VideosScreen.id, page: () => const VideosScreen()),
        GetPage(name: ReadFullSuraScreen.id, page: () => const ReadFullSuraScreen()),
        // GetPage(
        //   name: AudioPlayerScreen.id,
        //   page: () => const AudioPlayerScreen(),
        // ),
      ],
    );
  }
}
