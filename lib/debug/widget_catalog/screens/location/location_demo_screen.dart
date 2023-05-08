import 'package:flutter/material.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

const String demoAddress =
    'Lê Lợi, Phường Bến Thành, Quận 1, Thành phố Hồ Chí Minh, Vietnam';
const String demoBusinessName = 'Ben Thanh Market';
final String demoLocationIcon = Assets.images.idLocationIcon;
const double demoLat = 21.0486596;
const double demoLong = 105.8290833;

class LocationDemoScreen extends StatelessWidget {
  const LocationDemoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('Location view demo'),
      ),
      body: ListView(
        children: <Widget>[
          _DemoItemView(
            title: 'Location have business name & address & icon',
            widget: LocationView(
              businessName: demoBusinessName,
              locationIconSvg: demoLocationIcon,
              address: demoAddress,
              latitude: demoLat,
              longitude: demoLong,
            ),
          ),
          const Gap.v12(),
          const _DemoItemView(
            title: 'Location have business name & address',
            widget: LocationView(
              businessName: demoBusinessName,
              address: demoAddress,
              latitude: demoLat,
              longitude: demoLong,
            ),
          ),
          const Gap.v12(),
          const _DemoItemView(
            title: 'Location with business name but no address',
            widget: LocationView(
              businessName: demoBusinessName,
              latitude: demoLat,
              longitude: demoLong,
            ),
          ),
          const Gap.v12(),
          const _DemoItemView(
            title: 'Location without business name but have address',
            widget: LocationView(
              address:
                  '188 Xô Viết Nghệ Tĩnh, phường 21, Bình Thạnh, Thành phố Hồ Chí Minh, Việt Nam',
              latitude: demoLat,
              longitude: demoLong,
            ),
          ),
          const Gap.v12(),
          const _DemoItemView(
            title: 'Invalid Location (no Business name and address)',
            widget: LocationView(
              latitude: demoLat,
              longitude: demoLong,
            ),
          ),
          const Gap.v12(),
          _DemoItemView(
            title: 'Location view with border radius 12',
            widget: LocationView(
              latitude: demoLat,
              longitude: demoLong,
              locationIconSvg: demoLocationIcon,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const Gap.v12(),
          _DemoItemView(
            title:
                'Location with address and business name take more than 2 lines',
            widget: LocationView(
              businessName: demoBusinessName * 10,
              address: demoAddress * 10,
              latitude: demoLat,
              longitude: demoLong,
            ),
          ),
        ],
      ),
    );
  }
}

class _DemoItemView extends StatelessWidget {
  final String title;
  final Widget widget;
  const _DemoItemView({
    required this.title,
    required this.widget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(NartusDimens.padding20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.grey.shade500),
          ),
          const Gap.v20(),
          widget
        ],
      ),
    );
  }
}
