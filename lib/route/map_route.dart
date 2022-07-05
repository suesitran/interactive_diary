import 'package:flutter/material.dart';

import 'package:home_planner/features/home/home_planner_main_screen.dart';

const String mainRoute = 'main_route';

final Map<String, WidgetBuilder> appRoute = {
  mainRoute: (context) => const HomePlannerMainScreen()
};
