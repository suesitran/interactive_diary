import 'package:flutter/material.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';

class TextAndErrorLabel extends StatefulWidget {
  final String _label;
  final String _error;
  final bool _showError;

  const TextAndErrorLabel(
      {required String label, Key? key, String? error, bool showError = false})
      : _label = label,
        _error = error ?? '',
        _showError = showError,
        super(key: key);

  @override
  State<TextAndErrorLabel> createState() => _TextAndErrorLabelState();
}

class _TextAndErrorLabelState extends State<TextAndErrorLabel>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 300));
  late final Animation<double> _sizeAnimation =
      CurvedAnimation(curve: Curves.fastOutSlowIn, parent: _controller);

  @override
  void initState() {
    super.initState();

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
  void didUpdateWidget(covariant TextAndErrorLabel oldWidget) {
    if (widget._showError != oldWidget._showError) {
      if (widget._showError) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(NartusDimens.padding24)),
      ),
      color: Theme.of(context).colorScheme.error,
      elevation: NartusDimens.padding4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _labelWidget(),
          _errorWidget(),
        ],
      ),
    );
  }

  Widget _labelWidget() => Builder(
        builder: (BuildContext context) => Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.all(
                  Radius.circular(NartusDimens.padding24))),
          padding: const EdgeInsets.symmetric(
              horizontal: NartusDimens.padding16,
              vertical: NartusDimens.padding14),
          child: Text(widget._label,
              style: Theme.of(context).textTheme.titleLarge),
        ),
      );

  Widget _errorWidget() => SizeTransition(
        sizeFactor: _sizeAnimation,
        axisAlignment: 1,
        child: Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.symmetric(
              horizontal: NartusDimens.padding16,
              vertical: NartusDimens.padding4),
          child: Text(
            widget._error,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Theme.of(context).colorScheme.onError),
            textAlign: TextAlign.center,
          ),
        ),
      );
}
