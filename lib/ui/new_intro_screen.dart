import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:tafsir/ui/add_research.dart';
import 'package:tafsir/ui/articles_screen/articles_screen.dart';
import 'package:tafsir/ui/competition_screen.dart';
import 'package:tafsir/ui/home_sura_screen.dart';
import 'package:tafsir/ui/read_full_sura_screen/read_full_sura_screen.dart';
import 'package:tafsir/ui/tags_screen/tags_screen.dart';
import 'package:tafsir/ui/video_screen/videos_screen.dart';

final List<Map<String, dynamic>> sections = [
  {
    // 'name': "short_explanation",
    'name': "التفسير",
    'image': 'assets/images/quran.png',
    "callback": () {
      Get.to(() => const HomeSuraScreen());
    },
  },
  {
    'name': "الصوتيات",
    // 'name': "audio_recitations",
    'image': 'assets/images/audio.png',
    "callback": () {
      Get.toNamed(ReadFullSuraScreen.id);
    },
  },
  {
    // 'name': "ARTICLES",
    'name': "الابحاث",
    'image': 'assets/images/articles.png',
    "callback": () {
      Get.to(const ArticlesScreen());
    },
  },
  {
    // 'name': "semantics",
    'name': "المعاني",
    'image': 'assets/images/tags.png',
    "callback": () {
      Get.to(const TagsScreen());
    },
  },
  {
    // 'name': "video_library",
    'name': "مكتبة الفيديو",
    'image': 'assets/images/video_2.png',
    "callback": () {
      Get.to(const VideosScreen());
    },
  },
  // {
  //   'name': "settings",
  //   'image': 'assets/images/settings.png',
  //   "callback": () {
  //     Get.to(SettingScreen());
  //   },
  // },
  {
    // 'name': "QUESTIONS",
    'name': "أسئلة تحتاج الي اجابة",
    'image': 'assets/images/questions.png',
    "callback": () {
      Get.toNamed(CompetitionsScreen.id);
    },
  },
  {
    // 'name': "UPLOAD_RESEARCH",
    'name': "رفع بحث",
    'image': 'assets/images/research.png',
    "callback": () {
      Get.toNamed(AddResearchView.id);
    },
  },
];

class NewIntroScreenWidget extends StatefulWidget {
  const NewIntroScreenWidget({super.key});

  @override
  State<NewIntroScreenWidget> createState() => _NewIntroScreenWidgetState();
}

class _NewIntroScreenWidgetState extends State<NewIntroScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F4ED),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Logo + App Description
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: const Color(0xFFFAF3E0).withOpacity(0.2),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/logo2.png',
                        // height: 80,
                        width: double.infinity,
                      ).animate().fade().scale(duration: 800.ms),
                      // const SizedBox(height: 12),
                      // Text(
                      //   "الدلالات",
                      //   style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.brown[800],
                      //   ),
                      // ).animate().fade(duration: 600.ms).slideY(begin: 0.2),
                      // const SizedBox(height: 8),
                      // Text(
                      //   'introText'.tr,
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(color: Colors.brown[600], fontSize: 14),
                      // ).animate().fade(delay: 400.ms),
                    ],
                  ),
                ),
              ).animate().fade(duration: 600.ms).slideY(begin: 0.2),

              const SizedBox(height: 20),

              // Grid of Features
              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: sections.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, index) {
                    final section = sections[index];
                    return Container(
                      margin: EdgeInsets.only(top: [0, 1].contains(index) ? 20 : 0),
                      child: Transform.translate(
                        offset: Offset(0, index % 2 == 0 ? -10 : 10),
                        child: GestureDetector(
                          onTap: section['callback'],
                          child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(color: Colors.brown.shade100),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.brown.shade100,
                                      blurRadius: 10,
                                      offset: const Offset(2, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(section['image'], height: 40),
                                    const SizedBox(height: 12),
                                    Text(
                                      (section['name'] as String),
                                      style: TextStyle(
                                        color: Colors.brown[700],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .animate()
                              .fade(duration: 400.ms, delay: (index * 80).ms)
                              .scale(begin: const Offset(0.95, 0.95)),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
