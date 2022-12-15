import 'package:flutter/material.dart';
import 'package:interactive_diary/features/home/content_panel/widgets/content_card_view.dart';
import 'package:interactive_diary/widgets/location_view.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

class ContentsBottomPanelController {
  void show() {}

  void dismiss() {}
}

class ContentsBottomPanelView extends StatefulWidget {
  final ContentsBottomPanelController controller;

  const ContentsBottomPanelView({required this.controller, Key? key})
      : super(key: key);

  @override
  State<ContentsBottomPanelView> createState() => _ContentsBottomPanelViewState();
}

class _ContentsBottomPanelViewState extends State<ContentsBottomPanelView> {

  final ValueNotifier<double> _draggedHeight = ValueNotifier<double>(0.0);
  final GlobalKey _initialHeight = GlobalKey();

  double minHeight = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      // This height value is the initial height when the list height is 0
      minHeight = _initialHeight.currentContext?.size?.height ?? 0;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      key: _initialHeight,
      decoration: const BoxDecoration(
        color: NartusColor.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(NartusDimens.padding24),
            topRight: Radius.circular(NartusDimens.padding24)),
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // handler
              GestureDetector(
                onVerticalDragUpdate: (DragUpdateDetails details) {
                  double height = _draggedHeight.value;
                  height -= (details.primaryDelta ?? details.delta.dy);

                  if (height <= constraints.maxHeight - minHeight
                      && height >= 0) {
                    _draggedHeight.value = height;
                  }
                },

                child: Container(
                  decoration: const BoxDecoration(
                    color: NartusColor.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(NartusDimens.padding24),
                        topRight: Radius.circular(NartusDimens.padding24)),
                  ),
                  alignment: Alignment.center,
                  height: 8 /* padding top */ + 2 /* divider height */ + 16 /* padding bottom */,
                  child: Divider(
                    color: NartusColor.grey,
                    indent: (MediaQuery.of(context).size.width - 48) / 2,
                    endIndent: (MediaQuery.of(context).size.width - 48) / 2,
                    thickness: 2,
                  ),
                ),
              ),
              // location view
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
                child: LocationView(
                  currentLocation:
                  'Shop 11, The Strand Arcade, 412-414 George St, Sydney NSW 2000, Australia',
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              ValueListenableBuilder<double>(
                valueListenable: _draggedHeight,
                builder: (BuildContext context, double value, Widget? child) => SizedBox(
                  height: value,
                  child: ListView.builder(itemBuilder: (BuildContext context, int index) {
                    return const Padding(padding: EdgeInsets.only(left: 16, right: 16, bottom: 16), child: ContentCardView(screenEdgeSpacing: 16),);
                  },
                    itemCount: 10,
                    shrinkWrap: true,
                  padding: EdgeInsets.zero),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
