import 'package:nartus_ui_package/nartus_ui.dart';

class InteractiveDiaryMainScreen extends TabScreen {
  const InteractiveDiaryMainScreen({Key? key}) : super(key: key);

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

}
