import 'package:flutter/material.dart';

extension RouterExtension on BuildContext {
  /// Add all path to this extension, and keep all GoRouter within this class
  /// example:
  /// void goToLoginPage() {
  ///   GoRouter.of(this).replace('/login');
  /// }
}