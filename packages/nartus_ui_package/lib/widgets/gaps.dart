import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  final double? vGap;
  final double? hGap;
  const Gap.v32({Key? key})
      : vGap = 32.0,
        hGap = 0.0,
        super(key: key);
  const Gap.v20({Key? key})
      : vGap = 20.0,
        hGap = 0.0,
        super(key: key);
  const Gap.v16({Key? key})
      : vGap = 16.0,
        hGap = 0.0,
        super(key: key);
  const Gap.v12({Key? key})
      : vGap = 12.0,
        hGap = 0.0,
        super(key: key);
  const Gap.v08({Key? key})
      : vGap = 8.0,
        hGap = 0.0,
        super(key: key);
  const Gap.v04({Key? key})
      : vGap = 4.0,
        hGap = 0.0,
        super(key: key);

  const Gap.h20({Key? key})
      : hGap = 20.0,
        vGap = 0.0,
        super(key: key);
  const Gap.h16({Key? key})
      : hGap = 16.0,
        vGap = 0.0,
        super(key: key);
  const Gap.h12({Key? key})
      : hGap = 12.0,
        vGap = 0.0,
        super(key: key);
  const Gap.h08({Key? key})
      : hGap = 8.0,
        vGap = 0.0,
        super(key: key);
  const Gap.h04({Key? key})
      : hGap = 4.0,
        vGap = 0.0,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: vGap,
      width: hGap,
    );
  }
}
