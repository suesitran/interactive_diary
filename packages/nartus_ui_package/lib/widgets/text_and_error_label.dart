import 'package:flutter/material.dart';

class TextAndErrorLabel extends StatefulWidget {
  final String _label;
  final String _error;
  final bool _showError;

  const TextAndErrorLabel({Key? key, required String label, required String error, bool showError = false})
      : _label = label,
        _error = error,
        _showError = showError,
        super(key: key);

  @override
  State<TextAndErrorLabel> createState() => _TextAndErrorLabelState();
}

class _TextAndErrorLabelState extends State<TextAndErrorLabel> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  final Animatable<double> _easeInTween = CurveTween(curve: Curves.easeIn);
  late Animation<double> _heightFactor;

  final Duration _kExpand = const Duration(seconds: 5);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: _kExpand, vsync: this);

    _heightFactor = _controller.drive(_easeInTween);

    if (widget._showError) {
      _controller.value = 1;
    }
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget._showError) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(23)),
      ),
      color: Theme.of(context).backgroundColor,
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.error,
            borderRadius: const BorderRadius.all(Radius.circular(23))),
        alignment: Alignment.center,
        child: Stack(
          children: [
            _errorWidget(),
            _labelWidget(),
          ],
        ),
      ),
    );
  }

  Widget _labelWidget() => Builder(builder: (context) => Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground,
        borderRadius: const BorderRadius.all(Radius.circular(23))),
    padding:
    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
    child: Text(widget._label, style: Theme.of(context).textTheme.headline6),
  ),);

  Widget _errorWidget() => AnimatedBuilder(
    animation: _controller.view,
    builder: (context, child) {
      return Container(
        height: 80 * _heightFactor.value,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Text(
            widget._error,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(color: Theme.of(context).colorScheme.onError),
          ),
      );
    },
  );
}
