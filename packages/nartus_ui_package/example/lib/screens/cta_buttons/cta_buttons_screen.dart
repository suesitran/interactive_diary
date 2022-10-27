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
                  icon: Image.asset('assets/facebook.png'),
                  onPressed: () {},
                )),
            _demoButton(
                '52px - primary button - right icon - active',
                NartusButton.primary(
                  label: 'Button',
                  icon: Image.asset('assets/facebook.png'),
                  onPressed: () {},
                  iconPosition: IconPosition.right,
                )),
            _demoButton(
                '52px - primary button - icon only - active',
                NartusButton.primary(
                  icon: Image.asset('assets/facebook.png',),
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
                  icon: Image.asset('assets/facebook.png', ),
                  onPressed: () {},
                    sizeType: SizeType.small
                )),
            _demoButton(
                '44px - primary button - right icon - active',
                NartusButton.primary(
                  label: 'Button',
                  icon: Image.asset('assets/facebook.png'),
                  onPressed: () {},
                  iconPosition: IconPosition.right,
                    sizeType: SizeType.small
                )),
            _demoButton(
                '44px - primary button - icon only - active',
                NartusButton.primary(
                  icon: Image.asset('assets/facebook.png',),
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
                  icon: Image.asset('assets/facebook_color.png'),
                  onPressed: () {},
                )),
            _demoButton(
                '52px - secondary button - right icon - active',
                NartusButton.secondary(
                  label: 'Button',
                  icon: Image.asset('assets/facebook_color.png'),
                  onPressed: () {},
                  iconPosition: IconPosition.right,
                )),
            _demoButton(
                '52px - secondary button - icon only - active',
                NartusButton.secondary(
                  icon: Image.asset('assets/facebook_color.png',),
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
                    icon: Image.asset('assets/facebook_color.png', ),
                    onPressed: () {},
                    sizeType: SizeType.small
                )),
            _demoButton(
                '44px - secondary button - right icon - active',
                NartusButton.secondary(
                    label: 'Button',
                    icon: Image.asset('assets/facebook_color.png'),
                    onPressed: () {},
                    iconPosition: IconPosition.right,
                    sizeType: SizeType.small
                )),
            _demoButton(
                '44px - secondary button - icon only - active',
                NartusButton.secondary(
                    icon: Image.asset('assets/facebook_color.png',),
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
                  icon: Image.asset('assets/facebook_color.png'),
                  onPressed: () {},
                )),
            _demoButton(
                '52px - text button - right icon - active',
                NartusButton.text(
                  label: 'Button',
                  icon: Image.asset('assets/facebook_color.png'),
                  onPressed: () {},
                  iconPosition: IconPosition.right,
                )),
            _demoButton(
                '52px - text button - icon only - active',
                NartusButton.text(
                  icon: Image.asset('assets/facebook_color.png',),
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
                    icon: Image.asset('assets/facebook_color.png', ),
                    onPressed: () {},
                    sizeType: SizeType.small
                )),
            _demoButton(
                '44px - text button - right icon - active',
                NartusButton.text(
                    label: 'Button',
                    icon: Image.asset('assets/facebook_color.png'),
                    onPressed: () {},
                    iconPosition: IconPosition.right,
                    sizeType: SizeType.small
                )),
            _demoButton(
                '44px - text button - icon only - active',
                NartusButton.text(
                    icon: Image.asset('assets/facebook_color.png',),
                    onPressed: () {},
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
