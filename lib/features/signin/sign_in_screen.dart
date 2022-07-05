import 'package:flutter/material.dart';
import 'package:home_planner/platforms/designs.dart';
import 'package:home_planner/route/map_route.dart' as Routes;

class SignInScreen extends Screen {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Anonymous Sign In for now'),
          TextButton(
              onPressed: () => Navigator.of(context)
                  .pushReplacementNamed(Routes.mainRoute),
              child: const Text('Go to Main'))
        ],
      ),
    );
  }
}
