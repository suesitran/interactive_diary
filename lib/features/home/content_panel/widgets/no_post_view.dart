import 'package:flutter_svg/flutter_svg.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

class NoPostView extends StatelessWidget {
  const NoPostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            SvgPicture.asset(Assets.images.diaryListNoPost),
            const SizedBox(
              height: NartusDimens.padding24,
            ),
            Text(
              S.current.noPost,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: NartusColor.dark),
            ),
            const SizedBox(
              height: NartusDimens.padding8,
            ),
            Text(
              S.current.noPostHasBeenPostedYet,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: NartusColor.grey),
            )
          ],
        ),
      );
}
