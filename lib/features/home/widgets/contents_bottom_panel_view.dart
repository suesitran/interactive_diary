import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_diary/constants/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import 'package:interactive_diary/bloc/get_contents/get_contents_bloc.dart';
import 'package:interactive_diary/features/home/widgets/content_card_view.dart';
import 'package:interactive_diary/features/home/widgets/location_address_box_view.dart';

class ContentsBottomPanelView extends StatefulWidget {
  const ContentsBottomPanelView({Key? key}) : super(key: key);

  @override
  _ContentsBottomPanelViewState createState() => _ContentsBottomPanelViewState();
}

class _ContentsBottomPanelViewState extends State<ContentsBottomPanelView> {

  final List<double> snaps = <double>[1, 0.85, 0.5, 0.2];
  int currentPos = 0;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onPanEnd: (DragEndDetails details) {
        if (details.velocity.pixelsPerSecond.dy > -100) {
          if (currentPos > 0) {
            setState(() {
              currentPos = currentPos - 1;
            });
          }
        } else {
          if (currentPos < snaps.length - 1) {
            setState(() {
              currentPos = currentPos + 1;
            });
          }
        }
      },
      child: AnimatedContainer(
        height: size.height - (size.height * snaps[currentPos]),
        width: size.width,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        duration: const Duration(milliseconds: 200),
        child: Align(alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Gap.v12(),
                Container(
                  height: 4,
                  width: MediaQuery.of(context).size.width * .2,
                  decoration: BoxDecoration(
                    color: Colors.grey[500],
                    borderRadius: BorderRadius.circular(4.0)
                  ),
                ),
                const Gap.v12(),
                Container(
                  margin: const EdgeInsets.only(
                    left: 12, right: 12,
                    // bottom: MediaQuery.of(context).viewPadding.bottom
                  ),
                  child: const LocationAddressBoxView(
                    address: 'Shop 11, The Strand Arcade, 412-414 George St, Sydney NSW 2000, Australia',
                  ),
                ),
                if (currentPos > 1)...<Widget>[
                  Flexible(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: BlocBuilder<GetContentsBloc, GetContentsState>(
                          builder: (_, GetContentsState state) {
                            if (state.isGettingContentsState) {
                              return Container(
                                margin: const EdgeInsets.only(top: 12),
                                child: const LoadingIndicator(),
                              );
                            } else if (state.isDataEmptyState) {
                              return const SizedBox();
                            } else if (state.isGetContentsFailedState) {
                              return ErrorView(error: state.getContentsError,);
                            } else if (state.isGetContentsSucceedState) {
                              return ListView.separated(
                                cacheExtent: 200,
                                shrinkWrap: true,
                                itemBuilder: (_, int idx) => Column(
                                  children: <Widget>[
                                    ContentCardView(
                                      screenEdgeSpacing: 16,
                                      content: state.getContents[idx],
                                    ),
                                    if (idx == state.getContents.length - 1)...<Widget>[
                                      const Gap.v16()
                                    ]
                                  ],
                                ),
                                separatorBuilder: (_, int idx) => const Gap.v12(),
                                itemCount: state.getContents.length
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      )
                  )
                ]
              ],
            )
        ),
      ),
    );
  }
}

class ContentsBottomPanelViewV2 extends StatefulWidget {
  final Function() onDragClosed;
  final String address;
  const ContentsBottomPanelViewV2({
    required this.onDragClosed, Key? key,
    this.address = 'Shop 11, The Strand Arcade, 412-414 George St, Sydney NSW 2000, Australia'
  }) : super(key: key);

  @override
  _ContentsBottomPanelViewV2State createState() => _ContentsBottomPanelViewV2State();
}

class _ContentsBottomPanelViewV2State extends State<ContentsBottomPanelViewV2> {

  final DraggableScrollableController controller = DraggableScrollableController();
  List<double> snapSizes = [];
  late final double lowestHeightOfVisibleSnap;
  final double screenHorizontalSpacing = 16;

