import 'package:flutter_svg/svg.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import 'package:interactive_diary/gen/assets.gen.dart';

class LocationAddressBoxView extends StatelessWidget {
  final String address;
  const LocationAddressBoxView({required this.address, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          gradient: NartusColor.gradient,
          borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15, width: 15,
            child: SvgPicture.asset(Assets.images.idLocationMarkerIcon, semanticsLabel: 'Current location address : $address',),
          ),
          const Gap.h08(),
          Expanded(
              child: Text(address, style: Theme.of(context).textTheme.bodySmall,)
          )
        ],
      ),
    );
  }
}