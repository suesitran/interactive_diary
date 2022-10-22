import 'package:flutter/material.dart';

class CircleMenuViewV2 extends StatefulWidget {
  final bool isShowingMenu;
  final double menuIconSize;
  const CircleMenuViewV2({Key? key, required this.isShowingMenu, required this.menuIconSize}) : super(key: key);

  @override
  _CircleMenuViewV2State createState() => _CircleMenuViewV2State();
}

class _CircleMenuViewV2State extends State<CircleMenuViewV2> with SingleTickerProviderStateMixin {

  late AnimationController animationController;
  late Animation<double> degOneTranslationAnimation;
  late Animation<double> rotationAnimation;
  final Duration animationDuration = const Duration(milliseconds: 250);

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: animationDuration);
    degOneTranslationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0)
        .animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant CircleMenuViewV2 oldWidget) {
    if (oldWidget.isShowingMenu != widget.isShowingMenu) {
      if (animationController.isCompleted) {
        animationController.reverse();
      } else {
        animationController.forward();
      }
    }
    super.didUpdateWidget(oldWidget);
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _CircleAnimatedButton(
          degree: 290,
          rotationRadians: rotationAnimation.value,
          degOneTranslationAnimationValue: degOneTranslationAnimation.value,
          iconSize: widget.menuIconSize,
        ),
        _CircleAnimatedButton(
          degree: 330,
          rotationRadians: rotationAnimation.value,
          degOneTranslationAnimationValue: degOneTranslationAnimation.value,
          iconSize: widget.menuIconSize,
        ),
        _CircleAnimatedButton(
          degree: 210,
          rotationRadians: rotationAnimation.value,
          degOneTranslationAnimationValue: degOneTranslationAnimation.value,
          iconSize: widget.menuIconSize,
        ),
        _CircleAnimatedButton(
          degree: 250,
          rotationRadians: rotationAnimation.value,
          degOneTranslationAnimationValue: degOneTranslationAnimation.value,
          iconSize: widget.menuIconSize,
        ),
      ],
    );
  }
}

// class CircleMenuView extends StatefulWidget {
//   final bool isShowingMenu;
//   const CircleMenuView({Key? key, required this.isShowingMenu}) : super(key: key);
//
//   @override
//   _CircleMenuViewState createState() => _CircleMenuViewState();
// }
//
// class _CircleMenuViewState extends State<CircleMenuView> with SingleTickerProviderStateMixin {
//
//   late AnimationController animationController;
//   late Animation<double> degOneTranslationAnimation;
//   late Animation<double> rotationAnimation;
//   final double circleSize = 40;
//   final Duration animationDuration = const Duration(milliseconds: 250);
//
//   @override
//   void initState() {
//     animationController = AnimationController(vsync: this, duration: animationDuration);
//     degOneTranslationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
//     rotationAnimation = Tween<double>(begin: 180.0, end: 0.0)
//         .animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));
//     super.initState();
//     animationController.addListener(() {
//       setState(() {});
//     });
//   }
//
//   @override
//   void didUpdateWidget(covariant CircleMenuView oldWidget) {
//     if (oldWidget.isShowingMenu != widget.isShowingMenu) {
//       if (animationController.isCompleted) {
//         animationController.reverse();
//       } else {
//         animationController.forward();
//       }
//     }
//     super.didUpdateWidget(oldWidget);
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(
//         top: MediaQuery.of(context).size.height / 2 - circleSize / 2,
//         left: MediaQuery.of(context).size.width / 2 - circleSize / 2,
//       ),
//       child: Stack(
//         children: [
//           _CircleAnimatedButton(
//             degree: 290,
//             rotationRadians: rotationAnimation.value,
//             degOneTranslationAnimationValue: degOneTranslationAnimation.value,
//             iconSize: circleSize,
//           ),
//           _CircleAnimatedButton(
//             degree: 330,
//             rotationRadians: rotationAnimation.value,
//             degOneTranslationAnimationValue: degOneTranslationAnimation.value,
//             iconSize: circleSize,
//           ),
//           _CircleAnimatedButton(
//             degree: 210,
//             rotationRadians: rotationAnimation.value,
//             degOneTranslationAnimationValue: degOneTranslationAnimation.value,
//             iconSize: circleSize,
//           ),
//           _CircleAnimatedButton(
//             degree: 250,
//             rotationRadians: rotationAnimation.value,
//             degOneTranslationAnimationValue: degOneTranslationAnimation.value,
//             iconSize: circleSize,
//           ),
//         ],
//       ),
//     );
//   }
// }

class _CircleAnimatedButton extends StatelessWidget {
  final double degree;
  final double rotationRadians;
  final double degOneTranslationAnimationValue;
  final double iconSize;
  const _CircleAnimatedButton({
    required this.degree, required this.rotationRadians,
    required this.degOneTranslationAnimationValue, required this.iconSize, Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset.fromDirection(getRadiansFromDegree(degree), degOneTranslationAnimationValue * 100),
      child: Transform(
        transform: Matrix4.rotationZ(getRadiansFromDegree(rotationRadians))..scale(degOneTranslationAnimationValue),
        alignment: Alignment.center,
        child: CircularButton(
          color: Colors.blue,
          width: iconSize,
          height: iconSize,
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ), onClick: () {},
        )
      ),
    );
  }
}


double getRadiansFromDegree(double degree) {
  double unitRadian = 57.295779513;
  return degree / unitRadian;
}

class CircularButton extends StatelessWidget {

  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final Function onClick;

  CircularButton({
    required this.color, required this.width, required this.height,
    required this.icon, required this.onClick});


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color,shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(icon: icon,enableFeedback: true, onPressed: () => onClick.call()),
    );
  }
}
