part of '../platform_screens.dart';

abstract class TabScreen extends _PlatformScreen {
  const TabScreen({Key? key}) : super(key: key);

  @override
  Widget _buildCupertino(
      BuildContext context, String? title, List<ScreenAction>? actions) {
    final List<TabScreenContent> content = buildTabScreenContent();
    final FloatingActionButtonConfig? config =
        floatingActionButtonConfig(context);

    return Stack(
      children: [
        a.CupertinoTabScaffold(
          tabBar: a.CupertinoTabBar(
            items: content.map((e) => e.bottomNavigationBarItem).toList(),
          ),
          tabBuilder: (context, index) => content[index].page,
        ),
        if (config != null)
          Container(
            alignment: config._toAlign(config.location),
            padding: config._calculateCupertinoPadding(context, inTab: true),
            child: config.button,
          )
      ],
    );
  }

  @override
  Widget _buildMaterial(
      BuildContext context, String? title, List<ScreenAction>? actions) {
    final appBarAction = appBarActions(context);
    final PageController pageController = PageController();
    final List<TabScreenContent> content = buildTabScreenContent();
    final FloatingActionButtonConfig? config =
        floatingActionButtonConfig(context);

    return Scaffold(
      appBar: title == null
          ? null
          : AppBar(
              title: Text(title),
              actions:
                  appBarAction?.map<Widget>((e) => e._toWidget(false)).toList(),
            ),
      body: Builder(
        builder: (context) => PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: content.map((e) => e.page).toList()),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: content.map((e) => e.bottomNavigationBarItem).toList(),
          onTap: (index) => pageController.animateToPage(index,
              duration: const Duration(milliseconds: 200), curve: Curves.ease)),
      floatingActionButton: config?.button,
      floatingActionButtonLocation: config?.location,
      floatingActionButtonAnimator: config?.animator,
    );
  }

  List<TabScreenContent> buildTabScreenContent();
}

class TabScreenContent {
  final BottomNavigationBarItem bottomNavigationBarItem;
  final Widget page;

  TabScreenContent(this.bottomNavigationBarItem, this.page);
}
