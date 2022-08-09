import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

class IDHome extends Screen {
  const IDHome({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context) => Stack(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: const GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(-37.815561, 144.968915), zoom: 15),
            ),
          )
        ],
      );
}
