import 'package:chat_app/core/router/app_router.dart';
import 'package:chat_app/core/translation/intl/app_localizations.dart';
import 'package:flutter/material.dart';

S get lang {
  return S.of(navigatorKey.currentContext!)!;
}

class L10n {
  static final all = [
    const Locale('en'),
  ];
}
