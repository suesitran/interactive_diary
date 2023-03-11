part of 'advance_text_editor_view.dart';

class ColorPickerController extends ValueNotifier<bool> {
  ColorPickerController() : super(false);

  final ValueNotifier<Color> _colorChangeNotifier =
      ValueNotifier<Color>(NartusColor.white);

  ValueNotifier<Color> get onColorChange => _colorChangeNotifier;

  void _onColorChange(Color color) {
    _colorChangeNotifier.value = color;
    _colorChangeNotifier.notifyListeners();
  }

  void show() {
    value = true;
    notifyListeners();
  }

  void hide() {
    value = false;
    notifyListeners();
  }
}

class ColorPickerBar extends StatefulWidget {
  final ColorPickerController controller;

  const ColorPickerBar({required this.controller, Key? key}) : super(key: key);

  @override
  State<ColorPickerBar> createState() => _ColorPickerBarState();
}

class _ColorPickerBarState extends State<ColorPickerBar>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 300))
    ..addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        _thumbPosition.value = 0.0;
        _currentColor = NartusColor.white;
      }

      if (status == AnimationStatus.completed) {
        widget.controller._onColorChange(_currentColor);
      }
    });
  late final Animation<double> _sizeAnimation =
      CurvedAnimation(curve: Curves.fastOutSlowIn, parent: _controller);

  final ValueNotifier<double> _thumbPosition = ValueNotifier(0.0);
  final List<Color> colors = [
    Colors.white,
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.cyan,
    Colors.blue,
    Colors.purple,
    Colors.black
  ];

  Color _currentColor = NartusColor.white;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(_updateVisibility);
  }

  void _updateVisibility() {
    if (widget.controller.value) {
      // show this color picker
      _controller.forward();
    } else {
      // hide
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _sizeAnimation,
      child: SizedBox(
        height: NartusDimens.size24,
        child: GestureDetector(
          child: Stack(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: NartusDimens.padding4),
                height: NartusDimens.size16,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: colors,
                    ),
                    borderRadius: BorderRadius.circular(40)),
              ),
              ValueListenableBuilder(
                valueListenable: _thumbPosition,
                builder: (context, position, child) => LayoutBuilder(
                  builder: (_, constraints) => CustomPaint(
                    painter: ThumbHandlePainter(
                        position: position,
                        colors: colors,
                        constraints: constraints,
                        onColorChange: (color) {
                          _currentColor = color;
                        }),
                  ),
                ),
              ),
            ],
          ),
          onHorizontalDragUpdate: (details) {
            _thumbPosition.value = details.localPosition.dx;
          },
          onTapDown: (details) =>
              _thumbPosition.value = details.localPosition.dx,
          onTapUp: (details) {
            // delay a frame to update color to correct color
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              widget.controller._onColorChange(_currentColor);
            });
          },
          onHorizontalDragEnd: (details) {
            widget.controller._onColorChange(_currentColor);
          },
        ),
      ),
    );
  }
}

class ThumbHandlePainter extends CustomPainter {
  final double position;
  final List<Color> colors;
  final BoxConstraints constraints;
  final Paint painter = Paint()..isAntiAlias = true;

  final Function(Color) onColorChange;

  ThumbHandlePainter(
      {required this.position,
      required this.colors,
      required this.constraints,
      required this.onColorChange})
      : super() {
    _calculateColor(position, constraints.maxWidth);
  }

  @override
  void paint(Canvas canvas, Size size) {
    double point = 0;

    if (position < 0) {
      point = 0;
    } else if (position > constraints.maxWidth) {
      point = constraints.maxWidth;
    } else {
      point = position;
    }

    painter.color = NartusColor.white;
    canvas.drawCircle(Offset(point, 12), 14, painter);

    painter.color = _calculateColor(point, constraints.maxWidth);
    canvas.drawCircle(Offset(point, 12), 12, painter);
  }

  Color _calculateColor(double position, double width) {
    Color currentColor = NartusColor.white;

    //determine color
    double positionInColorArray = (position / width * (colors.length - 1));

    int index = positionInColorArray.truncate();

    double remainder = positionInColorArray - index;
    if (remainder == 0.0) {
      currentColor = colors[index];
    } else if (index == colors.length - 1) {
      currentColor = colors.last;
    } else {
      //calculate new color
      int redValue = colors[index].red == colors[index + 1].red
          ? colors[index].red
          : (colors[index].red +
                  (colors[index + 1].red - colors[index].red) * remainder)
              .round();
      int greenValue = colors[index].green == colors[index + 1].green
          ? colors[index].green
          : (colors[index].green +
                  (colors[index + 1].green - colors[index].green) * remainder)
              .round();
      int blueValue = colors[index].blue == colors[index + 1].blue
          ? colors[index].blue
          : (colors[index].blue +
                  (colors[index + 1].blue - colors[index].blue) * remainder)
              .round();
      currentColor = Color.fromARGB(255, redValue, greenValue, blueValue);
    }

    onColorChange(currentColor);
    return currentColor;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is ThumbHandlePainter && oldDelegate.position != position;
}
