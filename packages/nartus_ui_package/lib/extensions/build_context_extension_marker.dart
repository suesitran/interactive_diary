import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

extension BuildContextExtension on BuildContext {
  void showMarkerAdaptive({
    required GlobalKey iconKey,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getMarkerWidget() {
        return Transform.translate(
          offset: Offset(50, 50),
          child: RepaintBoundary(
            key: iconKey,
            child: SizedBox(
              height: 40,
              width: 40,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/ic_marker.png'),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}
