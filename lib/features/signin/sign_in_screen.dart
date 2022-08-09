import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:interactive_diary/route/map_route.dart' as routes;

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
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed(routes.mainRoute),
              child: const Text('Go to Main'))
        ],
      ),
    );
  }

  @override
  FloatingActionButtonConfig floatingActionButtonConfig(BuildContext context) =>
      FloatingActionButtonConfig(
          button: FloatingActionButton(
              child: const Icon(Icons.plus_one), onPressed: () {}),
          location: FloatingActionButtonLocation.endTop);
}
