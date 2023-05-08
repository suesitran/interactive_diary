part of 'content_card_view.dart';

enum DiaryDisplayType { textOnly, thumbnailsOnly, textWithThumbnails }

class _DiaryContent extends StatelessWidget {
  final String? text;
  final List<String> images;
  final DiaryDisplayType type;

  late final int maxThumbnailDisplay;

  _DiaryContent({this.text, List<String>? images, Key? key})
      : assert(text != null || images?.isNotEmpty == true),
        images = images ?? [],
        type = text == null || text.isEmpty == true
            ? DiaryDisplayType.thumbnailsOnly
            : images == null || images.isEmpty == true
                ? DiaryDisplayType.textOnly
                : DiaryDisplayType.textWithThumbnails,
        super(key: key) {
    maxThumbnailDisplay = type == DiaryDisplayType.thumbnailsOnly ? 4 : 3;
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: NartusDimens.padding16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // first item: show either text or image
            if (type == DiaryDisplayType.thumbnailsOnly)
              ClipRRect(
                  borderRadius: BorderRadius.circular(NartusDimens.radius12),
                  child: Image.network(images.first))
            else
              Text(
                text!,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.start,
              ),
            // second item
            // if text only, do not show this second item
            if (type == DiaryDisplayType.thumbnailsOnly ||
                type == DiaryDisplayType.textWithThumbnails)
              LayoutBuilder(
                builder: (_, constraints) {
                  final double size =
                      (constraints.maxWidth - NartusDimens.padding4 * 2) / 3;
                  int lastIndex = min(images.length, maxThumbnailDisplay);

                  return Padding(
                    padding: const EdgeInsets.only(top: NartusDimens.padding4),
                    child: Row(
                      children: images
                          .sublist(
                              type == DiaryDisplayType.thumbnailsOnly ? 1 : 0,
                              lastIndex)
                          .asMap()
                          .entries
                          .map((e) {
                        return Padding(
                          padding: EdgeInsets.only(
                              right: e.key == 2 ? 0 : NartusDimens.padding4),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(NartusDimens.radius12),
                            child: Stack(
                              children: [
                                Image.network(
                                  e.value,
                                  fit: BoxFit.cover,
                                  width: size,
                                  height: size,
                                ),
                                if (e.key == 2 &&
                                    images.length > maxThumbnailDisplay)
                                  Container(
                                    color: NartusColor.black.withOpacity(0.6),
                                    width: size,
                                    height: size,
                                    alignment: Alignment.center,
                                    child: Text(
                                      S.current.extraImageCount(
                                          images.length - maxThumbnailDisplay),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(color: NartusColor.white),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              )
          ],
        ),
      );
}