  final GlobalKey key = GlobalKey();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
      if (box != null) {
        setState(() {
          snapSizes = <double>[0, box.size.height / MediaQuery.of(context).size.height, 0.5, 0.8];
          lowestHeightOfVisibleSnap = snapSizes[1];
        });
      }
    });
    // snapSizes = <double>[0, 0.25, 0.5, 0.8];
    // lowestHeightOfVisibleSnap = snapSizes[1];
    controller.addListener(() {
      if (controller.size < lowestHeightOfVisibleSnap) {
        widget.onDragClosed.call();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('snapSizes : $snapSizes');
    if (snapSizes.isEmpty) {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          key: key,
          children: [
            // const Gap.v08(),
            /// Why did we add unnecessary ListView here ?
            /// We want to archive UX : User can drag this Divider up/down to change
            /// contents panel height and the LocationAddressBoxView will stick
            /// at the top, not be scrolled away.
            /// To make Divider draggable :
            ///   We can change Column to ListView and assign controller to it.
            ///     - With this the Divider can be draggable, but when user drag
            ///       to change size, the LocationAddressBoxView will be scrolled too.
            ///     -> Solution :
            ///        - Wrap the whole content with Column
            ///        - Wrap the Divider with ListView and assign controller to it. (it will be draggable)
            ///        - Add controller to contents list, so user can scroll to view all contents
            ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: <Widget>[
                /// Divider
                Container(
                  /// The reason we used margin instead of Gaps here is because
                  /// we want to make this Container as big as possible, so
                  /// user can easily hold and drag
                  margin: const EdgeInsets.only(top: 8, bottom: 16),
                  width: double.infinity,
                  alignment: Alignment.center,
                  height: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 2,
                        width: MediaQuery.of(context).size.width * .13,
                        decoration: BoxDecoration(
                            color: NartusColor.grey,
                            borderRadius: BorderRadius.circular(Dimension.spacing2)
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            // const Gap.v16(),
            Container(
              margin: EdgeInsets.only(
                left: screenHorizontalSpacing, right: screenHorizontalSpacing,
                // bottom: MediaQuery.of(context).viewPadding.bottom
              ),
              child: LocationAddressBoxView(address: widget.address),
            ),
            const Gap.v20(),
            const Gap.v04(),
          ],
        ),
      );
    }
    return DraggableScrollableSheet(
      initialChildSize: lowestHeightOfVisibleSnap,
      controller: controller,
      maxChildSize: snapSizes[snapSizes.length - 1],
      minChildSize: snapSizes.first,
      snapSizes: snapSizes,
      snap: true,
      builder: (_, ScrollController innerController) {
        return Container(
          color: Colors.white,
          child: Column(
            // padding: EdgeInsets.zero,
            // controller: controller,
            children: <Widget>[
              Column(
                key: key,
                children: [
                  // const Gap.v08(),
                  /// Why did we add unnecessary ListView here ?
                  /// We want to archive UX : User can drag this Divider up/down to change
                  /// contents panel height and the LocationAddressBoxView will stick
                  /// at the top, not be scrolled away.
                  /// To make Divider draggable :
                  ///   We can change Column to ListView and assign controller to it.
                  ///     - With this the Divider can be draggable, but when user drag
                  ///       to change size, the LocationAddressBoxView will be scrolled too.
                  ///     -> Solution :
                  ///        - Wrap the whole content with Column
                  ///        - Wrap the Divider with ListView and assign controller to it. (it will be draggable)
                  ///        - Add controller to contents list, so user can scroll to view all contents
                  ListView(
                    padding: EdgeInsets.zero,
                    controller: innerController,
                    shrinkWrap: true,
                    children: <Widget>[
                      /// Divider
                      Container(
                        /// The reason we used margin instead of Gaps here is because
                        /// we want to make this Container as big as possible, so
                        /// user can easily hold and drag
                        margin: const EdgeInsets.only(top: 8, bottom: 16),
                        width: double.infinity,
                        alignment: Alignment.center,
                        height: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 2,
                              width: MediaQuery.of(context).size.width * .13,
                              decoration: BoxDecoration(
                                  color: NartusColor.grey,
                                  borderRadius: BorderRadius.circular(Dimension.spacing2)
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  // const Gap.v16(),
                  Container(
                    margin: EdgeInsets.only(
                      left: screenHorizontalSpacing, right: screenHorizontalSpacing,
                      // bottom: MediaQuery.of(context).viewPadding.bottom
                    ),
                    child: LocationAddressBoxView(address: widget.address),
                  ),
                  const Gap.v20(),
                  const Gap.v04(),
                ],
              ),
              if (controller.isAttached && controller.size > snapSizes[1])...[
                Flexible(
                    child: Container(
                      padding: EdgeInsets.only(left: screenHorizontalSpacing, right: screenHorizontalSpacing),
                      child: BlocBuilder<GetContentsBloc, GetContentsState>(
                        builder: (_, GetContentsState state) {
                          if (state.isGettingContentsState) {
                            return const LoadingIndicator();
                          } else if (state.isDataEmptyState) {
                            return const SizedBox();
                          } else if (state.isGetContentsFailedState) {
                            return ErrorView(error: state.getContentsError,);
                          } else if (state.isGetContentsSucceedState) {
                            return ListView.separated(
                              // controller: controller,
                                cacheExtent: 200,
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                // physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (_, int idx) => Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    ContentCardView(
                                      screenEdgeSpacing: screenHorizontalSpacing,
                                      content: state.getContents[idx],
                                    ),
                                    if (idx == state.getContents.length - 1)...<Widget>[
                                      const Gap.v16()
                                    ]
                                  ],
                                ),
                                separatorBuilder: (_, int idx) => const Gap.v12(),
                                itemCount: state.getContents.length
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    )
                )
              ]
            ],
          ),
        );
      }
    );
  }
}