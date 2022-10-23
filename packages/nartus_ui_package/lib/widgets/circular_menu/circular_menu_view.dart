part of 'circular_menu.dart';

class IDCircularMenuView extends StatefulWidget {
  final List<IDCircularMenuItemData> items;
  final IDCircularMenuController controller;
  const IDCircularMenuView({required this.items, required this.controller, Key? key})
      : super(key: key);

  @override
  _IDCircularMenuViewState createState() => _IDCircularMenuViewState();
}

class _IDCircularMenuViewState extends State<IDCircularMenuView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> degOneTranslationAnimation;
  late Animation<double> rotationAnimation;
  final Duration animationDuration = const Duration(milliseconds: 250);

  @override
  void initState() {
    _initializeAnimation();

    _listenAnimationAndRebuild();

    _circleMenuListener();

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _circleMenuListener() {
    widget.controller.addListener(() {
      if (animationController.isCompleted) {
        animationController.reverse();
      } else {
        animationController.forward();
      }
    });
  }

  void _listenAnimationAndRebuild() {
    animationController.addListener(() {
      setState(() {});
    });
  }

  void _initializeAnimation() {
    animationController =
        AnimationController(vsync: this, duration: animationDuration);
    degOneTranslationAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ...widget.items
            .map<Widget>((IDCircularMenuItemData item) => Transform.translate(
          offset: Offset.fromDirection(
              CircularMenuUtils.getRadiansFromDegree(item.degree),
              degOneTranslationAnimation.value * 120),
          child: Transform(
              transform: Matrix4.rotationZ(
                  CircularMenuUtils.getRadiansFromDegree(rotationAnimation.value))
                ..scale(degOneTranslationAnimation.value),
              alignment: Alignment.center,
              child: item.item),
        ))
      ],
    );
  }
}
