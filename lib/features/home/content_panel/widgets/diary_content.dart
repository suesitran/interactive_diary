part of 'content_card_view.dart';

enum DiaryDisplayType { textOnly, thumbnailsOnly, textWithThumbnails }

class _DiaryContent extends StatelessWidget {
  final String? text;
  final List<MediaInfo> mediaInfo;
  final DiaryDisplayType type;

  late final int maxThumbnailDisplay;

  _DiaryContent({this.text, List<MediaInfo>? mediaInfos, Key? key})
      : assert(text != null || mediaInfos?.isNotEmpty == true),
        mediaInfo = mediaInfos ?? [],
        type = text == null || text.isEmpty == true
            ? DiaryDisplayType.thumbnailsOnly
            : mediaInfos == null || mediaInfos.isEmpty == true
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
              _MediaView(info: mediaInfo.first)
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
                  int lastIndex = min(mediaInfo.length, maxThumbnailDisplay);

                  return Padding(
                    padding: const EdgeInsets.only(top: NartusDimens.padding4),
                    child: Row(
                      children: mediaInfo
                          .sublist(
                              type == DiaryDisplayType.thumbnailsOnly ? 1 : 0,
                              lastIndex)
                          .asMap()
                          .entries
                          .map((e) {
                        return Padding(
                          padding: EdgeInsets.only(
                              right: e.key == 2 ? 0 : NartusDimens.padding4),
                          child: Stack(
                            children: [
                              _MediaView(
                                info: e.value,
                                size: size,
                              ),
                              if (e.key == 2 &&
                                  mediaInfo.length > maxThumbnailDisplay)
                                Container(
                                  color: NartusColor.black.withOpacity(0.6),
                                  width: size,
                                  height: size,
                                  alignment: Alignment.center,
                                  child: Text(
                                    S.current.extraImageCount(
                                        mediaInfo.length - maxThumbnailDisplay),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(color: NartusColor.white),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                            ],
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

class _MediaView extends StatelessWidget {
  final String path;
  final bool isVideo;
  final double? size;
  _MediaView({required MediaInfo info, this.size, Key? key})
      : path = info.imageUrl,
        isVideo = info.isVideo,
        super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(NartusDimens.radius12)),
            clipBehavior: Clip.hardEdge,
            constraints: const BoxConstraints(maxHeight: 240),
            child: path.startsWith('http')
                ? Image.network(
                    path,
                    fit: BoxFit.cover,
                    width: size,
                    height: size,
                  )
                : Image.file(
                    File(path),
                    fit: BoxFit.cover,
                    width: size,
                    height: size,
                  ),
          ),
          if (isVideo)
            SvgPicture.asset(
              Assets.icon.play,
              width: 40,
              height: 40,
            )
        ],
      );
}
