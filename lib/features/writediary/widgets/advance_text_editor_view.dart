import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';

import 'package:interactive_diary/generated/l10n.dart';

part 'constants/asset_strings.dart';
part 'style_button.dart';
part 'color_picker.dart';

class AdvanceTextEditorView extends StatefulWidget {
  final Widget? leading;
  final void Function(String) onTextChange;
  const AdvanceTextEditorView(
      {required this.onTextChange, this.leading, Key? key})
      : super(key: key);

  @override
  State<AdvanceTextEditorView> createState() => _AdvanceTextEditorViewState();
}

class _AdvanceTextEditorViewState extends State<AdvanceTextEditorView>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late final QuillController _controller = QuillController.basic()
    ..onSelectionChanged = onSelectionChanged

    /// We use _controller.changes.listen instead of _controller.addListener here
    /// because it doesn't trigger when user interact with QuillEditor or QuillButtonController (Which is unnecessary)
    /// _controller.addListener triggers even when user only move cursor around
    /// or presses on a button of controllers without adding any actual text.
    ..changes.listen((_) {
      /// _controller.document.isEmpty.call()
      ///   -> Check if document is actually empty.
      /// - Note : Can't cover the case that user entered only white space without any actual text character.
      /// We can't use _controller.document.toDelta.isEmpty because it's usually never empty
      /// _controller.document.toPlainText().trim().isEmpty
      ///   -> Check empty cover when user added a bunch of white space case.
      /// We had to use .trim() to remove all white space that quill added to text.
      /// For example : User typed "A" -> plainText.length will be 2, with 1 extra white space
      final bool isEmpty = _controller.document.isEmpty.call() ||
          _controller.document.toPlainText().trim().isEmpty;

      widget.onTextChange(
          isEmpty ? '' : json.encode(_controller.document.toDelta().toJson()));
    });

  final FocusNode _focusNode = FocusNode();

  final ScrollController _scrollController = ScrollController();

  /// these params are defined to be used for animation on the toolbar
  final GlobalKey _toolbarKey = GlobalKey();

  final Duration _animDuration = const Duration(milliseconds: 300);
  late final AnimationController _toolbarAnimationController =
      AnimationController(vsync: this, duration: _animDuration);
  late final Animation<double> _toolbarHeightAnimation;

  /// controller animation
  late final Animation<double> _toolbarControllerCloseAnim;
  late final Animation<double> _toolbarControllerOpenAnim;

  /// decide whether to show or hide toolbarController
  final ValueNotifier _toolbarControllerVisibility = ValueNotifier<bool>(true);

  /// color picker
  final ColorPickerController _backgroundColorController =
      ColorPickerController();
  final ColorPickerController _textColorController = ColorPickerController();

  /// keep track of device width for foldable devices
  double currentWidth = 0;
  @override
  void initState() {
    super.initState();

    _toolbarHeightAnimation =
        Tween(begin: 0.5, end: 1.0).animate(_toolbarAnimationController);

    _toolbarControllerCloseAnim =
        Tween(begin: 0.0, end: 1.0).animate(_toolbarAnimationController);

    _toolbarControllerOpenAnim =
        Tween(begin: 1.0, end: 0.0).animate(_toolbarAnimationController);

    _backgroundColorController.addListener(() {
      if (_backgroundColorController.value) {
        _textColorController.hide();
      }
    });

    _textColorController.addListener(() {
      if (_textColorController.value) {
        _backgroundColorController.hide();
      }
    });

    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      currentWidth = MediaQuery.of(context).size.width;

      _adjustLayoutToScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.leading != null) widget.leading!,
        Expanded(
            child: QuillEditor(
          padding: const EdgeInsets.all(NartusDimens.padding16),
          controller: _controller,
          readOnly: false,
          autoFocus: true,
          expands: true,
          scrollable: true,
          focusNode: _focusNode,
          scrollController: _scrollController,
        )),
        Padding(
          padding: const EdgeInsets.only(
              left: NartusDimens.padding16, right: NartusDimens.padding16),
          child: ColorPickerBar(
            controller: _backgroundColorController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: NartusDimens.padding16, right: NartusDimens.padding16),
          child: ColorPickerBar(
            controller: _textColorController,
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
                left: NartusDimens.padding16, right: NartusDimens.padding16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: SizeTransition(
                  sizeFactor: _toolbarHeightAnimation,
                  axisAlignment: -1,
                  child: Wrap(
                    key: _toolbarKey,
                    children: [
                      StyleButton(
                        type: TextFormatType.bold,
                        controller: _controller,
                      ),
                      StyleButton(
                          type: TextFormatType.italic, controller: _controller),
                      StyleButton(
                          type: TextFormatType.underline,
                          controller: _controller),
                      StyleColorButton(
                          type: TextFormatType.highlight,
                          controller: _controller,
                          colorPickerController: _backgroundColorController),
                      StyleColorButton(
                          type: TextFormatType.color,
                          controller: _controller,
                          colorPickerController: _textColorController),
                      StyleListButton(
                        type: TextFormatType.bullet,
                        controller: _controller,
                      ),
                      StyleListButton(
                        type: TextFormatType.numbered,
                        controller: _controller,
                      ),
                      StyleButton(
                          type: TextFormatType.strikethrough,
                          controller: _controller),
                      StyleListButton(
                        type: TextFormatType.quote,
                        controller: _controller,
                      ),
                      StyleAlignButton(
                        type: TextFormatType.alignLeft,
                        controller: _controller,
                      ),
                      StyleAlignButton(
                        type: TextFormatType.alignCenter,
                        controller: _controller,
                      ),
                      StyleAlignButton(
                        type: TextFormatType.alignRight,
                        controller: _controller,
                      ),
                      StyleAlignButton(
                        type: TextFormatType.alignJustify,
                        controller: _controller,
                      ),
                    ],
                  ),
                )),
                ValueListenableBuilder(
                  valueListenable: _toolbarControllerVisibility,
                  builder: (context, visible, child) => visible
                      ? Semantics(
                          button: true,
                          label: S.of(context).toolbarMore,
                          onTap: _onMoreButtonTap,
                          child: InkWell(
                            excludeFromSemantics: true,
                            borderRadius: BorderRadius.circular(32),
                            splashColor: Colors.transparent,
                            onTap: _onMoreButtonTap,
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(NartusDimens.padding4),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                    color: NartusColor.dark),
                                child: Stack(
                                  children: [
                                    FadeTransition(
                                      opacity: _toolbarControllerOpenAnim,
                                      child: SvgPicture.asset(
                                        Assets.images.idMoreIcon,
                                        width: 24,
                                        height: 24,
                                        colorFilter: const ColorFilter.mode(
                                            NartusColor.white, BlendMode.srcIn),
                                      ),
                                    ),
                                    FadeTransition(
                                      opacity: _toolbarControllerCloseAnim,
                                      child: SvgPicture.asset(
                                        Assets.images.icTextController,
                                        width: 24,
                                        height: 24,
                                        colorFilter: const ColorFilter.mode(
                                            NartusColor.white, BlendMode.srcIn),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  void _onMoreButtonTap() {
    if (_toolbarAnimationController.status == AnimationStatus.completed) {
      _toolbarAnimationController.reverse();
    } else {
      _toolbarAnimationController.forward();
    }
  }

  void onSelectionChanged(TextSelection selection) {
    _backgroundColorController.hide();
    _textColorController.hide();
  }

  @override
  void dispose() {
    _controller.dispose();

    _focusNode.dispose();

    _scrollController.dispose();
    _toolbarAnimationController.dispose();

    _toolbarControllerVisibility.dispose();
    _backgroundColorController.dispose();
    _textColorController.dispose();

    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    if (currentWidth != MediaQuery.of(context).size.width) {
      currentWidth = MediaQuery.of(context).size.width;

      _adjustLayoutToScreen();
    }
  }

  void _adjustLayoutToScreen() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final double toolbarHeight =
          _toolbarKey.currentContext?.size?.height ?? 0;

      // show controller icon when toolbar is taller than controller
      _toolbarControllerVisibility.value = toolbarHeight > styleButtonHeight;

      if (toolbarHeight <= styleButtonHeight) {
        // when toolbar is shorter than controller, show toolbar fully
        _toolbarAnimationController.value = 1;
      }
    });
    _toolbarAnimationController.value = 0;
  }
}
