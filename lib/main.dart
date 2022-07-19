import 'package:flutter/services.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:home_planner/features/signin/sign_in_screen.dart';
import 'package:home_planner/route/map_route.dart' as routes;

void main() async {
  runApp(App(
    home: const SignInScreen(),
    title: 'Home Planner',
    theme: Theme(
      primaryColor: Colors.deepOrange
    ),
    routes: routes.appRoute,
  ));
}