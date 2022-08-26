import 'package:flutter/material.dart';
import 'package:nartus_ui_package/widgets/text_and_error_label.dart';

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
          const SizedBox(height: 8.0,),
          const TextAndErrorLabel(label: '22 August 2022', error: 'No Internet connection', showError: true,),
          const SizedBox(height: 8.0,),
          ValueListenableBuilder<bool>(valueListenable: error, builder: (context, showError, widget) => TextAndErrorLabel(label: '22 August 2022', error: 'No Internet connection', showError: showError,),),
          TextButton(onPressed: () {
            error.value = !error.value;
          }, child: const Text('show/hide error'))
        ],
      ),
    );
  }
}
