import 'package:flutter/material.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';

part 'diary_header.dart';
part 'diary_text_content.dart';
part 'diary_thumbnail_content.dart';

class ContentCardView extends StatelessWidget {

  final String text =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
      'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad '
      'minim veniam, quis nostrud exercitation ullamco laboris Lorem ipsum dolor sit amet, '
      'consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et '
      'dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris';
  final List<String> images = <String>[
    'https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg',
    'https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg',
    'https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg',
    'https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg',
  ];
  ContentCardView({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: NartusDimens.padding16, right: NartusDimens.radius16, bottom: NartusDimens.radius16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _DiaryHeader(),
          _DiaryTextContent(),
          _DiaryThumbnailContent()
        ],
      ),
    );
  }
}

