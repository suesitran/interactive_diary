import 'package:flutter/material.dart';

class MarkerIcon extends StatelessWidget {
  double height;
  final GlobalKey? globalKeyMyWidget;
  MarkerIcon({
    Key? key,
    required this.height,
    this.globalKeyMyWidget,
  }) : super(key: key);

  final GlobalKey globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    double markerWidth = (height) / 5 * 4;
    return RepaintBoundary(
      key: globalKeyMyWidget,
      child: Stack(
        children: [
          Image.asset(
            ('assets/images/ic_marker.png'),
            height: height,
            width: markerWidth,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: markerWidth / 4,
              left: markerWidth / 4,
              right: markerWidth / 4,
            ),
            child: Image.asset(
              ('assets/images/ic_person.png'),
              height: markerWidth / 2,
              width: markerWidth / 2,
            ),
          ),
        ],
      ),
    );
  }
}
