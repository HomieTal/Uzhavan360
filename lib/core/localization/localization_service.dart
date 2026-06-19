import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocalizationService {
  final Map<String, Map<String, String>> _translations = {};

  Future<void> load() async {
    for (final code in ['en', 'ta']) {
      final jsonString = await rootBundle.loadString('assets/i18n/$code.json');
      final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
      _translations[code] = decoded.map((key, value) => MapEntry(key, value.toString()));
    }
  }

  String translate(Locale locale, String key, {Map<String, String> args = const {}}) {
    final bundle = _translations[locale.languageCode] ?? _translations['en'] ?? const {};
    var value = bundle[key] ?? key;
    for (final entry in args.entries) {
      value = value.replaceAll('{${entry.key}}', entry.value);
    }
    return value;
  }
}