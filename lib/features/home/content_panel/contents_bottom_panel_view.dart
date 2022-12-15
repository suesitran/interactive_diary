import 'package:interactive_diary/widgets/location_view.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

class ContentsBottomPanelController {
  void show() {}

  void dismiss() {}
}

class ContentsBottomPanelView extends StatelessWidget {
  final ContentsBottomPanelController controller;

  const ContentsBottomPanelView({required this.controller, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: NartusColor.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(NartusDimens.padding24),
            topRight: Radius.circular(NartusDimens.padding24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // handler
          Container(
            width: 48,
            height: 2,
            color: NartusColor.grey,
            margin: const EdgeInsets.only(top: 8),
          ),
          // location view
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LocationView(
              currentLocation:
                  'Shop 11, The Strand Arcade, 412-414 George St, Sydney NSW 2000, Australia',
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Container(
            height: 0,
            child: ListView.builder(itemBuilder: (BuildContext context, int index) {
              return const Padding(padding: EdgeInsets.all(8.0), child: Text('hehehe'),);
            },
            itemCount: 10,
            shrinkWrap: true,),
          )
        ],
      ),
    );
  }
}
