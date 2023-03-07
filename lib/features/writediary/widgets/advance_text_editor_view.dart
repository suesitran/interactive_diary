import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';

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
    with TickerProviderStateMixin {
  late final QuillController _controller = QuillController.basic()
    ..onSelectionChanged = onSelectionChanged
    ..addListener(() {
      widget.onTextChange(_controller.document.toPlainText());
    });

  final FocusNode _focusNode = FocusNode();

  final ScrollController _scrollController = ScrollController();

  final AttributeGroupValue _alignmentGroup = AttributeGroupValue();

  final AttributeGroupValue _indexedGroup = AttributeGroupValue();

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

  @override
  void initState() {
    super.initState();

    _toolbarHeightAnimation =
        Tween(begin: 0.5, end: 1.0).animate(_toolbarAnimationController);

    _toolbarControllerCloseAnim =
        Tween(begin: 0.0, end: 1.0).animate(_toolbarAnimationController);

    _toolbarControllerOpenAnim =
        Tween(begin: 1.0, end: 0.0).animate(_toolbarAnimationController);

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
        Padding(
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
                      attribute: Attribute.bold,
                      controller: _controller,
                    ),
                    StyleButton(
                        attribute: Attribute.italic, controller: _controller),
                    StyleButton(
                        attribute: Attribute.underline,
                        controller: _controller),
                    StyleColorButton(
                        attribute: Attribute.background,
                        controller: _controller,
                        colorPickerController: _backgroundColorController),
                    StyleColorButton(
                        attribute: Attribute.color,
                        controller: _controller,
                        colorPickerController: _textColorController),
                    StyleListButton(
                      attribute: Attribute.ul,
                      controller: _controller,
                      listType: ListType.bullet,
                      attributeGroup: _indexedGroup,
                    ),
                    StyleListButton(
                      attribute: Attribute.ol,
                      controller: _controller,
                      listType: ListType.numbered,
                      attributeGroup: _indexedGroup,
                    ),
                    StyleButton(
                        attribute: Attribute.strikeThrough,
                        controller: _controller),
                    StyleListButton(
                      attribute: Attribute.blockQuote,
                      controller: _controller,
                      attributeGroup: _indexedGroup,
                      listType: ListType.quote,
                    ),
                    StyleAlignButton(
                        attribute: Attribute.leftAlignment,
                        controller: _controller,
                        alignType: AlignType.left,
                        attributeGroup: _alignmentGroup),
                    StyleAlignButton(
                        attribute: Attribute.centerAlignment,
                        controller: _controller,
                        alignType: AlignType.center,
                        attributeGroup: _alignmentGroup),
                    StyleAlignButton(
                        attribute: Attribute.rightAlignment,
                        controller: _controller,
                        alignType: AlignType.right,
                        attributeGroup: _alignmentGroup),
                    StyleAlignButton(
                        attribute: Attribute.justifyAlignment,
                        controller: _controller,
                        alignType: AlignType.justify,
                        attributeGroup: _alignmentGroup),
                  ],
                ),
              )),
              ValueListenableBuilder(
                valueListenable: _toolbarControllerVisibility,
                builder: (context, visible, child) => visible
                    ? InkWell(
                        borderRadius: BorderRadius.circular(32),
                        splashColor: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(NartusDimens.padding4),
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
                        onTap: () {
                          if (_toolbarAnimationController.status ==
                              AnimationStatus.completed) {
                            _toolbarAnimationController.reverse();
                          } else {
                            _toolbarAnimationController.forward();
                          }
                        },
                      )
                    : const SizedBox.shrink(),
              )
            ],
          ),
        )
      ],
    );
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

    super.dispose();
  }
}
