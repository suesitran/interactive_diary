import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';
import 'package:nartus_ui_package/widgets/gaps.dart';
import 'package:interactive_diary/gen/assets.gen.dart';

class ContentCardView extends StatelessWidget {
  final double screenEdgeSpacing;
  const ContentCardView({required this.screenEdgeSpacing, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String text =
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
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              child: Image.network(
                  'https://ps.w.org/user-avatar-reloaded/assets/icon-128x128.png?rev=2540745'),
            ),
            const Gap.h12(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Hoang Nguyen',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Gap.v04(),
                Row(
                  children: <Widget>[
                    Text(
                      'Sep 3, 2022 at 10:12 PM',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Gap.h04(),
                    const Text('•'),
                    const Gap.h04(),
                    // Icon(Icons.supervised_user_circle_sharp, color: NartusColor.grey,),
                    SvgPicture.asset(
                      Assets.images.idProfileUserIconPadding,
                      color: NartusColor.grey,
                    )
                  ],
                )
              ],
            ),
            const Spacer(),
            // Icon(Icons.menu, color: NartusColor.grey,)
            SvgPicture.asset(Assets.images.idMoreIcon)
          ],
        ),
        const Gap.v08(),
        if (text.isNotEmpty) ...<Widget>[
          _textAndImageView(text, images, context, screenEdgeSpacing)
        ] else if (images.isNotEmpty)
          ...<Widget>[],
        const Gap.v16(),
        Row(
          children: <Widget>[
            // Icon(Icons.heart_broken),
            SvgPicture.asset(Assets.images.idHeartIconPadding),
            const Gap.h16(),
            // Icon(Icons.heart_broken),
            SvgPicture.asset(Assets.images.idMessageIconPadding),
            const Gap.h16(),
            // Icon(Icons.heart_broken),
            SvgPicture.asset(Assets.images.idShareIconPadding),
            const Spacer(),
            Text(
              '5 likes',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Gap.h04(),
            const Text('•'),
            const Gap.h04(),
            Text(
              '4 comments',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        )
      ],
    );
  }

  Widget _textAndImageView(String text, List<String> images,
      BuildContext context, double screenEdgeSpacing) {
    const int itemsEachRow = 3;
    const double imageSpacing = 4;
    final Size size = MediaQuery.of(context).size;
    final double imageWidth = (size.width -
            (2 * screenEdgeSpacing) -
            ((itemsEachRow - 1) * imageSpacing)) /
        itemsEachRow;
    final bool isHaveMoreImagesThanItemsEachRow = images.length > itemsEachRow;
    final List<String> displayImages = isHaveMoreImagesThanItemsEachRow
        ? images.take(itemsEachRow).toList()
        : images;
    return Column(
      children: <Widget>[
        Text(
          text,
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.7),
          textAlign: TextAlign.justify,
        ),
        if (images.isNotEmpty) ...<Widget>[
          const Gap.v12(),
          Row(
            children: <Widget>[
              ...displayImages.asMap().entries.map((MapEntry<int, String> e) {
                return Container(
                  padding: e.key == (itemsEachRow - 1)
                      ? EdgeInsets.zero
                      : const EdgeInsets.only(right: imageSpacing),
                  width: imageWidth,
                  child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(e.value),
                                      fit: BoxFit.cover)),
                            ),
                            if (e.key == (itemsEachRow - 1) &&
                                isHaveMoreImagesThanItemsEachRow) ...<Widget>[
                              Positioned(
                                  top: 0,
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    color:
                                        Colors.grey.shade300.withOpacity(0.5),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '+ ${images.length - itemsEachRow}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(color: NartusColor.white),
                                    ),
                                  ))
                            ]
                          ],
                        ),
                      )),
                );
              }),
              // ...displayImages.map((e) => Stack(
              //   children: [
              //     Container(
              //       padding: images.indexOf(e) == (itemsEachRow - 1)
              //           ? EdgeInsets.zero : const EdgeInsets.only(right: imageSpacing),
              //       width: imageWidth,
              //       child: AspectRatio(
              //         aspectRatio: 1,
              //         child: Container(
              //           decoration: BoxDecoration(
              //             image: DecorationImage(
              //               image: NetworkImage(e),
              //               fit: BoxFit.contain
              //             )
              //           ),
              //         ),
              //       ),
              //     ),
              //     // AspectRatio(
              //     //   aspectRatio: 1,
              //     //   child: ,
              //     // ),
              //     if (images.indexOf(e) == (itemsEachRow - 1) && isHaveMoreImagesThanItemsEachRow)...[
              //       Container(
              //         color: Colors.grey.shade300,
              //         child: Text('+ ${images.length - itemsEachRow}', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: NartusColor.white),),
              //       )
              //     ]
              //   ],)
              // )
            ],
          )
        ]
      ],
    );
  }
}
