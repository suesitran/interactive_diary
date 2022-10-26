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
                ))
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
