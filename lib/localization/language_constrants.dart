import 'package:flutter/material.dart';

import 'app_localization.dart';

String getTranslated(@required String key, BuildContext context) {
  return AppLocalization.of(context)!.translate(key);
}