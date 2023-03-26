import 'package:flutter/material.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:interactive_diary/gen/assets.gen.dart';

class BottomSheetDemo extends StatelessWidget {
  const BottomSheetDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Bottom sheet demo'),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
                onPressed: () {
                  context.showIDBottomSheet(
                      title: 'Title',
                      content: 'This is a content',
                      primaryButtonText: 'Primary button',
                      onPrimaryButtonSelected: () {
                        Navigator.of(context).pop();
                      });
                },
                child: const Text('primary button only')),
            TextButton(
                onPressed: () {
                  context.showIDBottomSheet(
                      title: 'Title',
                      content:
                          'This ID bottom sheet has primary and secondary button',
                      primaryButtonText: 'Primary button',
                      onPrimaryButtonSelected: () {
                        Navigator.of(context).pop();
                      },
                      secondaryButtonText: 'Secondary',
                      onSecondaryButtonSelected: () {
                        Navigator.of(context).pop();
                      });
                },
                child: const Text('Primary & secondary button')),
            TextButton(
                onPressed: () {
                  context.showIDBottomSheet(
                      title: 'Title',
                      content:
                          'This ID bottom sheet has primary and text button',
                      primaryButtonText: 'Primary button',
                      onPrimaryButtonSelected: () {
                        Navigator.of(context).pop();
                      },
                      textButtonText: 'Text button',
                      onTextButtonSelected: () {
                        Navigator.of(context).pop();
                      });
                },
                child: const Text('Primary & Text button')),
            TextButton(
              onPressed: () {
                context.showIDBottomSheet(
                    title: 'Title',
                    content: 'This ID bottom sheet has all 3 buttons',
                    primaryButtonText: 'Primary button',
                    onPrimaryButtonSelected: () {
                      Navigator.of(context).pop();
                    },
                    secondaryButtonText: 'Secondary button',
                    onSecondaryButtonSelected: () {
                      Navigator.of(context).pop();
                    },
                    textButtonText: 'Text button',
                    onTextButtonSelected: () {
                      Navigator.of(context).pop();
                    });
              },
              child: const Text('3 buttons'),
            ),
            TextButton(
                onPressed: () {
                  context.showIDBottomSheet(
                      title: 'Title',
                      content: 'This ID bottom sheet has an icon',
                      primaryButtonText: 'Primary',
                      onPrimaryButtonSelected: () {
                        Navigator.of(context).pop();
                      },
                      iconPath: Assets.images.idLocationImg);
                },
                child: const Text('Primary button With icon')),
            TextButton(
                onPressed: () {
                  context.showIDBottomSheet(
                      title: 'Title',
                      content: 'This ID bottom sheet has an icon',
                      primaryButtonText: 'Primary',
                      onPrimaryButtonSelected: () {
                        Navigator.of(context).pop();
                      },
                      secondaryButtonText: 'Secondary button',
                      onSecondaryButtonSelected: () {
                        Navigator.of(context).pop();
                      },
                      iconPath: Assets.images.idLocationImg);
                },
                child: const Text('Primary & secondary button With icon')),
            TextButton(
                onPressed: () {
                  context.showIDBottomSheet(
                      title: 'Title',
                      content: 'This ID bottom sheet has an icon',
                      primaryButtonText: 'Primary',
                      onPrimaryButtonSelected: () {
                        Navigator.of(context).pop();
                      },
                      textButtonText: 'Text button',
                      onTextButtonSelected: () {
                        Navigator.of(context).pop();
                      },
                      iconPath: Assets.images.idLocationImg);
                },
                child: const Text('Primary & Text button With icon')),
            TextButton(
                onPressed: () {
                  context.showIDBottomSheet(
                      title: 'Title',
                      content: 'This ID bottom sheet has an icon',
                      primaryButtonText: 'Primary',
                      onPrimaryButtonSelected: () {
                        Navigator.of(context).pop();
                      },
                      secondaryButtonText: 'Secondary button',
                      onSecondaryButtonSelected: () {
                        Navigator.of(context).pop();
                      },
                      textButtonText: 'Text button',
                      onTextButtonSelected: () {
                        Navigator.of(context).pop();
                      },
                      iconPath: Assets.images.idLocationImg);
                },
                child: const Text('3 buttons With icon')),
            TextButton(
                onPressed: () {
                  context.showIDBottomSheet(
                      title: 'Title',
                      content: 'This ID bottom sheet has an icon',
                      primaryButtonText: 'Primary',
                      onPrimaryButtonSelected: () {
                        Navigator.of(context).pop();
                      },
                      secondaryButtonText: 'Secondary button',
                      onSecondaryButtonSelected: () {
                        Navigator.of(context).pop();
                      },
                      textButtonText: 'Text button',
                      onTextButtonSelected: () {
                        Navigator.of(context).pop();
                      },
                      isDismissible: false,
                      iconPath: Assets.images.idLocationImg);
                },
                child:
                    const Text('Persistent bottom sheet - 3 buttons With icon'))
          ],
        ),
      );
}
