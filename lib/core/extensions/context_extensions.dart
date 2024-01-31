import 'package:boilerplate/generated/l10n.dart';
import 'package:flutter/material.dart';

extension StateThemeExtension on BuildContext {
  S get locatization => S.of(this);
}
