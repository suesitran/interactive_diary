import 'package:flutter/material.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:nartus_ui_package/widgets/buttons/nartus_button.dart';

part 'cta_button_type_screen.dart';

class CTAButtonsScreen extends StatefulWidget {
  const CTAButtonsScreen({Key? key}) : super(key: key);

  @override
  State<CTAButtonsScreen> createState() => _CTAButtonsScreenState();
}

class _CTAButtonsScreenState extends State<CTAButtonsScreen> with SingleTickerProviderStateMixin {
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
        body: Stack(
          children: [
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
                        NartusButton.primary(label: 'Button', onPressed: () {})),
                    _demoButton(
                        '52px - primary button - left icon - active',
                        NartusButton.primary(
                          label: 'Button',
                          iconPath: 'assets/facebook.svg',
                          onPressed: () {},
                        )),
                    _demoButton(
                        '52px - primary button - right icon - active',
                        NartusButton.primary(
                          label: 'Button',
                          iconPath: 'assets/facebook.svg',
                          onPressed: () {},
                          iconPosition: IconPosition.right,
                        )),
                    _demoButton(
                        '52px - primary button - icon only - active',
                        NartusButton.primary(
                          iconPath: 'assets/facebook.svg',
                          onPressed: () {},
                          iconPosition: IconPosition.right,
                        )),
                  ],
                  disabled: [
                    _demoButton('52px - primary button - text only - disable',
                        const NartusButton.primary(label: 'Button')),
                    _demoButton(
                        '52px - primary button - left icon - disable',
                        const NartusButton.primary(
                          label: 'Button',
                          iconPath: 'assets/facebook.svg',
                        )),
                    _demoButton(
                        '52px - primary button - right icon - disable',
                        const NartusButton.primary(
                          label: 'Button',
                          iconPath: 'assets/facebook.svg',
                          iconPosition: IconPosition.right,
                        )),
                    _demoButton(
                        '52px - primary button - icon only - disable',
                        const NartusButton.primary(
                          iconPath: 'assets/facebook.svg',
                          iconPosition: IconPosition.right,
                        )),
                  ],
                ),
                // primary small
                ButtonsDemoPage(title: 'Primary small', defaults: [
                  _demoButton(
                      '44px - primary button - text only - active',
                      NartusButton.primary(
                        label: 'Button',
                        onPressed: () {},
                        sizeType: SizeType.small,
                      )),
                  _demoButton(
                      '44px - primary button - left icon - active',
                      NartusButton.primary(
                          label: 'Button',
                          iconPath: 'assets/facebook.svg',
                          onPressed: () {},
                          sizeType: SizeType.small)),
                  _demoButton(
                      '44px - primary button - right icon - active',
                      NartusButton.primary(
                          label: 'Button',
                          iconPath: 'assets/facebook.svg',
                          onPressed: () {},
                          iconPosition: IconPosition.right,
                          sizeType: SizeType.small)),
                  _demoButton(
                      '44px - primary button - icon only - active',
                      NartusButton.primary(
                          iconPath: 'assets/facebook.svg',
                          onPressed: () {},
                          iconPosition: IconPosition.right,
                          sizeType: SizeType.small)),
                ], disabled: [
                  _demoButton(
                      '44px - primary button - text only - disable',
                      const NartusButton.primary(
                        label: 'Button',
                        sizeType: SizeType.small,
                      )),
                  _demoButton(
                      '44px - primary button - left icon - disable',
                      const NartusButton.primary(
                          label: 'Button',
                          iconPath: 'assets/facebook.svg',
                          sizeType: SizeType.small)),
                  _demoButton(
                      '44px - primary button - right icon - disable',
                      const NartusButton.primary(
                          label: 'Button',
                          iconPath: 'assets/facebook.svg',
                          iconPosition: IconPosition.right,
                          sizeType: SizeType.small)),
                  _demoButton(
                      '44px - primary button - icon only - disable',
                      const NartusButton.primary(
                          iconPath: 'assets/facebook.svg',
                          iconPosition: IconPosition.right,
                          sizeType: SizeType.small)),
                ]),
                // secondary large
                ButtonsDemoPage(title: 'Secondary large', defaults: [
                  _demoButton('52px - secondary button - text only - active',
                      NartusButton.secondary(label: 'Button', onPressed: () {})),
                  _demoButton(
                      '52px - secondary button - left icon - active',
                      NartusButton.secondary(
                        label: 'Button',
                        iconPath: 'assets/facebook.svg',
                        onPressed: () {},
                      )),
                  _demoButton(
                      '52px - secondary button - right icon - active',
                      NartusButton.secondary(
                        label: 'Button',
                        iconPath: 'assets/facebook.svg',
                        onPressed: () {},
                        iconPosition: IconPosition.right,
                      )),
                  _demoButton(
                      '52px - secondary button - icon only - active',
                      NartusButton.secondary(
                        iconPath: 'assets/facebook.svg',
                        onPressed: () {},
                        iconPosition: IconPosition.right,
                      )),
                ], disabled: [
                  _demoButton('52px - secondary button - text only - disable',
                      const NartusButton.secondary(label: 'Button')),
                  _demoButton(
                      '52px - secondary button - left icon - disable',
                      const NartusButton.secondary(
                        label: 'Button',
                        iconPath: 'assets/facebook.svg',
                      )),
                  _demoButton(
                      '52px - secondary button - right icon - disable',
                      const NartusButton.secondary(
                        label: 'Button',
                        iconPath: 'assets/facebook.svg',
                        iconPosition: IconPosition.right,
                      )),
                  _demoButton(
                      '52px - secondary button - icon only - disable',
                      const NartusButton.secondary(
                        iconPath: 'assets/facebook.svg',
                        iconPosition: IconPosition.right,
                      )),
                ]),
                // secondary small
                ButtonsDemoPage(title: 'Secondary small', defaults: [
                  _demoButton(
                      '44px - secondary button - text only - active',
                      NartusButton.secondary(
                        label: 'Button',
                        onPressed: () {},
                        sizeType: SizeType.small,
                      )),
                  _demoButton(
                      '44px - secondary button - left icon - active',
                      NartusButton.secondary(
                          label: 'Button',
                          iconPath: 'assets/facebook.svg',
                          onPressed: () {},
                          sizeType: SizeType.small)),
                  _demoButton(
                      '44px - secondary button - right icon - active',
                      NartusButton.secondary(
                          label: 'Button',
                          iconPath: 'assets/facebook.svg',
                          onPressed: () {},
                          iconPosition: IconPosition.right,
                          sizeType: SizeType.small)),
                  _demoButton(
                      '44px - secondary button - icon only - active',
                      NartusButton.secondary(
                          iconPath: 'assets/facebook.svg',
                          onPressed: () {},
                          iconPosition: IconPosition.right,
                          sizeType: SizeType.small)),
                ], disabled: [
                  _demoButton(
                      '44px - secondary button - text only - disable',
                      const NartusButton.secondary(
                        label: 'Button',
                        sizeType: SizeType.small,
                      )),
                  _demoButton(
                      '44px - secondary button - left icon - disable',
                      const NartusButton.secondary(
                          label: 'Button',
                          iconPath: 'assets/facebook.svg',
                          sizeType: SizeType.small)),
                  _demoButton(
                      '44px - secondary button - right icon - disable',
                      const NartusButton.secondary(
                          label: 'Button',
                          iconPath: 'assets/facebook.svg',
                          iconPosition: IconPosition.right,
                          sizeType: SizeType.small)),
                  _demoButton(
                      '44px - secondary button - icon only - disable',
                      const NartusButton.secondary(
                          iconPath: 'assets/facebook.svg',
                          iconPosition: IconPosition.right,
                          sizeType: SizeType.small)),
                ]),
                // text large
                ButtonsDemoPage(title: 'Text large', defaults: [
                  _demoButton('52px - text button - text only - active',
                      NartusButton.text(label: 'Button', onPressed: () {})),
                  _demoButton(
                      '52px - text button - left icon - active',
                      NartusButton.text(
                        label: 'Button',
                        iconPath: 'assets/facebook.svg',
                        onPressed: () {},
                      )),
                  _demoButton(
                      '52px - text button - right icon - active',
                      NartusButton.text(
                        label: 'Button',
                        iconPath: 'assets/facebook.svg',
                        onPressed: () {},
                        iconPosition: IconPosition.right,
                      )),
                  _demoButton(
                      '52px - text button - icon only - active',
                      NartusButton.text(
                        iconPath: 'assets/facebook.svg',
                        onPressed: () {},
                        iconPosition: IconPosition.right,
                      )),
                ], disabled: [
                  _demoButton('52px - text button - text only - disable',
                      const NartusButton.text(label: 'Button')),
                  _demoButton(
                      '52px - text button - left icon - disable',
                      const NartusButton.text(
                        label: 'Button',
                        iconPath: 'assets/facebook.svg',
                      )),
                  _demoButton(
                      '52px - text button - right icon - disable',
                      const NartusButton.text(
                        label: 'Button',
                        iconPath: 'assets/facebook.svg',
                        iconPosition: IconPosition.right,
                      )),
                  _demoButton(
                      '52px - text button - icon only - disable',
                      const NartusButton.text(
                        iconPath: 'assets/facebook.svg',
                        iconPosition: IconPosition.right,
                      )),
                ]),
                // secondary small
                ButtonsDemoPage(title: 'Text small', defaults: [
                  _demoButton(
                      '44px - secondary button - text only - active',
                      NartusButton.text(
                        label: 'Button',
                        onPressed: () {},
                        sizeType: SizeType.small,
                      )),
                  _demoButton(
                      '44px - text button - left icon - active',
                      NartusButton.text(
                          label: 'Button',
                          iconPath: 'assets/facebook.svg',
                          onPressed: () {},
                          sizeType: SizeType.small)),
                  _demoButton(
                      '44px - text button - right icon - active',
                      NartusButton.text(
                          label: 'Button',
                          iconPath: 'assets/facebook.svg',
                          onPressed: () {},
                          iconPosition: IconPosition.right,
                          sizeType: SizeType.small)),
                  _demoButton(
                      '44px - text button - icon only - active',
                      NartusButton.text(
                          iconPath: 'assets/facebook.svg',
                          onPressed: () {},
                          iconPosition: IconPosition.right,
                          sizeType: SizeType.small)),
                ], disabled: [
                  _demoButton(
                      '44px - secondary button - text only - disable',
                      const NartusButton.text(
                        label: 'Button',
                        sizeType: SizeType.small,
                      )),
                  _demoButton(
                      '44px - text button - left icon - disable',
                      const NartusButton.text(
                          label: 'Button',
                          iconPath: 'assets/facebook.svg',
                          sizeType: SizeType.small)),
                  _demoButton(
                      '44px - text button - right icon - disable',
                      const NartusButton.text(
                          label: 'Button',
                          iconPath: 'assets/facebook.svg',
                          iconPosition: IconPosition.right,
                          sizeType: SizeType.small)),
                  _demoButton(
                      '44px - text button - icon only - disable',
                      const NartusButton.text(
                          iconPath: 'assets/facebook.svg',
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
          ]
        ));
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
