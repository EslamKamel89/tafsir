import 'package:get/get.dart';

String getLocaleApi() {
  var locale = Get.locale?.languageCode ?? 'ar';
  if (locale == 'es') locale = 'sp';
  return locale;
}
