import 'package:flutter/material.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

class AlertDialogDemo extends StatelessWidget {
  const AlertDialogDemo({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Alert Dialog demo'),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
                onPressed: () {
                  context.showIDAlertDialog(
                      title: 'Warning Headline',
                      content: 'This is a content',
                      primaryButtonText: 'Primary button',
                      onPrimaryButtonSelected: () {
                        Navigator.of(context).pop();
                      });
                },
                child: const Text('primary button only')),
            TextButton(
                onPressed: () {
                  context.showIDAlertDialog(
                      title: 'Warning Headline',
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
                  context.showIDAlertDialog(
                      title: 'Warning Headline',
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
                context.showIDAlertDialog(
                    title: 'Warning Headline',
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
                  context.showIDAlertDialog(
                      title: 'Warning Headline',
                      content: 'Mi ut pretium, convansi, gravida impresdte',
                      primaryButtonText: 'Primary',
                      onPrimaryButtonSelected: () {
                        Navigator.of(context).pop();
                      },
                      iconPath: 'assets/danger.svg');
                },
                child: const Text('Primary button With icon')),
            TextButton(
                onPressed: () {
                  context.showIDAlertDialog(
                      title: 'Warning Headline',
                      content: 'Mi ut pretium, convansi, gravida impresdte',
                      primaryButtonText: 'Primary',
                      onPrimaryButtonSelected: () {
                        Navigator.of(context).pop();
                      },
                      secondaryButtonText: 'Secondary button',
                      onSecondaryButtonSelected: () {
                        Navigator.of(context).pop();
                      },
                      iconPath: 'assets/danger.svg');
                },
                child: const Text('Primary & secondary button With icon')),
            TextButton(
                onPressed: () {
                  context.showIDAlertDialog(
                      title: 'Warning Headline',
                      content: 'Mi ut pretium, convansi, gravida impresdte',
                      primaryButtonText: 'Primary',
                      onPrimaryButtonSelected: () {
                        Navigator.of(context).pop();
                      },
                      textButtonText: 'Text button',
                      onTextButtonSelected: () {
                        Navigator.of(context).pop();
                      },
                      iconPath: 'assets/danger.svg');
                },
                child: const Text('Primary & Text button With icon')),
            TextButton(
                onPressed: () {
                  context.showIDAlertDialog(
                      title: 'Warning Headline',
                      content: 'Mi ut pretium, convansi, gravida impresdte',
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
                      iconPath: 'assets/danger.svg');
                },
                child: const Text('3 buttons With icon')),
            TextButton(
                onPressed: () {
                  context.showIDAlertDialog(
                      title: 'Warning Headline',
                      content: 'Mi ut pretium, convansi, gravida impresdte',
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
                      iconPath: 'assets/danger.svg');
                },
                child: const Text(
                    'Persistent bottom sheet - 3 buttons With icon')),
          ],
        ),
      );
}
