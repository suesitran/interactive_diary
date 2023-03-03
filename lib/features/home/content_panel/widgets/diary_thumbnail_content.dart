part of 'content_card_view.dart';

class _DiaryThumbnailContent extends StatelessWidget {
  final List<String> thumbnailList;

  final int maxDisplay = 3;

  const _DiaryThumbnailContent({required this.thumbnailList, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (_, constraints) {
          final double size =
              (constraints.maxWidth - NartusDimens.padding4 * 2) / maxDisplay;

          return thumbnailList.isEmpty
              ? const SizedBox.shrink()
              : Row(
                  children: thumbnailList
                      .sublist(0, max(thumbnailList.length, maxDisplay) - 1)
                      .asMap()
                      .entries
                      .map((e) => Padding(
                            padding: EdgeInsets.only(
                                right: e.key == maxDisplay - 1
                                    ? 0
                                    : NartusDimens.padding4),
                            child: Image.network(
                              e.value,
                              width: size,
                              height: size,
                              fit: BoxFit.cover,
                            ),
                          ))
                      .toList(),
                );
        },
      );
}
