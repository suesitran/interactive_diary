part of 'tab_screen_impl_test.dart';

class TestTabScreenBlank extends TabScreen {
  const TestTabScreenBlank({Key? key}) : super(key: key);

  @override
  List<TabScreenContent> buildTabScreenContent() => [
        TabScreenContent(
            const BottomNavigationBarItem(
                label: 'Home', icon: Icon(Icons.home)),
            const Center(
              child: Text('Page 1'),
            )),
        TabScreenContent(
            const BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
            const Center(child: Text('Page 2')))
      ];
}

class TestTabScreenWithFloatingButton extends TestTabScreenBlank {
  final FloatingActionButtonLocation floatingActionButtonLocation;

  const TestTabScreenWithFloatingButton(
      {Key? key,
      this.floatingActionButtonLocation =
          FloatingActionButtonLocation.centerDocked})
      : super(key: key);

  @override
  List<TabScreenContent> buildTabScreenContent() => [
        TabScreenContent(
            const BottomNavigationBarItem(
                label: 'Home', icon: Icon(Icons.home)),
            const Center(
              child: Text('Page 1'),
            )),
        TabScreenContent(
            const BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
            const Center(child: Text('Page 2')))
      ];

  @override
  FloatingActionButtonConfig? floatingActionButtonConfig(BuildContext context) {
    return FloatingActionButtonConfig(
        button: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.ac_unit),
        ),
        location: floatingActionButtonLocation);
  }

  @override
  List<ScreenAction>? appBarActions(BuildContext context) =>
      <ScreenAction>[ScreenAction(onPress: () {}, label: 'Action')];

  @override
  String? title(BuildContext context) => 'Title';
}
