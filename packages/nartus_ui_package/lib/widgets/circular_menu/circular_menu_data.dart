part of 'circular_menu.dart';

typedef OnMenuItemPressed = void Function();

class IDCircularMenuItemData {
  final Widget item;

  /// Position of item on circle as degree measurement of circle
  final double degree;
  final OnMenuItemPressed onPressed;

  IDCircularMenuItemData({required this.item, required this.degree, required this.onPressed});

  double get radiansFromDegree {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

}