import 'package:flutter/material.dart';

import 'package:interactive_diary/features/home/interactive_diary_main_screen.dart';

const String mainRoute = 'main_route';

final Map<String, WidgetBuilder> appRoute = {
  mainRoute: (context) => const InteractiveDiaryMainScreen()
};
