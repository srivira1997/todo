import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocaleController extends GetxController {
  var locale = const Locale('en').obs;

  //Change Local Language
  void changeLocale(String langCode) {
    var locale = Locale(langCode);
    Get.updateLocale(locale);
    this.locale.value = locale;
  }
}
