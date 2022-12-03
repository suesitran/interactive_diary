import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import '../../../bloc/get_contents/get_contents_bloc.dart';
import 'content_card_view.dart';
import 'location_address_box_view.dart';

class MapBottomSheetView extends StatelessWidget {
  // final double screenEdgeSpacing;
  // final ScrollController controller;
  const MapBottomSheetView({
    // required this.screenEdgeSpacing, required this.controller,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 500,
      child: Column(
        // controller: controller,
        children: [
          const Gap.v12(),
          Container(
            height: 2,
            width: 20,
            decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(4.0)
            ),
          ),
          const Gap.v12(),
          Padding(
            padding: EdgeInsets.only(
                left: 16, right: 16,
                bottom: MediaQuery.of(context).viewPadding.bottom
            ),
            child: const LocationAddressBoxView(
              address: 'Shop 11, The Strand Arcade, 412-414 George St, Sydney NSW 2000, Australia',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
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
                    shrinkWrap: true,
                    itemBuilder: (_, int idx) => ContentCardView(
                      screenEdgeSpacing: 16,
                      content: state.getContents[idx],
                    ),
                    separatorBuilder: (_, int idx) => const Gap.v12(),
                    itemCount: state.getContents.length
                  );
                }
                return const SizedBox();
              },
            ),
          )
        ],
      ),
    );
  }
}
