import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:interactive_diary/features/signin/sign_in_screen.dart';
import 'package:interactive_diary/route/map_route.dart' as routes;
import 'package:firebase_core/firebase_core.dart';
import 'package:interactive_diary/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(App.adaptive(
    home: const SignInScreen(),
    title: 'Interactive Diary',
    theme: Theme(primaryColor: Colors.deepOrange),
    routes: routes.appRoute,
  ));
}
