part of 'circular_menu.dart';

class IDCircularMenuController extends ChangeNotifier {
  bool _isShowing = false;

  IDCircularMenuController({bool isShowing = false}) {
    _isShowing = isShowing;
  }

  bool get isShowing => _isShowing;

  void changePresentingStatus() {
    _isShowing = !_isShowing;
    notifyListeners();
  }

  void closeMenu() {
    if (_isShowing) {
      _isShowing = false;
      notifyListeners();
    }
  }

  void openMenu() {
    if (!_isShowing) {
      _isShowing = true;
      notifyListeners();
    }
  }
}