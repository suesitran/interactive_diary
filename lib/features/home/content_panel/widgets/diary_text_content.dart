part of 'content_card_view.dart';

class _DiaryTextContent extends StatelessWidget {
  final String content;

  const _DiaryTextContent({required this.content, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: NartusDimens.padding16),
        child: Text(
          content,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
}
