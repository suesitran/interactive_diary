import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as a;

export 'package:flutter/material.dart' hide Scaffold, ScaffoldMessenger;

abstract class _PlatformScreen extends StatelessWidget {
  const _PlatformScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final a = appBarActions(context);
    final t = title(context);

    if (Platform.isIOS) {
      return _buildCupertino(context, t, a);
    }

    return _buildMaterial(context, t, a);
  }

  Widget _buildCupertino(BuildContext context, String? title, List<ScreenAction>? actions);

  Widget _buildMaterial(BuildContext context, String? title, List<ScreenAction>? actions);

  FloatingActionButtonConfig? floatingActionButtonConfig(BuildContext context) {
    return null;
  }

  List<ScreenAction>? appBarActions(BuildContext context) {
    return null;
  }

  String? title(BuildContext context) {
    return null;
  }

  Alignment _toAlign(FloatingActionButtonLocation location) {
    switch (location) {
      case FloatingActionButtonLocation.centerDocked:
      case FloatingActionButtonLocation.centerFloat:
        return Alignment.bottomCenter;
      case FloatingActionButtonLocation.centerTop:
        return Alignment.topCenter;
      case FloatingActionButtonLocation.endDocked:
      case FloatingActionButtonLocation.endFloat:
        return Alignment.bottomRight;
      case FloatingActionButtonLocation.endTop:
        return Alignment.topRight;
      case FloatingActionButtonLocation.startDocked:
      case FloatingActionButtonLocation.startFloat:
        return Alignment.bottomLeft;
      case FloatingActionButtonLocation.startTop:
        return Alignment.topLeft;
      default:
        return Alignment.bottomCenter;
    }
  }
}
abstract class Screen extends _PlatformScreen {
  const Screen({Key? key}) : super(key: key);

  @override
  Widget _buildCupertino(BuildContext context, String? title, List<ScreenAction>? actions) {
    final FloatingActionButtonConfig? config = floatingActionButtonConfig(context);
    final screenPading = MediaQuery.of(context).padding;

    return Stack(
      children: [
        a.CupertinoPageScaffold(
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
        ),
        if (config != null) Container(
          padding: EdgeInsets.only(
              bottom: screenPading.bottom,
          left: 25 + screenPading.left,
          right: 25 + screenPading.right,
          top: 25 + screenPading.top),
          alignment: _toAlign(config.location),
          child: config.button,)
      ],
    );
  }

  @override
  Widget _buildMaterial(BuildContext context, String? title, List<ScreenAction>? actions) {
    final FloatingActionButtonConfig? config = floatingActionButtonConfig(context);

    return Scaffold(
      appBar: title == null
          ? null
          : AppBar(
              title: Text(title),
              actions: actions?.map<Widget>((e) => e._toWidget()).toList(),
            ),
      body: Builder(
        builder: (context) => body(context),
      ),
      floatingActionButton: config?.button,
      floatingActionButtonLocation: config?.location,
      floatingActionButtonAnimator: config?.animator,
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
  Widget _buildCupertino(BuildContext context, String? title, List<ScreenAction>? actions) {
    final List<TabScreenContent> content = buildTabScreenContent();
    final FloatingActionButtonConfig? config = floatingActionButtonConfig(context);

    return Stack(
      children: [
        a.CupertinoTabScaffold(
          tabBar: a.CupertinoTabBar(
            items: content.map((e) => e.bottomNavigationBarItem).toList(),
          ),
          tabBuilder: (context, index) => content[index].page,
        ),
        if (config != null) Align(
          alignment: _toAlign(config.location),
          child: Padding(
            padding: EdgeInsets.all(25.0 + MediaQuery.of(context).padding.bottom),
            child: config.button,
          ),
        )
      ],
    );
  }

  @override
  Widget _buildMaterial(BuildContext context, String? title, List<ScreenAction>? actions) {
    final appBarAction = appBarActions(context);
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

class FloatingActionButtonConfig {
  final FloatingActionButton button;
  final FloatingActionButtonLocation location;
  final FloatingActionButtonAnimator animator;

  FloatingActionButtonConfig({
    required this.button, this.location = FloatingActionButtonLocation.centerDocked, this.animator = FloatingActionButtonAnimator.scaling
});
}
