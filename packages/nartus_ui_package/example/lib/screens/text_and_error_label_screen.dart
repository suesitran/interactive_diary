import 'package:flutter/material.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/widgets/text_error_label/text_and_error_label.dart';

class TextAndErrorLabelScreen extends StatelessWidget {
  TextAndErrorLabelScreen({Key? key}) : super(key: key);

  final ValueNotifier<bool> error = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text and Error Label demo'),
      ),
      body: Column(
        children: [
          const TextAndErrorLabel(label: '22 August 2022'),
          const SizedBox(
            height: NartusDimens.padding8,
          ),
          ValueListenableBuilder<bool>(
            valueListenable: error,
            builder: (context, showError, widget) => TextAndErrorLabel(
              label: '22 August 2022',
              error: 'No Internet connection',
              showError: showError,
            ),
          ),
          TextButton(
              onPressed: () {
                error.value = !error.value;
              },
              child: const Text('show/hide error'))
        ],
      ),
    );
  }
}
