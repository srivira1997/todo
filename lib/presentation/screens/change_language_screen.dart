import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';
import 'package:todo/core/constants/app_colors.dart';
import 'package:todo/localization/locale_provider.dart';
import 'package:todo/presentation/widgets/cards/primary_card.dart';
import 'package:todo/presentation/widgets/text/primary_text.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LocaleController localeController = Get.find();

    Map<String, String> languageNames = {
      'en': 'English',
      'es': 'Spanish',
      'fr': 'French',
      'de': 'German',
      'zh': 'Chinese',
      'ar': "العربية",
      // Add more languages as needed
    };

    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appPrimaryColor,
        title: PrimaryText(text: AppLocalizations.of(context)!.changelang),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: AppLocalizations.supportedLocales.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              localeController.changeLocale(
                  AppLocalizations.supportedLocales[index].languageCode);
              Get.back();
            },
            child: PrimaryCard(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryText(
                      text: languageNames[AppLocalizations
                              .supportedLocales[index].languageCode
                              .toString()] ??
                          "")
                ],
              ).paddingAll(16),
            ),
          );
        },
      ),
    );
  }
}
