import 'package:flutter/material.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

part 'cta_button_type_screen.dart';

class CTAButtonsScreen extends StatefulWidget {
  const CTAButtonsScreen({Key? key}) : super(key: key);

  @override
  State<CTAButtonsScreen> createState() => _CTAButtonsScreenState();
}

class _CTAButtonsScreenState extends State<CTAButtonsScreen>
    with SingleTickerProviderStateMixin {
  final int _numDots = 6;
  late final TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: _numDots, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CTA Buttons demo'),
        ),
        body: Stack(children: [
          PageView(
            onPageChanged: (index) {
              setState(() {
                _controller.index = index;
              });
            },
            children: [
              // primary large
              ButtonsDemoPage(
                title: 'Primary large',
                defaults: [
                  _demoButton('52px - primary button - text only - active',
                      NartusButton.primary(label: 'Demo', onPressed: () {})),
                  _demoButton(
                      '52px - primary button - left icon - active',
                      NartusButton.primary(
                        label: 'Demo',
                        iconPath: Assets.images.calendar,
                        iconSemanticLabel: 'Calendar',
                        onPressed: () {},
                      )),
                  _demoButton(
                      '52px - primary button - right icon - active',
                      NartusButton.primary(
                        label: 'Demo',
                        iconPath: Assets.images.calendar,
                        iconSemanticLabel: 'Calendar',
                        onPressed: () {},
                        iconPosition: IconPosition.right,
                      )),
                  _demoButton(
                      '52px - primary button - icon only - active',
                      NartusButton.primary(
                        iconPath: Assets.images.calendar,
                        iconSemanticLabel: 'Calendar',
                        onPressed: () {},
                        iconPosition: IconPosition.right,
                      )),
                ],
                disabled: [
                  _demoButton('52px - primary button - text only - disable',
                      const NartusButton.primary(label: 'Demo')),
                  _demoButton(
                      '52px - primary button - left icon - disable',
                      NartusButton.primary(
                        label: 'Demo',
                        iconPath: Assets.images.calendar,
                        iconSemanticLabel: 'Calendar',
                      )),
                  _demoButton(
                      '52px - primary button - right icon - disable',
                      NartusButton.primary(
                        label: 'Demo',
                        iconPath: Assets.images.calendar,
                        iconSemanticLabel: 'Calendar',
                        iconPosition: IconPosition.right,
                      )),
                  _demoButton(
                      '52px - primary button - icon only - disable',
                      NartusButton.primary(
                        iconPath: Assets.images.calendar,
                        iconSemanticLabel: 'Calendar',
                        iconPosition: IconPosition.right,
                      )),
                ],
              ),
              // primary small
              ButtonsDemoPage(title: 'Primary small', defaults: [
                _demoButton(
                    '44px - primary button - text only - active',
                    NartusButton.primary(
                      label: 'Demo',
                      onPressed: () {},
                      sizeType: SizeType.small,
                    )),
                _demoButton(
                    '44px - primary button - left icon - active',
                    NartusButton.primary(
                        label: 'Demo',
                        iconPath: Assets.images.calendar,
                        iconSemanticLabel: 'Calendar',
                        onPressed: () {},
                        sizeType: SizeType.small)),
                _demoButton(
                    '44px - primary button - right icon - active',
                    NartusButton.primary(
                        label: 'Demo',
                        iconPath: Assets.images.calendar,
                        iconSemanticLabel: 'Calendar',
                        onPressed: () {},
                        iconPosition: IconPosition.right,
                        sizeType: SizeType.small)),
                _demoButton(
                    '44px - primary button - icon only - active',
                    NartusButton.primary(
                        iconPath: Assets.images.calendar,
                        iconSemanticLabel: 'Calendar',
                        onPressed: () {},
                        iconPosition: IconPosition.right,
                        sizeType: SizeType.small)),
              ], disabled: [
                _demoButton(
                    '44px - primary button - text only - disable',
                    const NartusButton.primary(
                      label: 'Demo',
                      sizeType: SizeType.small,
                    )),
                _demoButton(
                    '44px - primary button - left icon - disable',
                    NartusButton.primary(
                        label: 'Demo',
                        iconPath: Assets.images.calendar,
                        iconSemanticLabel: 'Calendar',
                        sizeType: SizeType.small)),
                _demoButton(
                    '44px - primary button - right icon - disable',
                    NartusButton.primary(
                        label: 'Demo',
                        iconPath: Assets.images.calendar,
                        iconSemanticLabel: 'Calendar',
                        iconPosition: IconPosition.right,
                        sizeType: SizeType.small)),
                _demoButton(
                    '44px - primary button - icon only - disable',
                    NartusButton.primary(
                        iconPath: Assets.images.calendar,
                        iconSemanticLabel: 'Calendar',
                        iconPosition: IconPosition.right,
                        sizeType: SizeType.small)),
              ]),
              // secondary large
              ButtonsDemoPage(title: 'Secondary large', defaults: [
                _demoButton('52px - secondary button - text only - active',
                    NartusButton.secondary(label: 'Demo', onPressed: () {})),
                _demoButton(
                    '52px - secondary button - left icon - active',
                    NartusButton.secondary(
                      label: 'Demo',
                      iconPath: Assets.images.calendar,
                      iconSemanticLabel: 'Calendar',
                      onPressed: () {},
                    )),
                _demoButton(
                    '52px - secondary button - right icon - active',
                    NartusButton.secondary(
                      label: 'Demo',
                      iconPath: Assets.images.calendar,
                      iconSemanticLabel: 'Calendar',
                      onPressed: () {},
                      iconPosition: IconPosition.right,
                    )),
                _demoButton(
                    '52px - secondary button - icon only - active',
                    NartusButton.secondary(
                      iconPath: Assets.images.calendar,
                      iconSemanticLabel: 'Calendar',
                      onPressed: () {},
                      iconPosition: IconPosition.right,
                    )),
              ], disabled: [
                _demoButton('52px - secondary button - text only - disable',
                    const NartusButton.secondary(label: 'Demo')),
                _demoButton(
                    '52px - secondary button - left icon - disable',
                    NartusButton.secondary(
                      label: 'Demo',
                      iconPath: Assets.images.calendar,
                      iconSemanticLabel: 'Calendar',
                    )),
                _demoButton(
                    '52px - secondary button - right icon - disable',
                    NartusButton.secondary(
                      label: 'Demo',
                      iconPath: Assets.images.calendar,
                      iconSemanticLabel: 'Calendar',
                      iconPosition: IconPosition.right,
                    )),
                _demoButton(
                    '52px - secondary button - icon only - disable',
                    NartusButton.secondary(
                      iconPath: Assets.images.calendar,
                      iconSemanticLabel: 'Calendar',
                      iconPosition: IconPosition.right,
                    )),
              ]),
              // secondary small
              ButtonsDemoPage(title: 'Secondary small', defaults: [
                _demoButton(
                    '44px - secondary button - text only - active',
                    NartusButton.secondary(
                      label: 'Demo',
                      onPressed: () {},
                      sizeType: SizeType.small,
                    )),
                _demoButton(
                    '44px - secondary button - left icon - active',
                    NartusButton.secondary(
                        label: 'Demo',
                        iconPath: Assets.images.calendar,
                        iconSemanticLabel: 'Calendar',
                        onPressed: () {},
                        sizeType: SizeType.small)),
                _demoButton(
                    '44px - secondary button - right icon - active',
                    NartusButton.secondary(
                        label: 'Demo',
                        iconPath: Assets.images.calendar,
                        iconSemanticLabel: 'Calendar',
                        onPressed: () {},
                        iconPosition: IconPosition.right,
                        sizeType: SizeType.small)),
                _demoButton(
                    '44px - secondary button - icon only - active',
                    NartusButton.secondary(
                        iconPath: Assets.images.calendar,
                        iconSemanticLabel: 'Calendar',
                        onPressed: () {},
                        iconPosition: IconPosition.right,
                        sizeType: SizeType.small)),
              ], disabled: [
                _demoButton(
                    '44px - secondary button - text only - disable',
                    const NartusButton.secondary(
                      label: 'Demo',
                      sizeType: SizeType.small,
                    )),
                _demoButton(
                    '44px - secondary button - left icon - disable',
                    NartusButton.secondary(
                        label: 'Demo',
                        iconPath: Assets.images.calendar,
                        iconSemanticLabel: 'Calendar',
                        sizeType: SizeType.small)),
                _demoButton(
                    '44px - secondary button - right icon - disable',
                    NartusButton.secondary(
                        label: 'Demo',
                        iconPath: Assets.images.calendar,
                        iconSemanticLabel: 'Calendar',
                        iconPosition: IconPosition.right,
                        sizeType: SizeType.small)),
                _demoButton(
                    '44px - secondary button - icon only - disable',
                    NartusButton.secondary(
                        iconPath: Assets.images.calendar,
                        iconSemanticLabel: 'Calendar',
                        iconPosition: IconPosition.right,
                        sizeType: SizeType.small)),
              ]),
              // text large
              ButtonsDemoPage(title: 'Text large', defaults: [
                _demoButton('52px - text button - text only - active',
                    NartusButton.text(label: 'Demo', onPressed: () {})),
                _demoButton(
                    '52px - text button - left icon - active',
                    NartusButton.text(
                      label: 'Demo',
                      iconPath: Assets.images.calendar,
                      iconSemanticLabel: 'Calendar',
                      onPressed: () {},
                    )),
                _demoButton(
                    '52px - text button - right icon - active',
                    NartusButton.text(
                      label: 'Demo',
                      iconPath: Assets.images.calendar,
                      iconSemanticLabel: 'Calendar',
                      onPressed: () {},
                      iconPosition: IconPosition.right,
                    )),
                _demoButton(
                    '52px - text button - icon only - active',
                    NartusButton.text(
                      iconPath: Assets.images.calendar,
                      iconSemanticLabel: 'Calendar',
                      onPressed: () {},
                      iconPosition: IconPosition.right,
                    )),
              ], disabled: [
                _demoButton('52px - text button - text only - disable',
                    const NartusButton.text(label: 'Demo')),
                _demoButton(
                    '52px - text button - left icon - disable',
                    NartusButton.text(
                      label: 'Demo',
                      iconPath: Assets.images.calendar,
                      iconSemanticLabel: 'Calendar',
                    )),
                _demoButton(
                    '52px - text button - right icon - disable',
                    NartusButton.text(
                      label: 'Demo',
                      iconPath: Assets.images.calendar,
                      iconSemanticLabel: 'Calendar',
                      iconPosition: IconPosition.right,
                    )),
                _demoButton(
                    '52px - text button - icon only - disable',
                    NartusButton.text(
                      iconPath: Assets.images.calendar,
                      iconSemanticLabel: 'Calendar',
                      iconPosition: IconPosition.right,
                    )),
              ]),
              // secondary small
              ButtonsDemoPage(title: 'Text small', defaults: [
                _demoButton(
                    '44px - secondary button - text only - active',
                    NartusButton.text(
                      label: 'Demo',
                      onPressed: () {},
                      sizeType: SizeType.small,
                    )),
                _demoButton(
                    '44px - text button - left icon - active',
                    NartusButton.text(
                        label: 'Demo',
                        iconPath: Assets.images.calendar,
                        iconSemanticLabel: 'Calendar',
                        onPressed: () {},
                        sizeType: SizeType.small)),
                _demoButton(
                    '44px - text button - right icon - active',
                    NartusButton.text(
                        label: 'Demo',
                        iconPath: Assets.images.calendar,
                        iconSemanticLabel: 'Calendar',
                        onPressed: () {},
                        iconPosition: IconPosition.right,
                        sizeType: SizeType.small)),
                _demoButton(
                    '44px - text button - icon only - active',
                    NartusButton.text(
                        iconPath: Assets.images.calendar,
                        iconSemanticLabel: 'Calendar',
                        onPressed: () {},
                        iconPosition: IconPosition.right,
                        sizeType: SizeType.small)),
              ], disabled: [
                _demoButton(
                    '44px - secondary button - text only - disable',
                    const NartusButton.text(
                      label: 'Demo',
                      sizeType: SizeType.small,
                    )),
                _demoButton(
                    '44px - text button - left icon - disable',
                    NartusButton.text(
                        label: 'Demo',
                        iconPath: Assets.images.calendar,
                        iconSemanticLabel: 'Calendar',
                        sizeType: SizeType.small)),
                _demoButton(
                    '44px - text button - right icon - disable',
                    NartusButton.text(
                        label: 'Demo',
                        iconPath: Assets.images.calendar,
                        iconSemanticLabel: 'Calendar',
                        iconPosition: IconPosition.right,
                        sizeType: SizeType.small)),
                _demoButton(
                    '44px - text button - icon only - disable',
                    NartusButton.text(
                        iconPath: Assets.images.calendar,
                        iconSemanticLabel: 'Calendar',
                        iconPosition: IconPosition.right,
                        sizeType: SizeType.small)),
              ]),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TabPageSelector(
              controller: _controller,
              color: NartusColor.primary,
            ),
          )
        ]));
  }

  Widget _demoButton(String label, Widget widget) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(label),
            ),
            widget
          ],
        ),
      );
}
