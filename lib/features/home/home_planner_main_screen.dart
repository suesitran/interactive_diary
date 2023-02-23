// ignore_for_file: avoid_print

import 'package:nartus_ui_package/nartus_ui.dart';

class HomePlannerMainScreen extends TabScreen {
  const HomePlannerMainScreen({Key? key}) : super(key: key);

  @override
  List<TabScreenContent> buildTabScreenContent() => <TabScreenContent>[
        TabScreenContent(
          const BottomNavigationBarItem(
              icon: Icon(Icons.home_filled), label: 'Home'),
          const Center(
            child: Text('page 1'),
          ),
        ),
        TabScreenContent(
            const BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
            const Center(
              child: Text('Page 2'),
            ))
      ];

  @override
  FloatingActionButtonConfig? floatingActionButtonConfig(BuildContext context) {
    return FloatingActionButtonConfig(
        button: FloatingActionButton(
          child: const Icon(Icons.plus_one),
          onPressed: () {
            print("tap on floating button");
          },
        ),
        location: FloatingActionButtonLocation.endTop);
  }
}
