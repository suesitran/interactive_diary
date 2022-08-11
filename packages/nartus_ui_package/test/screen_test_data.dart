part of 'screen_impl_test.dart';

class TestScreenBlank extends Screen {
  const TestScreenBlank({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context) => const Center(
    child: Text('Sample Test'),
  );
}

class TestScreenWithFloatingButton extends TestScreenBlank {
  const TestScreenWithFloatingButton({Key? key}) : super(key: key);

  @override
  FloatingActionButtonConfig? floatingActionButtonConfig(BuildContext context) {
    return FloatingActionButtonConfig(
        button: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.ac_unit),
        ));
  }
}

class TestScreenWithTextAction extends TestScreenBlank {
  const TestScreenWithTextAction({Key? key}) : super(key: key);

  @override
  List<ScreenAction>? appBarActions(BuildContext context) => [
    ScreenAction(onPress: () {}, label: 'action')
  ];

  @override
  String? title(BuildContext context) => 'Title';
}