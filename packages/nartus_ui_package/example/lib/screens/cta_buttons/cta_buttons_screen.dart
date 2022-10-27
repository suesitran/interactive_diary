import 'package:flutter/material.dart';
import 'package:nartus_ui_package/widgets/buttons/nartus_button.dart';

class CTAButtonsScreen extends StatelessWidget {
  const CTAButtonsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('CTA Buttons demo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// ------------------------------------------------------------
            /// default - large primary button
            _demoButton(
                '52px - primary button - text only - active',
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
            /// ------------------------------------------------------------
            /// default - small primary button
            _demoButton(
                '44px - primary button - text only - active',
                NartusButton.primary(label: 'Button', onPressed: () {}, sizeType: SizeType.small,)),
            _demoButton(
                '44px - primary button - left icon - active',
                NartusButton.primary(
                  label: 'Button',
                    iconPath: 'assets/facebook.svg',
                  onPressed: () {},
                    sizeType: SizeType.small
                )),
            _demoButton(
                '44px - primary button - right icon - active',
                NartusButton.primary(
                  label: 'Button',
                    iconPath: 'assets/facebook.svg',
                  onPressed: () {},
                  iconPosition: IconPosition.right,
                    sizeType: SizeType.small
                )),
            _demoButton(
                '44px - primary button - icon only - active',
                NartusButton.primary(
                    iconPath: 'assets/facebook.svg',
                  onPressed: () {},
                  iconPosition: IconPosition.right,
                    sizeType: SizeType.small
                )),
            /// ------------------------------------------------------------
            /// default - large secondary button
            _demoButton(
                '52px - secondary button - text only - active',
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
            /// ------------------------------------------------------------
            /// default - small secondary button
            _demoButton(
                '44px - secondary button - text only - active',
                NartusButton.secondary(label: 'Button', onPressed: () {}, sizeType: SizeType.small,)),
            _demoButton(
                '44px - secondary button - left icon - active',
                NartusButton.secondary(
                    label: 'Button',
                    iconPath: 'assets/facebook.svg',
                    onPressed: () {},
                    sizeType: SizeType.small
                )),
            _demoButton(
                '44px - secondary button - right icon - active',
                NartusButton.secondary(
                    label: 'Button',
                    iconPath: 'assets/facebook.svg',
                    onPressed: () {},
                    iconPosition: IconPosition.right,
                    sizeType: SizeType.small
                )),
            _demoButton(
                '44px - secondary button - icon only - active',
                NartusButton.secondary(
                    iconPath: 'assets/facebook.svg',
                    onPressed: () {},
                    iconPosition: IconPosition.right,
                    sizeType: SizeType.small
                )),
            /// ------------------------------------------------------------
            /// default - large text button
            _demoButton(
                '52px - text button - text only - active',
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
            /// ------------------------------------------------------------
            /// default - small text button
            _demoButton(
                '44px - secondary button - text only - active',
                NartusButton.text(label: 'Button', onPressed: () {}, sizeType: SizeType.small,)),
            _demoButton(
                '44px - text button - left icon - active',
                NartusButton.text(
                    label: 'Button',
                    iconPath: 'assets/facebook.svg',
                    onPressed: () {},
                    sizeType: SizeType.small
                )),
            _demoButton(
                '44px - text button - right icon - active',
                NartusButton.text(
                    label: 'Button',
                    iconPath: 'assets/facebook.svg',
                    onPressed: () {},
                    iconPosition: IconPosition.right,
                    sizeType: SizeType.small
                )),
            _demoButton(
                '44px - text button - icon only - active',
                NartusButton.text(
                    iconPath: 'assets/facebook.svg',
                    onPressed: () {},
                    iconPosition: IconPosition.right,
                    sizeType: SizeType.small
                )),
            /// ------------------------------------------------------------
            /// disable - large primary button
            _demoButton(
                '52px - primary button - text only - disable',
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
            /// ------------------------------------------------------------
            /// default - small primary button
            _demoButton(
                '44px - primary button - text only - disable',
                const NartusButton.primary(label: 'Button', sizeType: SizeType.small,)),
            _demoButton(
                '44px - primary button - left icon - disable',
                const NartusButton.primary(
                    label: 'Button',
                    iconPath: 'assets/facebook.svg',
                    sizeType: SizeType.small
                )),
            _demoButton(
                '44px - primary button - right icon - disable',
                const NartusButton.primary(
                    label: 'Button',
                    iconPath: 'assets/facebook.svg',
                    iconPosition: IconPosition.right,
                    sizeType: SizeType.small
                )),
            _demoButton(
                '44px - primary button - icon only - disable',
                const NartusButton.primary(
                    iconPath: 'assets/facebook.svg',
                    iconPosition: IconPosition.right,
                    sizeType: SizeType.small
                )),
            /// ------------------------------------------------------------
            /// disable - large secondary button
            _demoButton(
                '52px - secondary button - text only - disable',
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
            /// ------------------------------------------------------------
            /// default - small secondary button
            _demoButton(
                '44px - secondary button - text only - disable',
                const NartusButton.secondary(label: 'Button', sizeType: SizeType.small,)),
            _demoButton(
                '44px - secondary button - left icon - disable',
                const NartusButton.secondary(
                    label: 'Button',
                    iconPath: 'assets/facebook.svg',
                    sizeType: SizeType.small
                )),
            _demoButton(
                '44px - secondary button - right icon - disable',
                const NartusButton.secondary(
                    label: 'Button',
                    iconPath: 'assets/facebook.svg',
                    iconPosition: IconPosition.right,
                    sizeType: SizeType.small
                )),
            _demoButton(
                '44px - secondary button - icon only - disable',
                const NartusButton.secondary(
                    iconPath: 'assets/facebook.svg',
                    iconPosition: IconPosition.right,
                    sizeType: SizeType.small
                )),
            /// ------------------------------------------------------------
            /// disable - large text button
            _demoButton(
                '52px - text button - text only - disable',
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
            /// ------------------------------------------------------------
            /// disable - small text button
            _demoButton(
                '44px - secondary button - text only - disable',
                const NartusButton.text(label: 'Button', sizeType: SizeType.small,)),
            _demoButton(
                '44px - text button - left icon - disable',
                const NartusButton.text(
                    label: 'Button',
                    iconPath: 'assets/facebook.svg',
                    sizeType: SizeType.small
                )),
            _demoButton(
                '44px - text button - right icon - disable',
                const NartusButton.text(
                    label: 'Button',
                    iconPath: 'assets/facebook.svg',
                    iconPosition: IconPosition.right,
                    sizeType: SizeType.small
                )),
            _demoButton(
                '44px - text button - icon only - disable',
                const NartusButton.text(
                    iconPath: 'assets/facebook.svg',
                    iconPosition: IconPosition.right,
                    sizeType: SizeType.small
                )),
          ],
        ),
      ),
    );
  }

  Widget _demoButton(String label, Widget widget) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Padding(padding: const EdgeInsets.only(bottom: 8.0), child: Text(label),), widget],
        ),
      );
}
