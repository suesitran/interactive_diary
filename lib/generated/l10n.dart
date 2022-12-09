// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Turn on your location`
  String get locationPermissionDialogTitle {
    return Intl.message(
      'Turn on your location',
      name: 'locationPermissionDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Inner ME needs permission to access your location. Please go to Settings > Privacy > Location and enable.`
  String get locationPermissionDialogMessage {
    return Intl.message(
      'Inner ME needs permission to access your location. Please go to Settings > Privacy > Location and enable.',
      name: 'locationPermissionDialogMessage',
      desc: '',
      args: [],
    );
  }

  /// `Allow`
  String get locationPermissionDialogAllowButton {
    return Intl.message(
      'Allow',
      name: 'locationPermissionDialogAllowButton',
      desc: '',
      args: [],
    );
  }

  /// `Continue with default location`
  String get locationPermissionDialogContinueButton {
    return Intl.message(
      'Continue with default location',
      name: 'locationPermissionDialogContinueButton',
      desc: '',
      args: [],
    );
  }

  /// `Go to Settings`
  String get locationPermissionDialogOpenSettingsButton {
    return Intl.message(
      'Go to Settings',
      name: 'locationPermissionDialogOpenSettingsButton',
      desc: '',
      args: [],
    );
  }

  /// `Anonymous Profile. Please login to use all features.`
  String get anonymous_profile {
    return Intl.message(
      'Anonymous Profile. Please login to use all features.',
      name: 'anonymous_profile',
      desc: '',
      args: [],
    );
  }

  /// `Whoops!`
  String get noConnectionTitle {
    return Intl.message(
      'Whoops!',
      name: 'noConnectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Slow or no internet connections.\nPlease check your internet settings`
  String get noConnectionMessage {
    return Intl.message(
      'Slow or no internet connections.\nPlease check your internet settings',
      name: 'noConnectionMessage',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Add text`
  String get addText {
    return Intl.message(
      'Add text',
      name: 'addText',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Turn on your location`
  String get locationPopupTitle {
    return Intl.message(
      'Turn on your location',
      name: 'locationPopupTitle',
      desc: '',
      args: [],
    );
  }

  /// `Screen unavailable`
  String get unavailable {
    return Intl.message(
      'Screen unavailable',
      name: 'unavailable',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, this screen is still under construction. Please come back later.`
  String get unavailableScreenDesc {
    return Intl.message(
      'Sorry, this screen is still under construction. Please come back later.',
      name: 'unavailableScreenDesc',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
