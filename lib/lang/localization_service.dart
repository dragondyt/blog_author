import 'dart:ui';
import 'dart:ui' as ui;
import 'package:blog_author/lang/zh_cn.dart';
import 'package:get/get.dart';

import 'en_us.dart';
import 'ja_jp.dart';

class LocalizationService extends Translations {
  // Default locale
  static final locale = ui.window.locale;

  // fallbackLocale saves the day when the locale gets in trouble
  static final fallbackLocale = Locale('tr', 'TR');

  // Supported languages
  // Needs to be same order with locales
  static final langs = [
    'English',
    'Türkçe',
    '日本語',
  ];

  // Supported locales
  // Needs to be same order with langs
  static final locales = [
    Locale('en', 'US'),
    Locale('zh', 'CN'),
    Locale('ja', 'JP'),
  ];

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': enUS, // lang/en_us.dart
    'zh_CN': zhCN, // lang/tr_tr.dart
    'ja_JP': jaJP, // lang/ja_jp.dart
  };
}