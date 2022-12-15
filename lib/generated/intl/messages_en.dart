// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addText": MessageLookupByLibrary.simpleMessage("Add text"),
        "anonymous_profile": MessageLookupByLibrary.simpleMessage(
            "Anonymous Profile. Please login to use all features."),
        "appName": MessageLookupByLibrary.simpleMessage("Inner ME"),
        "back": MessageLookupByLibrary.simpleMessage("Back"),
        "locationPermissionDeniedBottomSheetDescription":
            MessageLookupByLibrary.simpleMessage(
                "Location Permission is needed to use this app. Please allow Inner ME to access location in the next dialog"),
        "locationPermissionDeniedBottomSheetTitle":
            MessageLookupByLibrary.simpleMessage(
                "Location Permission not granted"),
        "locationPermissionDialogAllowButton":
            MessageLookupByLibrary.simpleMessage("Allow"),
        "locationPermissionDialogContinueButton":
            MessageLookupByLibrary.simpleMessage(
                "Continue with default location"),
        "locationPermissionDialogMessage": MessageLookupByLibrary.simpleMessage(
            "Inner ME needs permission to access your location. Please go to Settings > Privacy > Location and enable."),
        "locationPermissionDialogOpenSettingsButton":
            MessageLookupByLibrary.simpleMessage("Go to Settings"),
        "locationPermissionDialogTitle":
            MessageLookupByLibrary.simpleMessage("Turn on your location"),
        "locationPopupTitle":
            MessageLookupByLibrary.simpleMessage("Turn on your location"),
        "noConnectionMessage": MessageLookupByLibrary.simpleMessage(
            "Slow or no internet connections.\nPlease check your internet settings"),
        "noConnectionTitle": MessageLookupByLibrary.simpleMessage("Whoops!"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "unavailable":
            MessageLookupByLibrary.simpleMessage("Screen unavailable"),
        "unavailableScreenDesc": MessageLookupByLibrary.simpleMessage(
            "Sorry, this screen is still under construction. Please come back later.")
      };
}
