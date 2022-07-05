import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as a;

export 'package:flutter/material.dart';

abstract class _PlatformScreen extends StatelessWidget {
  const _PlatformScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final a = appBarActions();
    final t = title(context);

    if (Platform.isIOS) {
      return _buildCupertino(t, a);
    }

    return _buildMaterial(t, a);
  }

  Widget _buildCupertino(String? title, List<ScreenAction>? actions);

  Widget _buildMaterial(String? title, List<ScreenAction>? actions);

  List<ScreenAction>? appBarActions() {
    return null;
  }

  String? title(BuildContext context) {
    return null;
  }
}
abstract class Screen extends _PlatformScreen {
  const Screen({Key? key}) : super(key: key);

  @override
  Widget _buildCupertino(String? title, List<ScreenAction>? actions) {
    return a.CupertinoPageScaffold(
      navigationBar: title == null
          ? null
          : a.CupertinoNavigationBar(
              middle: Text(title),
              trailing: actions?.isNotEmpty == true
                  ? Row(
                      children:
                          actions!.map<Widget>((e) => e._toWidget()).toList())
                  : null,
            ),
      child: a.SafeArea(
        child: Builder(
          builder: (context) => body(context),
        ),
      ),
    );
  }

  @override
  Widget _buildMaterial(String? title, List<ScreenAction>? actions) {
    final appBarAction = appBarActions();

    return Scaffold(
      appBar: title == null
          ? null
          : AppBar(
              title: Text(title),
              actions: appBarAction?.map<Widget>((e) => e._toWidget()).toList(),
            ),
      body: Builder(
        builder: (context) => body(context),
      ),
    );
  }

  Widget body(BuildContext context);


}

class ScreenAction {
  final String? label;
  final IconData? iconData;
  final VoidCallback onPress;

  ScreenAction({this.label, this.iconData, required this.onPress})
      : assert(label != null && iconData != null);

  Widget _toWidget() => iconData == null
      ? TextButton(onPressed: onPress, child: Text(label!))
      : IconButton(onPressed: onPress, icon: Icon(iconData));
}

abstract class TabScreen extends _PlatformScreen {
  const TabScreen({Key? key}) : super(key: key);

  @override
  Widget _buildCupertino(String? title, List<ScreenAction>? actions) {
    final List<TabScreenContent> content = buildTabScreenContent();

    return a.CupertinoTabScaffold(
      tabBar: a.CupertinoTabBar(
        items: content.map((e) => e.bottomNavigationBarItem).toList(),
      ),
      tabBuilder: (context, index) => content[index].page,
    );
  }

  @override
  Widget _buildMaterial(String? title, List<ScreenAction>? actions) {
    final appBarAction = appBarActions();
    final PageController pageController = PageController();
    final List<TabScreenContent> content = buildTabScreenContent();

    return Scaffold(
      appBar: title == null
          ? null
          : AppBar(
        title: Text(title),
        actions: appBarAction?.map<Widget>((e) => e._toWidget()).toList(),
      ),
      body: Builder(
        builder: (context) => PageView(
          controller: pageController,
          children: content.map((e) => e.page).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: content.map((e) => e.bottomNavigationBarItem).toList(),
        onTap: (index) => pageController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.ease)
      ),
    );
  }

  List<TabScreenContent> buildTabScreenContent();
}

class TabScreenContent {
  final BottomNavigationBarItem bottomNavigationBarItem;
  final Widget page;

  TabScreenContent(this.bottomNavigationBarItem, this.page);
}
