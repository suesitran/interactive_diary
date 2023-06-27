import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_diary/features/home/bloc/address_cubit.dart';
import 'package:interactive_diary/features/home/bloc/load_diary_cubit.dart';
import 'package:interactive_diary/features/home/bloc/location_bloc.dart';
import 'package:interactive_diary/features/home/content_panel/widgets/content_card_view.dart';
import 'package:interactive_diary/features/home/content_panel/widgets/no_post_view.dart';
import 'package:interactive_diary/features/home/data/diary_display_content.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:interactive_diary/route/route_extension.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

class ContentsBottomPanelController extends ChangeNotifier {
  bool _visible = false;

  void show() {
    _visible = true;
    notifyListeners();
  }

  void dismiss() {
    _visible = false;
    notifyListeners();
  }
}

class ContentsBottomPanelView extends StatefulWidget {
  final ContentsBottomPanelController controller;

  const ContentsBottomPanelView({required this.controller, Key? key})
      : super(key: key);

  @override
  State<ContentsBottomPanelView> createState() =>
      _ContentsBottomPanelViewState();
}

class _ContentsBottomPanelViewState extends State<ContentsBottomPanelView>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<double> _draggedHeight = ValueNotifier<double>(0.0);
  final GlobalKey _initialHeight = GlobalKey();

  double minHeight = 0;

  // to animate initial bottom content
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    // initial offset is 100% below actual y position
    begin: const Offset(0.0, 1.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  ));

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(
      () {
        if (widget.controller._visible == true) {
          _draggedHeight.value = 0;
          // start animation
          _controller.forward();
        } else {
          // revert animation
          _controller.reverse();
        }
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      // This height value is the initial height when the list height is 0
      final RenderBox renderBox =
          _initialHeight.currentContext?.findRenderObject() as RenderBox;

      final Size size = renderBox.size;

      final Offset offset = renderBox.localToGlobal(Offset.zero);

      minHeight = MediaQuery.of(context).size.height -
          offset.dy +
          MediaQuery.of(context).padding.top +
          size.height;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Container(
        decoration: const BoxDecoration(
          color: NartusColor.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(NartusDimens.padding24),
              topRight: Radius.circular(NartusDimens.padding24)),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return GestureDetector(
              onVerticalDragUpdate: (DragUpdateDetails details) =>
                  _calculateHeight(
                      constraints, details.primaryDelta ?? details.delta.dy),
              onVerticalDragEnd: (details) => _calculateHeight(
                  constraints,
                  details.primaryVelocity ??
                      details.velocity.pixelsPerSecond.dy),
              child: Column(
                key: _initialHeight,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: NartusColor.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(NartusDimens.padding24),
                              topRight:
                                  Radius.circular(NartusDimens.padding24)),
                        ),
                        alignment: Alignment.center,
                        height: 8 /* padding top */ +
                            2 /* divider height */ +
                            16 /* padding bottom */,
                        child: Divider(
                          color: NartusColor.grey,
                          indent: (MediaQuery.of(context).size.width - 48) / 2,
                          endIndent:
                              (MediaQuery.of(context).size.width - 48) / 2,
                          thickness: 2,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 24),
                          child: BlocBuilder<AddressCubit, AddressState>(
                            builder: (context, state) {
                              double lat = 0.0;
                              double lng = 0.0;

                              String? address;
                              String? business;

                              if (state is AddressReadyState) {
                                address = state.address;
                                business = state.business;
                              }

                              LocationState locationState =
                                  context.read<LocationBloc>().state;

                              if (locationState is LocationReadyState) {
                                lat = locationState.currentLocation.latitude;
                                lng = locationState.currentLocation.longitude;
                              }
                              return LocationView(
                                locationIconSvg: Assets.images.idLocationIcon,
                                address: address,
                                businessName: business,
                                latitude: lat,
                                longitude: lng,
                                borderRadius: BorderRadius.circular(12),
                              );
                            },
                          )),
                    ],
                  ),
                  ValueListenableBuilder<double>(
                    valueListenable: _draggedHeight,
                    builder:
                        (BuildContext context, double value, Widget? child) =>
                            SizedBox(
                      height: value,
                      child: BlocBuilder<LoadDiaryCubit, LoadDiaryState>(
                        builder: (context, state) {
                          List<DiaryDisplayContent> displayContents = [];

                          if (state is LoadDiaryCompleted) {
                            displayContents = state.contents;
                          }

                          return displayContents.isEmpty
                              ? const NoPostView()
                              : ListView(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  children: displayContents
                                      .map((e) => InkWell(
                                            onTap: () {
                                              _onItemClicked(e);
                                            },
                                            child: ContentCardView(
                                              displayName: e.userDisplayName,
                                              userPhotoUrl: e.userPhotoUrl,
                                              dateTime: e.dateTime,
                                              text: e.plainText,
                                              mediaInfo: e.mediaInfos,
                                            ),
                                          ))
                                      .toList(),
                                );
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _onItemClicked(DiaryDisplayContent content) {
    context.gotoDiaryDetailScreen(
        content.dateTime, content.countryCode, content.postalCode);
  }

  void _calculateHeight(BoxConstraints constraints, double dy) {
    final double height = _draggedHeight.value - dy;
    final double maxHeight = constraints.maxHeight -
        (minHeight < constraints.maxHeight ? minHeight : 0);

    if (height < maxHeight && height >= 0) {
      _draggedHeight.value = height;
    } else if (height >= maxHeight) {
      _draggedHeight.value = maxHeight;
    } else if (height <= 0) {
      _draggedHeight.value = 0;
    }
  }
}
