import 'dart:async';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

class CaptureMediaButton extends StatefulWidget {
  final VoidCallback onCapturedImage;
  final VoidCallback onEndRecordVideo;
  final VoidCallback onStartRecordVideo;
  const CaptureMediaButton(
      {required this.onCapturedImage,
      required this.onEndRecordVideo,
      required this.onStartRecordVideo,
      super.key});

  @override
  State<CaptureMediaButton> createState() => _CaptureMediaButtonState();
}

class _CaptureMediaButtonState extends State<CaptureMediaButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _recordAnimationCtrl;
  late final Animation<double> _outerCircleAnimation;
  late final Animation<double> _innerCircleAnimation;
  Timer? _recordVideoTimer;
  late final Duration _recordKickUpTime;
  late final ValueNotifier<bool> _isRecordingVideo;

  @override
  void initState() {
    _isRecordingVideo = ValueNotifier<bool>(false);
    _recordAnimationCtrl = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _outerCircleAnimation =
        Tween<double>(begin: 4.0, end: 2.0).animate(_recordAnimationCtrl);
    _innerCircleAnimation =
        Tween<double>(begin: 2.0, end: 12.0).animate(_recordAnimationCtrl);
    _recordKickUpTime = const Duration(milliseconds: 500);
    super.initState();
  }

  @override
  void dispose() {
    _recordAnimationCtrl.dispose();
    _recordVideoTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...[
          ValueListenableBuilder<bool>(
            valueListenable: _isRecordingVideo,
            builder: (_, isRecording, __) {
              if (isRecording) {
                return Container(
                  margin: const EdgeInsets.only(bottom: NartusDimens.padding24),
                  decoration: BoxDecoration(
                      color: NartusColor.white,
                      borderRadius: BorderRadius.circular(999)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: NartusDimens.padding12,
                      vertical: NartusDimens.padding4),
                  child: Text(
                    '00:15',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: NartusColor.red,
                        ),
                  ),
                );
              }
              return const SizedBox();
            },
          )
        ],
        Semantics(
          button: true,
          enabled: true,
          excludeSemantics: true,
          explicitChildNodes: false,
          label: S.current.captureMediaButton,
          child: GestureDetector(
            onTap: widget.onCapturedImage,
            onPanDown: (_) => _recordVideoTimer = Timer(_recordKickUpTime, () {
              _recordAnimationCtrl.forward();
              _isRecordingVideo.value = true;
              widget.onStartRecordVideo.call();
            }),
            onPanCancel: () => _recordVideoTimer?.cancel(),
            child: AnimatedBuilder(
              animation: Listenable.merge(
                  [_outerCircleAnimation, _innerCircleAnimation]),
              builder: (_, child) => Container(
                width: NartusDimens.padding40 +
                    NartusDimens.padding32 +
                    NartusDimens.padding4,
                height: NartusDimens.padding40 +
                    NartusDimens.padding32 +
                    NartusDimens.padding4,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: NartusColor.white,
                        width: _outerCircleAnimation.value),
                    color: Colors.transparent),
                padding: EdgeInsets.all(_innerCircleAnimation.value),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: NartusColor.white, width: 4),
                      color: Colors.white),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}


class CircleButton extends StatelessWidget {
  final double size;
  final String iconPath;
  final String semantic;
  final VoidCallback onPressed;
  const CircleButton(
      {required this.size,
      required this.iconPath,
      required this.semantic,
      required this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semantic,
      button: true,
      enabled: true,
      excludeSemantics: true,
      explicitChildNodes: false,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: NartusColor.dark.withOpacity(.2),
          ),
          height: size,
          width: size,
          padding: const EdgeInsets.all(NartusDimens.padding10),
          child: FittedBox(child: SvgPicture.asset(iconPath)),
        ),
      ),
    );
  }
}
