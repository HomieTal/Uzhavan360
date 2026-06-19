import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state_controller.dart';

extension AppLocalizationX on BuildContext {
  String tr(String key, {Map<String, String> args = const {}}) {
    return read<AppStateController>().tr(key, args: args);
  }
}