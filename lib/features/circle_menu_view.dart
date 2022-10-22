import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interactive_diary/constants/resources.dart';

class IDCircleMenuView extends StatelessWidget {
  final IDCircleMenuController controller;
  const IDCircleMenuView({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleMenu(
      items: <IDCircleMenuItem>[
        IDCircleMenuItem(
          const IDCircleMenuButton(
            backgroundColor: Colors.purple,
            iconPath: IDIcons.pencil,
          ),
          210.0),
        IDCircleMenuItem(
          const IDCircleMenuButton(
            backgroundColor: Colors.purple,
            iconPath: IDIcons.camera,
          ),
          250.0),
        IDCircleMenuItem(
          const IDCircleMenuButton(
            backgroundColor: Colors.purple,
            iconPath: IDIcons.micro,
          ),
          290.0),
        IDCircleMenuItem(
          const IDCircleMenuButton(
            backgroundColor: Colors.purple,
            iconPath: IDIcons.smile,
          ),
          330.0),
      ],
      controller: controller,
    );
  }
}

class IDCircleMenuButton extends StatelessWidget {
  final Color backgroundColor;
  final String iconPath;
  const IDCircleMenuButton(
      {required this.backgroundColor, required this.iconPath, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2)),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10.24),
      child: SvgPicture.asset(iconPath),
    );
  }
}

class IDCircleMenuController extends ChangeNotifier {
  bool showCircleMenu = false;

  void changePresentingStatus() {
    showCircleMenu = !showCircleMenu;
    notifyListeners();
  }

  void closeMenu() {
    if (showCircleMenu) {
      showCircleMenu = false;
      notifyListeners();
    }
  }
}

class IDCircleMenuItem {
  final Widget item;

  /// Position of item on circle as degree measurement of circle
  final double degree;

  IDCircleMenuItem(this.item, this.degree);
}

class CircleMenu extends StatefulWidget {
  final List<IDCircleMenuItem> items;
  final IDCircleMenuController controller;
  const CircleMenu(
      {required this.items, required this.controller, Key? key})
      : super(key: key);

  @override
  _CircleMenuState createState() => _CircleMenuState();
}

class _CircleMenuState extends State<CircleMenu>
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
            .map<Widget>((IDCircleMenuItem item) => Transform.translate(
                  offset: Offset.fromDirection(
                      getRadiansFromDegree(item.degree),
                      degOneTranslationAnimation.value * 100),
                  child: Transform(
                      transform: Matrix4.rotationZ(
                          getRadiansFromDegree(rotationAnimation.value))
                        ..scale(degOneTranslationAnimation.value),
                      alignment: Alignment.center,
                      child: item.item),
                ))
      ],
    );
  }
}

double getRadiansFromDegree(double degree) {
  double unitRadian = 57.295779513;
  return degree / unitRadian;
}
