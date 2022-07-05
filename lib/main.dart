import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:home_planner/platforms/designs.dart';
import 'package:home_planner/features/signin/sign_in_screen.dart';
import 'package:home_planner/route/map_route.dart' as routes;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoApp(
        title: 'Home Planner',
        theme: CupertinoThemeData(
          brightness: MediaQueryData.fromWindow(WidgetsBinding.instance.window).platformBrightness ,
          primaryColor: Colors.deepOrange
        ),
        routes: routes.appRoute,
        home: const SignInScreen(),
      );
    }

    return MaterialApp(
      title: 'Home Planner',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark, primarySwatch: Colors.deepOrange),
      home: const SignInScreen(),
      routes: routes.appRoute,
    );
  }
}
