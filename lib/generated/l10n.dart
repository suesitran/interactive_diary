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

class IDLocalisation {
  IDLocalisation();

  static IDLocalisation? _current;

  static IDLocalisation get current {
    assert(_current != null,
        'No instance of IDLocalisation was loaded. Try to initialize the IDLocalisation delegate before accessing IDLocalisation.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<IDLocalisation> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = IDLocalisation();
      IDLocalisation._current = instance;

      return instance;
    });
  }

  static IDLocalisation of(BuildContext context) {
    final instance = IDLocalisation.maybeOf(context);
    assert(instance != null,
        'No instance of IDLocalisation present in the widget tree. Did you add IDLocalisation.delegate in localizationsDelegates?');
    return instance!;
  }

  static IDLocalisation? maybeOf(BuildContext context) {
    return Localizations.of<IDLocalisation>(context, IDLocalisation);
  }

  /// `Something wrong happened. Please try again later`
  String get errorSomethingWrongHappened {
    return Intl.message(
      'Something wrong happened. Please try again later',
      name: 'errorSomethingWrongHappened',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Interactive Dairy`
  String get idWelcome {
    return Intl.message(
      'Welcome to Interactive Dairy',
      name: 'idWelcome',
      desc: '',
      args: [],
    );
  }

  /// `Let's join us to create your journey`
  String get screenSignUpIntroduction {
    return Intl.message(
      'Let\'s join us to create your journey',
      name: 'screenSignUpIntroduction',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Google`
  String get btnSignInGoogle {
    return Intl.message(
      'Continue with Google',
      name: 'btnSignInGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Apple`
  String get btnSignInApple {
    return Intl.message(
      'Continue with Apple',
      name: 'btnSignInApple',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signup {
    return Intl.message(
      'Sign Up',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `Sign Ip`
  String get signin {
    return Intl.message(
      'Sign Ip',
      name: 'signin',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<IDLocalisation> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<IDLocalisation> load(Locale locale) => IDLocalisation.load(locale);
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
