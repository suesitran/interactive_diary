part of 'designs.dart';

abstract class Screen extends _PlatformScreen {
  const Screen({Key? key}) : super(key: key);

  @override
  Widget _buildCupertino(BuildContext context, String? title, List<ScreenAction>? actions) {
    final FloatingActionButtonConfig? config = floatingActionButtonConfig(context);

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
          padding: config._calculateCupertinoPadding(context),
          alignment: config._toAlign(config.location),
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