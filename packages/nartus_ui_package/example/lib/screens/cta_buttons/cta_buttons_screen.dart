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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _demoButton('primary button - text only - active',
                NartusButton.primary(label: 'Button', onPressed: () {})),
            _demoButton(
                'primary button - left icon - active',
                NartusButton.primary(
                  label: 'Button',
                  icon: const Icon(Icons.account_balance_wallet),
                  onPressed: () {},
                )),
            _demoButton(
                'primary button - right icon - active',
                NartusButton.primary(
                  label: 'Button',
                  icon: const Icon(Icons.account_balance_wallet),
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
          children: [Text(label), widget],
        ),
      );
}
