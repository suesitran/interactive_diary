import 'package:flutter/material.dart';
import 'package:interactive_diary/route/map_route.dart';

extension RouterExtension on BuildContext {
  /// Add all path to this extension, and keep all GoRouter within this class
  /// example:
  /// void goToLoginPage() {
  ///   GoRouter.of(this).replace('/login');
  /// }
  ///

  void gotoWriteDiaryScreen() {
    GoRouter.of(this).go(writeDiaryRoute);
  }
}