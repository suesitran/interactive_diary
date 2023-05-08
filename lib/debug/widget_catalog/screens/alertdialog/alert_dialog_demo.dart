import 'package:flutter/material.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

class AlertDialogDemo extends StatelessWidget {
  const AlertDialogDemo({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Alert Dialog demo'),
        ),
        body: SingleChildScrollView(
          child: Column(
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
                            'This ID alert dialog has primary and secondary button',
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
                            'This ID alert dialog has primary and text button',
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
                        title:
                            'Warning Headline very very very very very very very long long long',
                        content:
                            'This ID alert dialog has primary and text button, This ID alert dialog has primary and text button,, This ID alert dialog has primary and text button, This ID alert dialog has primary and text button,',
                        primaryButtonText: 'Primary button',
                        onPrimaryButtonSelected: () {
                          Navigator.of(context).pop();
                        },
                        textButtonText: 'Text button',
                        onTextButtonSelected: () {
                          Navigator.of(context).pop();
                        });
                  },
                  child: const Text('Primary & Long Title & Long Content')),
              TextButton(
                onPressed: () {
                  context.showIDAlertDialog(
                      title:
                          'Warning Headline very very very very very very very long long long',
                      content:
                          'This ID alert dialog has primary and text button, This ID alert dialog has primary and text button,, This ID alert dialog has primary and text button, This ID alert dialog has primary and text button,',
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
                        iconPath: Assets.images.danger);
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
                        iconPath: Assets.images.danger);
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
                        iconPath: Assets.images.danger);
                  },
                  child: const Text('Primary & Text button With icon')),
              TextButton(
                  onPressed: () {
                    context.showIDAlertDialog(
                        title:
                            'Warning Headline very very very very very very very long long long',
                        content:
                            'This ID alert dialog has primary and text button, This ID alert dialog has primary and text button,, This ID alert dialog has primary and text button, This ID alert dialog has primary and text button,',
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
                        iconPath: Assets.images.danger);
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
                        iconPath: Assets.images.danger);
                  },
                  child: const Text(
                      'Persistent alert dialog - 3 buttons With icon')),
            ],
          ),
        ),
      );
}
