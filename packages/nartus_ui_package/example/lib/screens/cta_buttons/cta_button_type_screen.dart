part of 'cta_buttons_screen.dart';

class CtaButtonByTypesScreen extends StatelessWidget {
  const CtaButtonByTypesScreen({required this.tabsView, Key? key})
      : super(key: key);

  final List<Widget> tabsView;

  @override
  Widget build(BuildContext context) => Container();
}

class ButtonsDemoPage extends StatelessWidget {
  const ButtonsDemoPage(
      {required this.title,
      required this.defaults,
      required this.disabled,
      Key? key})
      : super(key: key);

  final String title;
  final List<Widget> defaults;
  final List<Widget> disabled;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          bottom: const TabBar(
            physics: NeverScrollableScrollPhysics(),
            tabs: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Default',
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Disabled'),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ListButtonsTab(contents: defaults),
            ListButtonsTab(contents: disabled)
          ],
        ),
      ),
    );
  }
}

class ListButtonsTab extends StatelessWidget {
  const ListButtonsTab({required this.contents, Key? key}) : super(key: key);

  final List<Widget> contents;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: contents,
      ),
    );
  }
}
